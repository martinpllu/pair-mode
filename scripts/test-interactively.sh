#!/usr/bin/env bash
set -euo pipefail

skill_dir=$(git rev-parse --show-toplevel)
test_dir="$skill_dir/pair-mode-test"

if [[ -L "$test_dir" ]]; then
  echo "Refusing to clean symlinked test workspace: $test_dir" >&2
  exit 1
fi

mkdir -p "$test_dir"
find "$test_dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +

git -C "$test_dir" init --quiet
printf '.agents/\n' >> "$test_dir/.git/info/exclude"
mkdir -p "$test_dir/.agents/skills"
ln -s "$skill_dir" "$test_dir/.agents/skills/pair-mode"

echo "Test workspace: $test_dir"

exec codex \
  --cd "$test_dir" \
  --dangerously-bypass-approvals-and-sandbox \
  --config 'features.fast_mode=true' \
  --config 'service_tier="fast"' \
  --config "projects.\"$test_dir\".trust_level=\"trusted\"" \
  'Use $pair-mode. Task: Starting from this empty directory, implement Conway'\''s Game of Life as a TypeScript web application using pnpm.'
