FROM archlinux/base

RUN pacman --noconfirm -Syu vim tmux git fish ripgrep openssh man \
     httpie jq ranger kubectl \
     spark lolcat bat
RUN fish_update_completion


# WORKDIR 

RUN git clone https://github.com/kskitek/dotfiles ~/.dotfiles
RUN cd ~/.dotfiles &&\
    git submodule update --init --remote --recursive &&\
    ln -s vimrc ~/.vimrc &&\
    ln -s vim ~/.vim &&\
    ln -s tmux.conf ~/.tmux.conf &&\
    cd ~

# RUN chsh fish

CMD ["tmux new -s dev"]
