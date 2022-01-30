CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
# XXX ZSH_THEME_GIT_PROMPT_DIRTY=' ±'

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_venv
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

prompt_segment() {  # takes two arguments, bg and fg, both optional
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{cyan}%}$RETVAL"  # error
  # [[ $UID -eq 0 ]] && symbols+="%{%F{cyan}%}$"  # root
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}&"  # bg job(s)?
  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_context() {  # user@hostname if not local
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

prompt_venv() {
  if [ $VIRTUAL_ENV ]; then
    prompt_segment green black `basename $VIRTUAL_ENV`
  fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1

prompt_dir() {
  prompt_segment blue black '%~'
}

prompt_git() {  # branch/detached head, dirty status
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats '%u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//⭠ }${vcs_info_msg_0_}"
  fi
}

prompt_hg() {
	local rev status
	if $(hg id >/dev/null 2>&1); then
		if $(hg prompt >/dev/null 2>&1); then
			if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
				# if files are not added
				prompt_segment red white
				st='±'
			elif [[ -n $(hg prompt "{status|modified}") ]]; then
				# if any modification
				prompt_segment yellow black
				st='±'
			else
				# if working copy is clean
				prompt_segment green black
			fi
			echo -n $(hg prompt "⭠ {rev}@{branch}") $st
		else
			st=""
			rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
			branch=$(hg id -b 2>/dev/null)
			if `hg st | grep -Eq "^\?"`; then
				prompt_segment red black
				st='±'
			elif `hg st | grep -Eq "^(M|A)"`; then
				prompt_segment yellow black
				st='±'
			else
				prompt_segment green black
			fi
			echo -n "⭠ $rev@$branch" $st
		fi
	fi
}

prompt_end() {  # close open segments
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

PROMPT='%{%f%b%k%}$(build_prompt) '
