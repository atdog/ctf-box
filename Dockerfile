FROM phusion/baseimage:latest

# apt-get
RUN sed -i "s/archive.ubuntu.com/tw.archive.ubuntu.com/g" /etc/apt/sources.list
RUN dpkg --add-architecture i386 && apt-get update && apt-cache showpkg tmux && apt-get install -y \
    build-essential \
    autojump \
    gcc \
    gdb \
    git \
    libc6-i386 \
    libc6-dev-i386 \
    libssl-dev \
    ltrace \
    strace \
    make \
    man \
    nasm \
    nmap \
    python2.7 \
    python2.7-dev \
    python-pip \
    wget \
    tmux \
    vim

# qira
RUN cd ~/ && wget -qO- qira.me/dl | unxz | tar x \
    && cd qira && yes | ./install.sh

# enable ssh
RUN rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh

# add ssh public key
ADD ssh /root/.ssh

# dotfiles
RUN touch ~/.bash_history && \
        git clone https://github.com/atdog/rcfiles.git ~/.rcfiles && cd ~/.rcfiles && make basic

# ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
        curl -sSL https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm install 2.2.0
RUN /bin/bash --login -c "rvm use 2.2.0 --default && gem install rubypwn"
