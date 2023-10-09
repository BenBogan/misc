# Check if nvm is installed, if not, install it
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
fi

# Ensure nvm command is loaded into shell
if ! command -v nvm &> /dev/null; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

NODE_VERSION="18"
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION

# .yarnrc config settings
YARN_CONFIG="nodeLinker: node-modules
httpProxy: http://llproxy.llan.ll.mit.edu:8080
httpsProxy: http://llproxy.llan.ll.mit.edu:8080"

# if the settings are not in the file, or the file does not exist, add them
if ! grep -qF "$YARN_CONFIG" $HOME/.yarnrc.yml 2>/dev/null; then
    echo "$YARN_CONFIG" > $HOME/.yarnrc.yml
fi

# if there is no yarn, install yarn
if ! which yarn > /dev/null; then
    npm install -g yarn@berry
fi

# Set yarn version
YARN_VERSION=3.6.1
if [ "$(yarn -v)" != "$YARN_VERSION" ]; then
    yarn set version $YARN_VERSION
fi
