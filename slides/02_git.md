---
title: "Intro to Git"
author: Jonathan Tannen
output: 
  beamer_presentation:
    theme: "metropolis"
    includes:
      in_header: "preamble.tex"
---

## Git terminology

- **Version Control**: Stores history of files ("versions") 
- **Distributed Version Control**: Remote source of truth, with local copies.
- **GitHub**: A private company (now Microsoft) with fancy tools integrating git.
- **Repository**: A self-contained project.  

---

## Getting Started
- Sign up at [github.com](https://github.com/)  
- Install and set up git (see https://docs.github.com/en/get-started/quickstart/set-up-git)  
- Install [GitHub CLI](https://github.com/cli/cli#installation) or UI.

--- 

## Your local workflow

- `git init`: Initiates git in whatever folder you're in, and all subfolders.
- Make changes to file(s).  
- `git status`: See what files you've changed.
- `git diff file1`: See what changes you've made to file1.
- `git add file1 file2`: Stage changes to be committed for file1, file2.
  - `git add .`: Stage *all* changes.  
- `git commit -m "Informative description here"`: Commit the changes.
- Repeat.

*Demo*

--- 

## Your remote workflow

Create and connect the repo
- `git init` your local repo.
- Create the repo in github
  - Option 1: In the github.com webview.
  - Option 2: `gh repo create`
- `git push --set-upstream origin HEAD`
  - Only need set-upstream the first time.

In general...
- `git pull`
- `git push`
- `git merge`

Some terminology...
- `origin/master`
- `master`

---

## Git Rules

1. Commits should be small (do one thing).
2. Commits should be complete (they should work).


