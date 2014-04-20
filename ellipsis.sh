#!/usr/bin/env bash

mod.install() {
    ellipsis.backup ~/.emacs
    ellipsis.backup ~/.emacs.d
    ln -s $mod_path ~/.emacs
    ln -s $mod_path/.emacs.d ~/.emacs.d
}
