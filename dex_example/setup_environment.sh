#/bin/bash

if [ ! -f /usr/local/bin/apktool.jar ]
then
    echo "Installing apktool"
    sudo cp -v decompilers/apktool.jar /usr/local/bin
else
    echo "apktool.jar already installed in your machine"
fi

if [ ! -d apktool-install-linux-r05-ibot ]
then
    tar -xvf decompilers/apktool-install-linux-r05-ibot.tar.bz2
fi

if [ ! -f /usr/local/bin/apktool ]
then
    sudo mv -v apktool-install-linux-r05-ibot.tar.bz2/apktool /usr/local/bin
else
    echo "apktool already installed in your machine"
fi
if [ ! -f /usr/local/bin/aapt ]
then
    sudo mv -v apktool-install-linux-r05-ibot.tar.bz2/aapt /usr/local/bin
else
    echo "aapt already installed in your machine"
fi

if [ ! -f /usr/local/bin/jad ]
then
    echo "Installing java decompiler"
    sudo cp -v decompilers/jad /usr/local/bin
else
    echo "JAD already installed in your machine"
fi

if [ ! -d decompilers/dex2jar ]
then
    echo "Installing dex2jar"
    unzip decompilers/dex2jar-0.0.9.15.zip -d decompilers
    sudo mv decompilers/dex2jar-0.0.9.15 decompilers/dex2jar
fi

sudo chmod -v +x /usr/local/bin/dex2jar /usr/local/bin/jad /usr/local/bin/apktool

echo "Cleaning up build files"
rm -rf apktool-install-linux-r05-ibot
