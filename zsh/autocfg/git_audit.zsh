# !/usr/bin/env bash

# What changes the most — top 20 most-modified files in the last year
git-churn() {
  local since="${1:-1 year ago}"
  echo "==> Top 20 most-changed files since: $since"
  git log --format=format: --name-only --since="$since" \
    | sort | uniq -c | sort -nr | head -20
}

# Who built this — contributors ranked by commit count
# Pass a --since flag to narrow to a time window, e.g. git-authors --since="6 months ago"
git-authors() {
  echo "==> All-time contributors (no merges)"
  git shortlog -sn --no-merges "$@"
}

# Where do bugs cluster — files most mentioned in fix/bug commits
git-bugs() {
  echo "==> Top 20 bug-fix hotspots"
  git log -i -E --grep="fix|bug|broken" --name-only --format='' \
    | sort | uniq -c | sort -nr | head -20
}

# Is this project accelerating or dying — commit count by month
git-velocity() {
  echo "==> Commit count by month (full history)"
  git log --format='%ad' --date=format:'%Y-%m' \
    | sort | uniq -c
}

# How often is the team firefighting — reverts & hotfixes
git-fires() {
  local since="${1:-1 year ago}"
  echo "==> Reverts / hotfixes / rollbacks since: $since"
  git log --oneline --since="$since" \
    | grep -iE 'revert|hotfix|emergency|rollback'
}

# Run all five in sequence
git-audit() {
  echo "╔══════════════════════════════════════╗"
  echo "║         GIT CODEBASE AUDIT           ║"
  echo "╚══════════════════════════════════════╝"
  echo
  git-churn;    echo
  git-authors;  echo
  git-bugs;     echo
  git-velocity; echo
  git-fires
  echo
  echo "==> Done."
}
