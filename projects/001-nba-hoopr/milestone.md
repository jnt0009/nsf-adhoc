# 001-nba-hoopr — milestone

## Summary
The NSF's first project: NBA data through **hoopR** (sportsdataverse's prebuilt season files, ESPN's feeds
underneath), chosen 2026-11-19 over Sportradar, whose trial is evaluation-only and must be destroyed, derivatives
included, within 30 days of ending (its terms, §7.4). **The question is still to be set.**

---

### 2026-11-19 — scaffolded
- Made with `scripts/new-project` (the repo's first project, and the first run of that script).
- **Packages:** `renv` with the image's site library as an external library and explicit snapshots (`DESCRIPTION`
  declares hoopR): the project library holds only hoopR 3.1.0 and 5 dependencies; `renv.lock` pins its 52-package
  tree from the image's own CRAN snapshot (p3m 2026-11-17). Installs as binaries in seconds.
- **Data:** `code/make_data.R` caches player box, team box and schedule for seasons 2022-2026 (2021-22 to 2025-26)
  as parquet in `data/raw/`: 15 files, 6.7 MB, 40 s. ~34-35k player-game rows and ~2,640 team-game rows a season
  (two per game, so ~1,320 games, matching the schedules). ids kept as text. Play-by-play opt-in (`NBA_PBP=1`).
- **Next:** pick the question; then the EDA (grain, n, what the ~1,330 schedule rows include beyond the regular season).
