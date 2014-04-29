#!/usr/bin/env bash
#
# zeekay/dot-emacs
#
# My emacs configuration.

pkg.install() {
    fs.backup ~/.emacs
    fs.backup ~/.emacs.d
    ln -s $PKG_PATH ~/.emacs
    ln -s $PKG_PATH/.emacs.d ~/.emacs.d
}
