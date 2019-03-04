FROM alpine

LABEL maintainer wzshiming@foxmail.com

WORKDIR /root/

RUN apk add -U --no-cache ca-certificates openssl tzdata \
    git make bash zsh vim tmux \
    curl wget openssh ctags shadow \
    go gcc nodejs ruby python3 docker

COPY .zshenv .

# Install https://github.com/amix/vimrc
RUN git clone --depth=1 https://github.com/amix/vimrc ~/.vim_runtime && \
    sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install https://github.com/robbyrussell/oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# Install https://github.com/samoshkin/tmux-config
RUN git clone https://github.com/samoshkin/tmux-config .tmux-config && \
    ./.tmux-config/install.sh

# Install docker-compose
RUN pip3 install docker-compose

# Cleanup
RUN rm -rf $(find .vim_runtime .oh-my-zsh .tmux | grep "/.git/")

RUN chsh -s /bin/zsh

CMD ["zsh", "-c", "tmux"]
