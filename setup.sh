#!/bin/sh

echo "setting up emacs config"

# if setup is run from dot-files/setup.sh use basedir provided
if [ "$repo_basedir" ]; then
    basedir=$repo_basedir
else
    basedir="$( cd -P "$( dirname "$0" )" && pwd )"
fi

# remove previous configuration and link to destination if not cloned directly there
if [ "$basedir" != "$HOME/.emacs" ]; then
    echo "...removing previous configuration"
    rm -rf ~/.emacs
    rm -rf ~/.emacs.d

    echo "...linking ~/.emacs ~/.emacs.d"
    ln -s $basedir ~/.emacs
    ln -s $basedir/emacs.d ~/.emacs.d
else
    echo "...removing previous configuration"
    rm ~/.emacs.d

    echo "...linking ~/.emacs.d"
    ln -s $basedir/emacs.d ~/.emacs.d
fi

# would be nice to automate installing external libs
echo '...done!'
