FROM alpine:3.8

LABEL maintainer wzshiming@foxmail.com

WORKDIR /root/

RUN apk add -U --no-cache ca-certificates openssl tzdata git vim bash zsh tmux curl wget shadow

COPY .vimrc.before.local .
COPY .zshenv .

# Install https://github.com/spf13/spf13-vim/tree/3.0
RUN sh -c "$(curl -fsSL https://j.mp/spf13-vim3)" || true

# Install https://github.com/robbyrussell/oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# Install https://github.com/samoshkin/tmux-config
RUN git clone https://github.com/samoshkin/tmux-config && \
    ./tmux-config/install.sh && \
    rm -rf ./tmux-config

# Cleanup
RUN rm -rf $(find .spf13-vim-3 .oh-my-zsh .tmux | grep "/.git/")

RUN chsh -s /bin/zsh

CMD zsh

