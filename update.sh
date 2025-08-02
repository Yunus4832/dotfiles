#!/bin/bash

DOTFILES_DIR=$(pwd)

#-----------------------------------------------------
# Tmux 配置                                          -
#-----------------------------------------------------

# 复制 tmux 的配置文件到用户目录
if command -v tmux &> /dev/null; then
    echo "Copy tmux config to $HOME..."
    cp $DOTFILES_DIR/tmux/.tmux.conf*  $HOME/
    echo done
fi

#-----------------------------------------------------
# zsh  配置                                          -
#-----------------------------------------------------

# 复制 oh-my-zsh 的配置文件到用户目录
if command -v zsh &> /dev/null; then
    echo "Copy zsh config to $HOME..."
    cp $DOTFILES_DIR/zsh/.zshrc $HOME/
    echo done
fi

#-----------------------------------------------------
# Git 配置                                           -
#-----------------------------------------------------

# 复制 git 的全局配置文件到用户目录
if command -v git &> /dev/null; then 
    echo "Copy git global config to $HOME..."
    cp $DOTFILES_DIR/git/.gitconfig $HOME/

    read -p"Disable autocrlf (Y/n):" system_type

    if [[ $system_type == [nN] ]];
    then
        sed -i 's!\(autocrlf\s\?=\s\?\).*!\1true!g' $HOME/.gitconfig
    fi
    echo done
fi

#-----------------------------------------------------
# vim 配置                                           -
#-----------------------------------------------------

# 复制 vim 的配置文件到用户目录或者自定义目录
if command -v vim &> /dev/null; then
    echo "Copy vim config to $HOME..."
    cp $DOTFILES_DIR/vim/.vimrc $HOME/

    # 如果 Vim 的版本大于 9, 将 Vim9 的配置赋值到 HOME 目录
    vim_version=$(vim --version | sed -n "1{s/.* \([0-9]\+\.[0-9]\+\).*/\1/p;q}")
    if [[ $vim_version > "9.0" || $vim_version == "9.0" ]]; 
    then
        cp $DOTFILES_DIR/vim/.vimrc9 $HOME/
    fi

    # 复制 vim 本地配置到用户目录
    echo "Copy .vim dirctory to $HOME..."
    cp -r $DOTFILES_DIR/vim/.vim $HOME

    # 配置插件目录
    read -p"Input the Plug dir(default user home):" plug_dir
    if [[ -z $plug_dir ]];
    then
        plug_dir=$DOTFILES_DIR/vim/vim-plug
    fi

    echo "Edit plug_dir in .vimrc"
    echo "Config plug_dir to $plug_dir..."
    sed -i 's!^let g:my_plug_dir = \".*\"$!let g:my_plug_dir = \"'$plug_dir'\"!g' $HOME/.vimrc
    echo done
fi

#-----------------------------------------------------
# sway 配置                                          -
#-----------------------------------------------------

if command -v sway &> /dev/null; then
    echo "Copy sway config to $HOME/.config/sway..."
    cp -r $DOTFILES_DIR/.config/sway $HOME/.config
    echo done
fi

#-----------------------------------------------------
# river 配置                                         -
#-----------------------------------------------------

if command -v river &> /dev/null; then
    echo "Copy river config to $HOME/.config/river..."
    cp -r $DOTFILES_DIR/.config/river $HOME/.config
    echo done
fi

#-----------------------------------------------------
# river 配置                                         -
#-----------------------------------------------------

if command -v hyprland &> /dev/null; then
    echo "Copy hyprland config to $HOME/.config/hypr..."
    cp -r $DOTFILES_DIR/.config/hypr $HOME/.config
    echo done
fi

#-----------------------------------------------------
# waybar 配置                                        -
#-----------------------------------------------------

if command -v waybar &> /dev/null; then
    echo "Copy waybar config to $HOME/.config/waybar..."
    cp -r $DOTFILES_DIR/.config/waybar $HOME/.config
    echo done
fi

#-----------------------------------------------------
# wallpaper 配置                                     -
#-----------------------------------------------------

if command -v swaybg &> /dev/null; then
    echo "Copy wallpapers config to $HOME/.config/wallpapers..."
    cp -r $DOTFILES_DIR/.config/wallpapers $HOME/.config
    echo done
fi

#-----------------------------------------------------
# rofi 配置                                          -
#-----------------------------------------------------

if command -v rofi &> /dev/null; then
    echo "Copy rofi config to $HOME/.config/rofi..."
    cp -r $DOTFILES_DIR/.config/rofi $HOME/.config
    echo done
fi

echo config done


