ARG ubuntu_version=18.04
FROM ubuntu:${ubuntu_version}

RUN groupadd -r appgroup &&\
    useradd -m -r -g appgroup appuser

RUN mkdir -p /home/appuser
RUN chown -R appuser:appgroup /home/appuser
# RUN chown -R appuser:appgroup /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq &&\
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -qq -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends -y apt-utils autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y ca-certificates clang curl git libc++-dev libc++abi-dev libssl-dev libz-dev libomp-dev llvm llvm-6.0-dev &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y -qq &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean -y -qq &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

USER appuser
ENV HOME=/home/appuser
WORKDIR /home/appuser

ENV RBENV_ROOT=$HOME/.rbenv
## install rbenv
RUN git clone git://github.com/sstephenson/rbenv.git ${RBENV_ROOT} &&\
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ${HOME}/.bash_profile &&\
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile &&\
    git clone git://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build &&\
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ${HOME}/.bash_profile

ARG truffleruby_version=truffleruby-19.2.0.1
ENV TRUFFLERUBY_VERSION=$truffleruby_version

RUN . /home/appuser/.bash_profile &&\
    rbenv install ${TRUFFLERUBY_VERSION} &&\
    rbenv global ${TRUFFLERUBY_VERSION}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]