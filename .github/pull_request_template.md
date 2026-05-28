## What does this PR do?
<!-- Explain the data problem this solves, not just what SQL you changed -->


## What changed?
<!-- List the models, seeds, or configs you touched -->
- 


## How did you test it?
<!-- e.g. "ran dbt test locally — all passed" -->


## Reviewer checklist
<!-- The reviewer ticks these before approving -->

- [ ] SQL is readable and follows team style
- [ ] Models have `not_null` and `unique` tests on primary keys
- [ ] Schema changes are backward-compatible (or migration plan is included)
- [ ] `schema.yml` descriptions are updated for new/changed columns
- [ ] No hardcoded dates, credentials, or environment-specific values
- [ ] PR description explains the *why*, not just the *what*
- [ ] CI is passing (all green before merging)
