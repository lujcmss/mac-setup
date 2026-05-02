#!/bin/sh
# Claude Code status line
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
version=$(echo "$input" | jq -r '.version // ""')
session_name=$(echo "$input" | jq -r '.session_name // ""')
effort=$(echo "$input" | jq -r '.effort.level // ""')
thinking=$(echo "$input" | jq -r '.thinking.enabled // ""')
vim_mode=$(echo "$input" | jq -r '.vim.mode // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // ""')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // ""')
rl_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // ""')
rl_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // ""')

# Context usage color
ctx_color="\033[36m"
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  [ "$used_int" -ge 50 ] && ctx_color="\033[33m"
  [ "$used_int" -ge 80 ] && ctx_color="\033[31m"
fi

# Rate limit color
rl_color_5h="\033[36m"
if [ -n "$rl_5h" ]; then
  rl_int=$(printf "%.0f" "$rl_5h")
  [ "$rl_int" -ge 50 ] && rl_color_5h="\033[33m"
  [ "$rl_int" -ge 80 ] && rl_color_5h="\033[31m"
fi

# Git branch + dirty flag
home="$HOME"
short_cwd="${cwd/#$home/~}"
git_part=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if ! git -C "$cwd" -c core.hooksPath=/dev/null diff --quiet 2>/dev/null \
       || ! git -C "$cwd" -c core.hooksPath=/dev/null diff --cached --quiet 2>/dev/null; then
      git_part="\033[33m ${branch}*\033[0m"
    else
      git_part="\033[32m ${branch}\033[0m"
    fi
  fi
fi

# 1. Dir + git
printf "\033[34m%s\033[0m%b" "$short_cwd" "$git_part"
# 2. Model + effort + thinking + vim
printf "  \033[35m%s\033[0m" "$model"
[ -n "$effort" ] && printf " \033[2m[%s]\033[0m" "$effort"
[ -n "$thinking" ] && [ "$thinking" = "true" ] && printf " \033[2m💭\033[0m"
[ -n "$vim_mode" ] && printf " \033[33m[%s]\033[0m" "$vim_mode"
# 2. Context %
[ -n "$used_pct" ] && printf "  ${ctx_color}ctx:%s%%\033[0m" "$(printf '%.0f' "$used_pct")"
# 3. Rate limits
[ -n "$rl_5h" ] && printf "  ${rl_color_5h}5h:%s%%\033[0m" "$(printf '%.0f' "$rl_5h")"
[ -n "$rl_7d" ] && printf " \033[2m7d:%s%%\033[0m" "$(printf '%.0f' "$rl_7d")"
# 4. Cost (integer)
if [ -n "$cost" ] && [ "$cost" != "null" ]; then
  cost_fmt=$(printf "%.2f" "$cost")
  printf "  \033[32m\$%s\033[0m" "$cost_fmt"
fi
