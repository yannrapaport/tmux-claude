#!/usr/bin/env bash
# tmux-claude — TPM plugin entry point

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Read user-configurable options with defaults
claude_key=$(tmux show-option -gqv @claude-key)
claude_key="${claude_key:-i}"

claude_pane_size=$(tmux show-option -gqv @claude-pane-size)
claude_pane_size="${claude_pane_size:-25}"

claude_prompt_file=$(tmux show-option -gqv @claude-prompt-file)
claude_prompt_file="${claude_prompt_file:-$CURRENT_DIR/scripts/prompt.txt}"

# Store resolved values as tmux globals so toggle.sh can read them
tmux set-option -g @claude-pane-size-resolved "$claude_pane_size"
tmux set-option -g @claude-prompt-file-resolved "$claude_prompt_file"
tmux set-option -g @claude-plugin-dir "$CURRENT_DIR"

# Bind the toggle key
tmux bind-key "$claude_key" run-shell "$CURRENT_DIR/scripts/toggle.sh"
