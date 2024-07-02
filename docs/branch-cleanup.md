# `git branch-cleanup`

Deletes local branches that have no remote.

Usage:

    git-branch-cleanup.ps1 [-force]

## Parameters

### `-force` (Optional)

If specified, allow deleting the branch irrespective of its merged status, or whether it even points to a valid commit.