#!/usr/bin/python

# python setup.py sdist --format=zip,gztar

from setuptools import setup
import os
import sys
import platform
import imp


version = imp.load_source('version', 'lib/version.py')

if sys.version_info[:3] < (2, 7, 0):
    sys.exit("Error: Electrum requires Python version >= 2.7.0...")



data_files = []
if platform.system() in [ 'Linux', 'FreeBSD', 'DragonFly']:
    usr_share = os.path.join(sys.prefix, "share")
    data_files += [
        (os.path.join(usr_share, 'applications/'), ['electrum-creditbit.desktop']),
        (os.path.join(usr_share, 'pixmaps/'), ['icons/electrum-creditbit.png'])
    ]


setup(
    name="Electrum-Creditbit",
    version=version.ELECTRUM_VERSION,
    install_requires=[
        'slowaes>=0.1a1',
        'ecdsa>=0.9',
        'pbkdf2',
        'requests',
        'qrcode',
        'protobuf',
        'tlslite',
        'dnspython',
		'x11_hash',
    ],
    package_dir={
        'electrum_creditbit': 'lib',
        'electrum_creditbit_gui': 'gui',
        'electrum_creditbit_plugins': 'plugins',
    },
    packages=['electrum_creditbit','electrum_creditbit_gui','electrum_creditbit_gui.qt','electrum_creditbit_plugins'],
    package_data={
        'electrum_creditbit': [
            'wordlist/*.txt',
            'locale/*/LC_MESSAGES/electrum.mo',
        ],
        'electrum_creditbit_gui': [
            "qt/themes/cleanlook/name.cfg",
            "qt/themes/cleanlook/style.css",
            "qt/themes/sahara/name.cfg",
            "qt/themes/sahara/style.css",
            "qt/themes/dark/name.cfg",
            "qt/themes/dark/style.css",
        ]
    },
    scripts=['electrum-creditbit'],
    data_files=data_files,
    description="Lightweight Creditbit Wallet",
    author="creditbitDEV",
    author_email="creditbitcoin@twitter",
    license="GNU GPLv3",
    url="http://www.creditbit.org",
    long_description="""Lightweight Creditbit Wallet"""
)
