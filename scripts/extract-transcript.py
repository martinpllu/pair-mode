#!/usr/bin/env python3
"""Extract a Codex session as a markdown transcript for review.

Usage:
  scripts/extract-transcript.py              # latest session -> traces/trace-<timestamp>-<id>.md
  scripts/extract-transcript.py <session-id> # id or any unique substring
  scripts/extract-transcript.py -o -         # print to stdout instead

Each trace gets a unique name derived from the session's timestamp and id,
and lands in traces/ (gitignored). Give feedback on a trace with crit, e.g.:

  crit traces/trace-2026-07-23T21-26-29-019f90a8.md
"""

import argparse
import json
import sys
from pathlib import Path

SESSIONS_DIR = Path.home() / ".codex" / "sessions"
TRACES_DIR = Path(__file__).resolve().parent.parent / "traces"

SKIP_MARKERS = ("# AGENTS.md instructions", "user_instructions")


def find_rollout(session: str | None) -> Path:
    rollouts = sorted(
        SESSIONS_DIR.glob("**/rollout-*.jsonl"),
        key=lambda p: p.stat().st_mtime,
        reverse=True,
    )
    if not rollouts:
        sys.exit(f"No rollout files found under {SESSIONS_DIR}")
    if session is None:
        return rollouts[0]
    matches = [p for p in rollouts if session in p.name]
    if not matches:
        sys.exit(f"No rollout file matching '{session}'")
    return matches[0]


def trace_name(rollout: Path) -> str:
    # rollout-2026-07-23T21-26-29-019f90a8-7de7-....jsonl
    stem = rollout.stem.removeprefix("rollout-")
    timestamp, session_id = stem[:19], stem[20:]
    return f"trace-{timestamp}-{session_id.split('-')[0]}.md"


def extract_messages(rollout: Path):
    for line in rollout.open():
        try:
            payload = json.loads(line).get("payload", {})
        except json.JSONDecodeError:
            continue
        if payload.get("type") != "message":
            continue
        role = payload.get("role")
        if role not in ("user", "assistant"):
            continue
        for item in payload.get("content", []):
            text = item.get("text", "")
            if not text or text.startswith("<"):
                continue
            if any(marker in text for marker in SKIP_MARKERS):
                continue
            yield role, text


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("session", nargs="?", help="session id or filename substring (default: latest)")
    parser.add_argument("-o", "--output", help="output path, or '-' for stdout (default: traces/<unique-name>.md)")
    parser.add_argument("-f", "--force", action="store_true", help="overwrite an existing trace file")
    args = parser.parse_args()

    rollout = find_rollout(args.session)
    lines = [f"# Transcript — {rollout.stem}", ""]
    turn = 0
    for role, text in extract_messages(rollout):
        turn += 1
        speaker = "User" if role == "user" else "Codex"
        lines += [f"## Turn {turn} — {speaker}", "", text, ""]
    output = "\n".join(lines)

    if args.output == "-":
        print(output)
        return

    path = Path(args.output) if args.output else TRACES_DIR / trace_name(rollout)
    if path.exists() and not args.force:
        sys.exit(f"{path} already exists (may hold review comments) — use --force to overwrite")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(output)
    print(f"Wrote {turn} turns to {path}")


if __name__ == "__main__":
    main()
