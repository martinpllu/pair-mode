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
printf '.claude/\n' >> "$test_dir/.git/info/exclude"
mkdir -p "$test_dir/.claude/skills"
ln -s "$skill_dir" "$test_dir/.claude/skills/pair-mode"

echo "Test workspace: $test_dir"

cd "$test_dir"
exec claude \
  --dangerously-skip-permissions \
  '/pair-mode Task: Starting from this empty directory, implement Conway'\''s Game of Life as a TypeScript web application using pnpm.'
