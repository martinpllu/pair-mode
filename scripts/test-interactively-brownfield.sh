#!/usr/bin/env bash
set -euo pipefail

readonly repository_url="https://github.com/immutable-js/immutable-js.git"
readonly base_commit="493afba6ec17d9c999dc5a15ac80c71c6bdba1c3"

skill_dir=$(git rev-parse --show-toplevel)
test_dir="$skill_dir/pair-mode-brownfield-test"

if [[ -L "$test_dir" ]]; then
  echo "Refusing to clean symlinked test workspace: $test_dir" >&2
  exit 1
fi

mkdir -p "$test_dir"
find "$test_dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +

git -C "$test_dir" init --quiet
git -C "$test_dir" remote add origin "$repository_url"
git -C "$test_dir" fetch --quiet --depth=1 origin "$base_commit"
git -C "$test_dir" checkout --quiet -b benchmark FETCH_HEAD
git -C "$test_dir" remote remove origin

printf '.agents/\n' >> "$test_dir/.git/info/exclude"
mkdir -p "$test_dir/.agents/skills"
ln -s "$skill_dir" "$test_dir/.agents/skills/pair-mode"

echo "Installing benchmark dependencies..."
npm --prefix "$test_dir" ci --no-audit --no-fund

echo "Test workspace: $test_dir"
echo "Benchmark: immutable-js__immutable-js-2006"

exec codex \
  --cd "$test_dir" \
  --dangerously-bypass-approvals-and-sandbox \
  --config 'features.fast_mode=true' \
  --config 'service_tier="fast"' \
  --config "projects.\"$test_dir\".trust_level=\"trusted\"" \
  'Use $pair-mode. Task: Fix a bug in Immutable.js where slicing a filtered sequence with a negative begin value is ignored.

For example:

Range(0, 10).filter(() => true).slice(-2).toArray()

currently returns [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], but should return [8, 9].

Add an appropriate regression test, implement the fix, and verify that the relevant test suite still passes.'
