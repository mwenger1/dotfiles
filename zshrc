# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michaelwenger/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/michaelwenger/Desktop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michaelwenger/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/michaelwenger/Desktop/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/anaconda3/bin:$PATH"
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

