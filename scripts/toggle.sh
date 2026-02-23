#!/usr/bin/env bash
# Toggle a Claude Code management pane at the bottom of the current window

# Read resolved config
pane_size=$(tmux show-option -gqv @claude-pane-size-resolved)
pane_size="${pane_size:-25}"
prompt_file=$(tmux show-option -gqv @claude-prompt-file-resolved)
plugin_dir=$(tmux show-option -gqv @claude-plugin-dir)
prompt_file="${prompt_file:-$plugin_dir/scripts/prompt.txt}"

# Find the Claude pane in the current window by checking the @claude-pane user option
claude_pane=""
for pane_id in $(tmux list-panes -F '#{pane_id}'); do
  is_claude=$(tmux show-option -pqv -t "$pane_id" @claude-pane 2>/dev/null)
  if [ "$is_claude" = "1" ]; then
    claude_pane="$pane_id"
    break
  fi
done

if [ -n "$claude_pane" ]; then
  # Claude pane exists — toggle focus
  current_pane=$(tmux display-message -p '#{pane_id}')
  if [ "$current_pane" = "$claude_pane" ]; then
    tmux last-pane
  else
    tmux select-pane -t "$claude_pane"
  fi
else
  # Create a new Claude pane at the bottom
  system_prompt=""
  if [ -f "$prompt_file" ]; then
    system_prompt=$(cat "$prompt_file")
  fi

  if [ -n "$system_prompt" ]; then
    tmux split-window -v -l "${pane_size}%" "claude --system-prompt '$(echo "$system_prompt" | sed "s/'/'\\\\''/g")'"
  else
    tmux split-window -v -l "${pane_size}%" "claude"
  fi

  # Mark the new pane so we can find it later
  tmux set-option -p @claude-pane 1
fi
