#!/usr/bin/env bash

mod.install() {
    ellipsis.backup ~/.emacs
    ellipsis.backup ~/.emacs.d
    ln -s $module_path $HOME/.emacs
    ln -s $module_path/.emacs.d $HOME/.emacs.d
}
