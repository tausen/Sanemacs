#!/bin/sh

# Install Sanemacs with one fell swoop
# Example: curl http://vps3.tausen.org:90/bootstrap.sh | sh

mkdir -p ~/.emacs.d ~/.emacs.d/lib
curl http://vps3.tausen.org:90/sanemacs.el > ~/.emacs.d/sanemacs.el
curl http://vps3.tausen.org:90/tausen.el > ~/.emacs.d/tausen.el
curl http://vps3.tausen.org:90/lib/god-mode/god-mode.el > ~/.emacs.d/lib/god-mode.el

if [ -f ~/.emacs.d/init.el ]; then
    cp ~/.emacs.d/init.el ~/.emacs.d/init.el.backup
fi
echo "(load \"~/.emacs.d/sanemacs.el\")\n(load \"~/.emacs.d/tausen.el\")" > ~/.emacs.d/init.el

echo "Done!"
