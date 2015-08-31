FROM phusion/baseimage:latest

# apt-get
RUN apt-get update && apt-cache showpkg tmux && apt-get install -y \
    autojump \
    gcc \
    git \
    libc6-i386 \
    libc6-dev-i386 \
    libssl-dev \
    ltrace \
    make \
    man \
    nasm \
    nmap \
    python2.7 \
    python2.7-dev \
    python-pip \
    ruby \
    strace \
    wget \
    vim

# qira
RUN cd ~/ && wget -qO- qira.me/dl | unxz | tar x \
    && cd qira && yes | ./install.sh

# enable ssh
RUN rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh

# add ssh public key
ADD ssh /root/.ssh

# rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN rvm install 2.2.3
RUN rvm use 2.2.3 --default

# dotfiles
RUN git clone https://github.com/atdog/rcfiles.git ~/.rcfiles && cd ~/.rcfiles && make basic

