# nsf-adhoc: the NSF's projects

JT's personal data science projects (README.md has the index). Worked inside the NSF lab: R 4.6 and Python 3.14
(`/opt/venv`, the "Python (NSF)" kernel) with the lab's base packages, Quarto, uv, git, gcloud, and `lab run` for long
jobs (at home, or in GCP with JT's OK). Personal work only: nothing from Honeylove comes in or goes out.

## A project

```
projects/NNN-short-name/
├── milestone.md        the project's journal: one dated entry per session, newest last
├── code/
│   ├── eda.Rmd         REQUIRED, even if only to say (with a date) why no EDA was warranted
│   ├── make_data.R     pulls and caches the data
│   └── *.Rmd / *.R     analysis
├── renv.lock           the project's own packages (beyond the image's base set)
├── data/               not committed: data/raw/ as pulled, never edited; the rest derived
└── artifacts/          not committed: figures, models, rendered reports
```

- **Start one with `scripts/new-project <name>`**, never by hand: it takes the next number and adds the index row.
- **Packages:** the base set is in the image. A package only this project needs goes in the project's `renv`
  (`renv::install()`, then `renv::snapshot()`); it installs as a binary from the lab's pinned CRAN snapshot. Python:
  `uv` in the project folder. Never install into the image's libraries.
- **Data is never committed.** Each lab (and each GCP run) starts from a fresh clone, so `data/` doesn't follow you
  between machines: `make_data.R` must be able to rebuild it, and it caches as parquet.
- **Paths:** relative to the project folder (`here::i_am()` in each script), never `/work/...` or `~`.
- **Secrets** come from the environment; never write a key into a file.

## The analysis standards (from work; they apply here)

- **EDA before modelling**, in `code/eda.Rmd`: n at every stage with its denominator, the unit of a row, every
  hardcoded level set asserted against the data, base rates for any share quoted, missingness and what it means,
  the outcome over time.
- **A row may not be the unit you think it is**: check the grain before any sum or per-player / per-game claim.
- **Report n with every coefficient**; flag small subgroups. **Probabilities over odds ratios.**
- **Charts:** Okabe-Ito (#0072B2, #E69F00, #56B4E9, #D55E00, #AAAAAA); render and look at the output before calling it done.
- **Conclusion first** in any write-up: the finding and the number that carries it, then the method and caveats.

## Working here as an agent

- **Run the code you change** and look at its output before saying it works.
- **Git:** commit on a branch named `agent/<short-task>` and push that branch; JT merges it as a pull request. GitHub
  refuses direct pushes to `main` and force-pushes there (a ruleset), so don't try to work around a refusal.
- **Jobs:** at home freely (`lab run`). **Anything in GCP that costs money needs JT's OK first:** ask, and stop.
- **Done means:** the branch pushed, `milestone.md` updated, and a short summary of what changed, what ran, what's left.
