---
name: preflight
description: Run a preflight check on uncommitted changes before committing. Use when the user wants to review changes, check code quality, or prepare for a commit/PR.
argument-hint: "[optional: specific files to check]"
allowed-tools: Bash(git *) Bash(grep *) Bash(wc *)
---

## Current Git Status

!`git status --short`

## Uncommitted Changes (Diff)

!`git diff --stat`

## Detailed Diff

!`git diff`

## TODO/FIXME/HACK Markers in Changed Files

!`git diff --name-only | xargs grep -n "TODO\|FIXME\|HACK" 2>/dev/null || echo "None found"`

## Kotlin Double-Bang (!!) Usage in Changed Files

!`git diff --name-only -- '*.kt' | xargs grep -n '!!' 2>/dev/null || echo "None found"`

## Review Checklist

Evaluate the changes above against our [checklist](checklist.md).

## Instructions

1. Summarize what changed (files, nature of change)
2. Walk through the checklist item by item, marking each as PASS, FAIL, or N/A
3. Flag any TODOs, FIXMEs, or `!!` usages found above
4. If any items FAIL, explain what needs fixing and suggest the fix
5. Give an overall verdict: Ready to commit, or Needs changes

If the user specified files via $ARGUMENTS, focus only on those files instead of the full diff.
