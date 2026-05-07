# Add GOPATH to PATH
GOPATH=~/go
if [ -d $GOPATH ]; then
  GOBIN=$GOPATH/bin
  PATH=$GOBIN:$PATH
fi

if ! ( echo $PATH | grep ~/.local/bin ) >/dev/null; then
  PATH=~/.local/bin:$PATH
fi

# Setup preferred editor.
for editor in nvim vim vi; do
  if which $editor > /dev/null; then
    export EDITOR=$editor
    break
  fi
done
