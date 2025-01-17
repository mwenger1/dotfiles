# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# load ASDF, falling back to rbenv if not available
if [ -d "$HOME/.asdf" ]; then
fi

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

ANDROID_SDK=$HOME/Library/Android/sdk
PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH

export -U PATH
