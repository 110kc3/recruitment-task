# Repository audit — 2026-11-07

Repository: `recruitment-task` · Agent: Codex

Audited source: [`8ab27ff`](https://github.com/110kc3/recruitment-task/commit/8ab27ffd04c9b2c55197cb55d722a0b1ef817cfa)

Evidence collected: 2026-11-06–2026-11-07. Chat item numbers: 25, 28.

This dated report preserves the findings and feature suggestions already reported in chat.
The owner authorized recording, committing and pushing this documentation. The findings
remain unresolved, and the proposed features have not been selected for implementation.
This is an evidence report, not a second accepted work queue. Existing project decisions,
accepted tasks and owner-only blockers remain authoritative in [README.md](../README.md).

## Verification status

The evidence below describes the earlier audit, including its limitations. This documentation
change does not claim to fix the findings or repeat every runtime reproduction. No production
account, database or infrastructure was changed by those isolated reproductions.

Documentation push: CI verification pending. Check the exact resulting commit on the next
session using [Actions](https://github.com/110kc3/recruitment-task/actions?query=branch%3Amain);
no run was awaited for this documentation update. A repository without a workflow has no
CI result to claim.

## 25. Environments share one Terraform state

Type: Open finding — not fixed. Priority: High. Estimated effort: Small.

Dev, staging and prod use the same Azure backend key app.tfstate and default workspace. Changing environment variables can reconcile or replace the previous environment's database instead of creating an independent deployment.

**Evidence:** Static review of [backend.tf](../terraform/backend.tf), [deploy.sh](../deploy.sh) and environment inputs. No Azure plan/apply was executed. [Terraform workspace documentation](https://developer.hashicorp.com/terraform/language/state/workspaces) explains state separation.

**Suggested change:** Select an explicit per-environment backend key or approved isolated-state strategy before deployment; do not migrate existing state blindly.

**Acceptance if selected:** Dev, staging and prod resolve to different state identities; changing one environment cannot include another's resources in its plan.

## 28. Helm password arguments break on commas

Type: Open finding — not fixed. Priority: Medium. Estimated effort: Small.

The deployment passes DB_PASSWORD through helm --set, whose value grammar treats commas as separators. A valid password containing a comma can stop deployment after infrastructure work.

**Evidence:** Normal synthetic passwords rendered all three charts; audit,pass123 failed with key pass123 has no value. See [deploy.sh](../deploy.sh). No real password is included.

**Suggested change:** Pass credentials through a correctly encoded values/secret mechanism; shell quoting alone does not escape Helm's value grammar.

**Acceptance if selected:** Passwords containing commas and other supported punctuation round-trip exactly; rendering does not reveal them in logs; normal deployments retain the intended value.
