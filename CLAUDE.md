# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A hand-maintained bash completion file for the `claude` CLI (Claude Code). The upstream `claude-code` Homebrew cask ships no completions, so this fills the gap.

## Installation

### Homebrew (primary)

```bash
brew install arjuhe/tap/claude-completion
```

This installs into `/opt/homebrew/etc/bash_completion.d/claude` via bash-completion@2.

### Manual (development)

Symlink into the bash-completion 2.x user directory:

```
~/.local/share/bash-completion/completions/claude -> ~/proj/arjuhe/claude-completion/claude.bash
```

## Testing changes

Source the file and exercise tab completion:

```bash
source claude.bash
claude <TAB>          # should list subcommands
claude --<TAB>        # should list global options
claude --effort <TAB> # should list: low medium high xhigh max
```

## Updating

Options, subcommands, and their allowed values are derived from `claude --help` (and `claude <subcommand> --help`). When updating for a new CLI version, diff the help output against what's in `claude.bash` and update the relevant word lists.

The completion uses bash-completion's `_init_completion` — do not add a standalone `compopt`/`COMPREPLY` path that bypasses it.
