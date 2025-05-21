# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# Start the SSH agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(keychain --eval --agents ssh id_ed25519)
fi

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# . $(brew --prefix asdf)/bin/asdf
# export ASDF_DIR=$(brew --prefix asdf)
# export PATH="$ASDF_DIR/bin:$PATH"
# . $ASDF_DIR/libexec/asdf.sh
# export ASDF_DIR=$(brew --prefix asdf)
# export PATH="$ASDF_DIR/bin:$PATH"
# export PATH="$ASDF_DIR/shims:$PATH"
# . $ASDF_DIR/libexec/asdf.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# . /opt/homebrew/opt/asdf/libexec/asdf.sh
. $(brew --prefix asdf)/libexec/asdf.sh

# Created by `pipx` on 2025-02-20 17:05:37
export PATH="$PATH:/Users/mike/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mike/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mike/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mike/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mike/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:$HOME/dev/fullstack/source_builder_agent/bin"

