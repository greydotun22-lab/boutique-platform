#!/usr/bin/env bash
# validate_layout.sh - fail if the repo drifts from the agreed monorepo layout
set -uo pipefail

errors=0
fail() { echo "FAIL: $*"; errors=$((errors + 1)); }

for dir in src/*/; do
  svc=$(basename "$dir")

  # every service except redis builds its own image
  if [[ "$svc" != "redis" ]] && [[ -z "$(find "$dir" -maxdepth 2 -name Dockerfile -print -quit)" ]]; then
    fail "src/$svc has no Dockerfile"
  fi
  [[ -f "$dir/Jenkinsfile" ]] || fail "src/$svc has no Jenkinsfile"

  for env in test-env prod-env; do
    [[ -f "kubernetes/$env/$svc/deployment.yaml" ]] || fail "kubernetes/$env/$svc/deployment.yaml missing"
  done
done

for env in test-env prod-env; do
  [[ -f "kubernetes/$env/namespace.yaml" ]] || fail "kubernetes/$env/namespace.yaml missing"
done

[[ -z "$(find src -type d -name deploy-envs)" ]] || fail "old deploy-envs folders still under src/"
[[ -z "$(find . -name '.env' -not -path './.git/*')" ]] || fail ".env file committed"
[[ -z "$(find . -type f -size +20M -not -path './.git/*')" ]] || fail "file larger than 20 MB"

if (( errors > 0 )); then
  echo "$errors problem(s) found"; exit 1
fi
echo "Layout OK: $(find src -mindepth 1 -maxdepth 1 -type d | wc -l) services, $(find kubernetes -name '*.yaml' | wc -l) manifests"
