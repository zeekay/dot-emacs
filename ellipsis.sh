#!/usr/bin/env bash
#
# zeekay/dot-emacs
# My emacs configuration.

pkg.install() {
    ellipsis.backup ~/.emacs
    ellipsis.backup ~/.emacs.d
    ln -s $mod_path ~/.emacs
    ln -s $mod_path/.emacs.d ~/.emacs.d
}
