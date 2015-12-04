Electrum - lightweight Bitcoin client
=====================================

::

  Licence: GNU GPL v3
  Author: Thomas Voegtlin
  Language: Python
  Homepage: https://electrum.org/


.. image:: https://travis-ci.org/spesmilo/electrum.svg?branch=master
    :target: https://travis-ci.org/spesmilo/electrum
    :alt: Build Status


1. GETTING STARTED
------------------

To run Electrum-Creditbit from this directory, just do::

    ./electrum-creditbit

If you install Electrum-Creditbit on your system, you can run it from any
directory.

If you have pip, you can do::

    python setup.py sdist
    sudo pip install --pre dist/Electrum-Creditbit-2.3.0.tar.gz


If you don't have pip, install with::

    python setup.py sdist
    sudo python setup.py install




2. HOW OFFICIAL PACKAGES ARE CREATED
------------------------------------

On Linux/Windows::

    pyrcc4 icons.qrc -o gui/qt/icons_rc.py
    python setup.py sdist --format=zip,gztar

On Mac OS X::

    # On port based installs
    sudo python setup-release.py py2app

    # On brew installs
    ARCHFLAGS="-arch i386 -arch x86_64" sudo python setup-release.py py2app --includes sip

    sudo hdiutil create -fs HFS+ -volname "Electrum-Creditbit" -srcfolder dist/Electrum-Creditbit.app dist/electrum-creditbit-VERSION-macosx.dmg
