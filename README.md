# tmux-claude

A TPM plugin that adds a toggleable Claude Code pane to tmux, preconfigured as a tmux management assistant.

Press `prefix + i` to open, focus, or unfocus a Claude pane at the bottom of your current window. Claude launches with context that makes it an expert tmux helper — it can inspect your sessions, manage windows and panes, fix config issues, and more.

## Installation

### With [TPM](https://github.com/tmux-plugins/tpm)

Add to your `~/.tmux.conf`:

```bash
set -g @plugin 'yannrapaport/tmux-claude'
```

Then press `prefix + I` to install.

### Manual

```bash
git clone https://github.com/yannrapaport/tmux-claude.git ~/.tmux/plugins/tmux-claude
```

Add to your `~/.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/tmux-claude/claude.tmux
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI (`claude`) must be installed and on your PATH

## Configuration

All options are set in `~/.tmux.conf` before the TPM `run` line:

| Option | Default | Description |
|--------|---------|-------------|
| `@claude-key` | `i` | Key to bind (after prefix) for toggling the Claude pane |
| `@claude-pane-size` | `25` | Pane height as a percentage of the window |
| `@claude-prompt-file` | built-in `prompt.txt` | Path to a custom system prompt file |

### Example

```bash
set -g @claude-key 'C'
set -g @claude-pane-size '30'
set -g @claude-prompt-file '~/my-claude-prompt.txt'
```

## Usage

- **`prefix + i`** (default) — Toggle the Claude pane
  - If no Claude pane exists: opens one at the bottom
  - If a Claude pane exists but isn't focused: focuses it
  - If the Claude pane is focused: returns focus to the previous pane

## License

MIT
