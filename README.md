# claude-completion

Bash completion for the [Claude Code](https://claude.ai/code) CLI.

The upstream `claude-code` Homebrew cask ships no completions, so this fills the gap.

## Install

### Homebrew

```bash
brew install arjuhe/tap/claude-completion
```

### Manual

Copy `claude.bash` into your bash-completion directory:

```bash
cp claude.bash ~/.local/share/bash-completion/completions/claude
```

Or source it directly in your `~/.bashrc`:

```bash
source /path/to/claude.bash
```

## What gets completed

- Subcommands: `agents`, `attach`, `auth`, `doctor`, `mcp`, `plugin`, `update`, etc.
- Global options: `--model`, `--effort`, `--permission-mode`, `--output-format`, etc.
- Option values: `--effort low|medium|high|xhigh|max`, `--model fable|opus|sonnet|haiku`, etc.
- Subcommand-specific options: `claude agents --json`, `claude install stable|latest`, etc.

## Requirements

- [bash-completion@2](https://github.com/scop/bash-completion) (bash 4.2+)

## License

MIT
