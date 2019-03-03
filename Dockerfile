FROM alpine

LABEL maintainer wzshiming@foxmail.com

WORKDIR /root/

RUN apk add -U --no-cache ca-certificates openssl tzdata \
    git make bash zsh vim tmux \
    curl wget openssh ctags shadow \
    go gcc nodejs ruby python3 docker

COPY .vimrc.before.local .
COPY .zshenv .

# Install https://github.com/wzshiming/my-vim
RUN git clone https://github.com/wzshiming/my-vim .my-vim && \
    ./.my-vim/install.sh

# Install https://github.com/robbyrussell/oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# Install https://github.com/samoshkin/tmux-config
RUN git clone https://github.com/samoshkin/tmux-config .tmux-config && \
    ./.tmux-config/install.sh

# Install docker-compose
RUN pip3 install docker-compose

# Cleanup
RUN rm -rf $(find .my-vim .oh-my-zsh .tmux | grep "/.git/")

RUN chsh -s /bin/zsh

CMD ["zsh", "-c", "tmux"]
