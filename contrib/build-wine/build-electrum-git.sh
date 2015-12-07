#!/bin/bash

# You probably need to update only this link
ELECTRUM_GIT_URL=git://github.com/creditbit/electrum-creditbit.git
BRANCH=master
NAME_ROOT=electrum-creditbit


# These settings probably don't need any change
export WINEPREFIX=/opt/electrum

PYHOME=c:/python27
PYTHON="wine $PYHOME/python.exe -OO -B"


# Let's begin!
cd `dirname $0`
set -e

cd tmp

if [ -d "electrum-creditbit-git" ]; then
    # GIT repository found, update it
    echo "Pull"
    cd electrum-creditbit-git
    git checkout master
    git pull
    cd ..
else
    # GIT repository not found, clone it
    echo "Clone"
    git clone -b $BRANCH $ELECTRUM_GIT_URL electrum-creditbit-git
fi

cd electrum-creditbit-git
VERSION=2.3.0
echo "Last commit: $VERSION"

cd ..

rm -rf $WINEPREFIX/drive_c/electrum-creditbit
cp -r electrum-creditbit-git $WINEPREFIX/drive_c/electrum-creditbit
cp electrum-creditbit-git/LICENCE .

# add python packages (built with make_packages)
cp -r ../../../packages $WINEPREFIX/drive_c/electrum-creditbit/

# Build Qt resources
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/electrum-creditbit/icons.qrc -o C:/electrum-creditbit/lib/icons_rc.py
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/electrum-creditbit/icons.qrc -o C:/electrum-creditbit/gui/qt/icons_rc.py

cd ..

rm -rf dist/

# build standalone version
$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec

# build NSIS installer
wine "$WINEPREFIX/drive_c/Program Files/NSIS/makensis.exe" electrum.nsi

cd dist
mv electrum-creditbit.exe $NAME_ROOT-$VERSION.exe
mv electrum-creditbit-setup.exe $NAME_ROOT-$VERSION-setup.exe
mv electrum-creditbit $NAME_ROOT-$VERSION
zip -r $NAME_ROOT-$VERSION.zip $NAME_ROOT-$VERSION
cd ..

# build portable version
#cp portable.patch $WINEPREFIX/drive_c/electrum-creditbit
#pushd $WINEPREFIX/drive_c/electrum-creditbit
#patch < portable.patch 
#popd
#$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec
#cd dist
#mv electrum-creditbit.exe $NAME_ROOT-$VERSION-portable.exe
cd ..

echo "Done."
