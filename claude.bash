# bash completion for claude (Claude Code CLI)

_claude() {
    local cur prev words cword
    _init_completion || return

    local commands="agents attach auth auto-mode doctor gateway import install logs mcp plugin plugins purge respawn rm setup-token stop kill ultrareview update upgrade"

    local global_opts="
        --add-dir
        --agent
        --agents
        --allow-dangerously-skip-permissions
        --allowedTools --allowed-tools
        --append-system-prompt
        --autocompact
        --ax-screen-reader
        --bg --background
        --bare
        --betas
        --brief
        --chrome
        --cloud
        -c --continue
        --dangerously-skip-permissions
        -d --debug
        --debug-file
        --desktop
        --disable-slash-commands
        --disallowedTools --disallowed-tools
        --effort
        --environment
        --exclude-dynamic-system-prompt-sections
        --fallback-model
        --file
        --fork-session
        --forward-subagent-text
        --from-pr
        -h --help
        --ide
        --include-hook-events
        --include-partial-messages
        --input-format
        --json-schema
        --max-budget-usd
        --mcp-config
        --model
        -n --name
        --no-chrome
        --no-session-persistence
        --output-format
        --permission-mode
        --permission-prompts
        --plugin-dir
        --plugin-url
        -p --print
        --prompt-suggestions
        --remote-control
        --remote-control-session-name-prefix
        --replay-user-messages
        --restricted
        -r --resume
        --safe-mode
        --session-id
        --setting-sources
        --settings
        --strict-mcp-config
        --system-prompt
        --system-prompt-snapshot
        --teleport
        --tmux
        --tools
        --verbose
        -v --version
        -w --worktree
    "

    # Identify the subcommand (first non-option word after "claude")
    local subcmd=""
    local i
    for (( i=1; i < cword; i++ )); do
        case "${words[i]}" in
            -*) ;;
            *)
                local w="${words[i]}"
                case " $commands " in
                    *" $w "*) subcmd="$w"; break ;;
                esac
                ;;
        esac
    done

    # Complete option arguments
    case "$prev" in
        --effort)
            COMPREPLY=( $(compgen -W "low medium high xhigh max" -- "$cur") )
            return
            ;;
        --model|--fallback-model)
            COMPREPLY=( $(compgen -W "fable opus sonnet haiku" -- "$cur") )
            return
            ;;
        --input-format)
            COMPREPLY=( $(compgen -W "text stream-json" -- "$cur") )
            return
            ;;
        --output-format)
            COMPREPLY=( $(compgen -W "text json stream-json" -- "$cur") )
            return
            ;;
        --permission-mode)
            COMPREPLY=( $(compgen -W "acceptEdits auto bypassPermissions manual dontAsk plan" -- "$cur") )
            return
            ;;
        --permission-prompts)
            COMPREPLY=( $(compgen -W "host none" -- "$cur") )
            return
            ;;
        --prompt-suggestions)
            COMPREPLY=( $(compgen -W "true false yes no on off 1 0" -- "$cur") )
            return
            ;;
        --system-prompt-snapshot)
            COMPREPLY=( $(compgen -W "on off" -- "$cur") )
            return
            ;;
        --autocompact)
            COMPREPLY=( $(compgen -W "auto" -- "$cur") )
            return
            ;;
        --debug-file|--plugin-dir|--add-dir)
            _filedir
            return
            ;;
        --mcp-config|--settings)
            _filedir
            return
            ;;
    esac

    # Subcommand-specific completions
    if [[ -n "$subcmd" ]]; then
        case "$subcmd" in
            agents)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "
                        --add-dir --agent --all
                        --allow-dangerously-skip-permissions
                        --cwd --dangerously-skip-permissions
                        --effort -h --help --json
                        --mcp-config --model
                        --permission-mode --plugin-dir
                        --restricted --setting-sources
                        --settings --strict-mcp-config
                    " -- "$cur") )
                fi
                return
                ;;
            attach|logs|rm|stop|kill)
                return
                ;;
            import)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
                fi
                return
                ;;
            install)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
                else
                    COMPREPLY=( $(compgen -W "stable latest" -- "$cur") )
                fi
                return
                ;;
            purge)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
                else
                    _filedir -d
                fi
                return
                ;;
            respawn)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "--all -h --help" -- "$cur") )
                fi
                return
                ;;
            ultrareview)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
                fi
                return
                ;;
            mcp|plugin|plugins|auth|auto-mode|doctor|gateway|setup-token|update|upgrade)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $(compgen -W "-h --help" -- "$cur") )
                fi
                return
                ;;
        esac
    fi

    # Top-level: complete subcommands or options
    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $(compgen -W "$global_opts" -- "$cur") )
    else
        COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
    fi
} &&
complete -F _claude claude
