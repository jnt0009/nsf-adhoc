# 001-nba-hoopr: pull NBA data with hoopR and cache it under data/raw/ (never committed; this script rebuilds it).
#
# Source: hoopR's prebuilt releases (sportsdataverse), ESPN's feeds underneath: one file per season, downloaded, not an
# API crawl. A "season" is named by the year it ends: 2025 = 2024-25.
#
#   Rscript code/make_data.R                     the default seasons, box scores and schedules
#   NBA_SEASONS=2015:2026 NBA_PBP=1 Rscript code/make_data.R    more seasons, and play-by-play (~625k rows a season)
#
# Each table is one parquet per season (data/raw/<table>_<season>.parquet); a season already cached is skipped unless
# it's the current one (still being played) or NBA_REFRESH=1.
here::i_am("code/make_data.R")
suppressPackageStartupMessages({ library(dplyr); library(hoopR) })

seasons <- eval(parse(text = Sys.getenv("NBA_SEASONS", "2022:2026")))
with_pbp <- Sys.getenv("NBA_PBP") == "1"
refresh <- Sys.getenv("NBA_REFRESH") == "1"
current <- most_recent_nba_season()
stopifnot(is.numeric(seasons), all(seasons >= 2002), all(seasons <= current))

raw <- here::here("data", "raw")
dir.create(raw, recursive = TRUE, showWarnings = FALSE)

loaders <- list(player_box = load_nba_player_box, team_box = load_nba_team_box, schedule = load_nba_schedule)
if (with_pbp) loaders$pbp <- load_nba_pbp

log <- list()
for (table in names(loaders)) for (s in seasons) {
  path <- file.path(raw, sprintf("%s_%d.parquet", table, s))
  if (file.exists(path) && !refresh && s != current) {
    log[[length(log) + 1]] <- tibble(table, season = s, rows = NA_integer_, status = "cached")
    next
  }
  df <- loaders[[table]](seasons = s)
  # ids lose precision as doubles; keep them as text (the work lesson: order_id overflowed to NA in R)
  df <- mutate(df, across(any_of(c("game_id", "athlete_id", "team_id", "opponent_team_id", "id")), as.character))
  stopifnot(nrow(df) > 0)
  arrow::write_parquet(df, path)
  log[[length(log) + 1]] <- tibble(table, season = s, rows = nrow(df), status = "pulled")
}
print(bind_rows(log), n = Inf)
