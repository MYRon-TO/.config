source ~/.bashrc

# * Env
# ** Editor
export EDITOR='nvim'

# ** $PATH.
export PATH=$HOME/bin:$HOME/.config/scripts:/usr/local/bin:$HOME/.cargo/bin/:$HOME/go/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH

export PATH=$HOME/Git/dev_bin:$PATH

# ** Flutter
export PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub;
export FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter

# ** DarkMode
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark.

# * Fcitx5
# export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export QT_WAYLAND_TEXT_INPUT_PROTOCOL=zwp_text_input_v3

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland

# * unity
# export SDL_VIDRODRIVER=x11

# for kitty
export GLFW_IM_MODULE=ibus
export TERM=xterm-256color

# TeX
export TEXMFHOME=$HOME/.local/share/texmf
export MANPATH=$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info
export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH

# npm
PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"

# * Alias
alias q="exit"
alias s="neofetch"
alias lg="lazygit"
alias py="python3"
alias split_wallpaper="python ~/.script/split_wallpaper.py"
alias earphone="bluetoothctl connect 88:C9:E8:BA:C1:8C"
alias keyboard="bluetoothctl connect F1:EF:01:DE:A7:D6"
alias doom="~/.config/emacs/bin/doom"
# alias webui="docker start open-webui"
alias lzd="lazydocker"
# alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# * mirror list
# ** go
go env -w GO111MODULE=on
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct

# ** pnpm
export PNPM_HOME="/home/Myron/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# * zinit (plugin manager)

# ** Download plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
# zinit snippet OMZP::z
zinit snippet OMZP::web-search
zinit snippet OMZP::history

# ** vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    OMZ::plugins/git \
    # OMZP::z
### End of Zinit's installer chunk

zinit ice wait lucid
zinit light-mode for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

# zinit ice wait atload'_history_substring_search_config'
# zinit load 'zsh-users/zsh-history-substring-search'

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          depth"1" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# update zinit: zinit self-update

# * Fix the issue of zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# ###########################################################################################################

autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# * zoxide
eval "$(zoxide init zsh)"

# * fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#1e1e2e,bg+:#262626
  --color=hl:#f38ba8,hl+:#5fd7ff,info:#cba6f7,marker:#b4befe
  --color=prompt:#cba6f7,spinner:#f5e0dc,pointer:#f5e0dc,header:#f38ba8
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="⪢ "
  --marker="> " --pointer="⪢ " --separator="-" --scrollbar="│"
  --info="right"'

[ -f /opt/miniforge/etc/profile.d/conda.sh ] && source /opt/miniforge/etc/profile.d/conda.sh
