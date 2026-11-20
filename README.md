# nsf-adhoc: the National Science Foundation's projects

JT's personal data science projects, one numbered folder each, worked in the NSF lab
([ds-lab](https://github.com/jnt0009/ds-lab): the image, `lab run`, the labs on the Mac and battlestation, jobs in GCP).
The same shape as the ad-hoc repo at work. Personal work only.

- **A new project:** `scripts/new-project <short-name>` makes `projects/NNN-<short-name>/` with the next number, the
  required `code/eda.Rmd` and `milestone.md`, and a row in the index below. Then fill in the row.
- **A project that outgrows this repo** gets its own repo (`git subtree split --prefix projects/NNN-name`, keeping its
  history) and a tailored lab, a department of the NSF built `FROM` the base image.
- **Conventions** (packages, data, agents, the analysis standards): `CLAUDE.md`.

## Index

| # | Project | Question | Data | Status |
| - | - | - | - | - |
| 001 | `projects/001-nba-hoopr` | (to be set: the first NBA question) | hoopR (sportsdataverse releases, ESPN underneath) | data pulled 2026-11-19 |
