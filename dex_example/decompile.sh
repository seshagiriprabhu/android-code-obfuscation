apk_filename=$1
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"
manifest="AndroidManifest.xml"

if [ $# -lt 1 ]
then
    echo "Usage: "
    echo "$0 APK_FILE"
    exit 1
fi

if echo $1 | grep -q "help"
then
    echo "Decompiles the given apk file"
    echo "USAGE:"
    echo "\t $0 blob.apk "
    echo "\t\t Decompiles the given apk file"
    exit 1
fi

if echo $extension | grep -q "apk"
then
    continue
else
    echo "Not a valid input file. Program takes only .apk files"
    exit 1
fi

echo "Creating project directory"
mkdir -v -p $filename

echo "Making a zip file of the apk file"
zipfile=$apk_filename.zip
cp -v $apk_filename $filename/$zipfile
unzip $filename/$zipfile -d $filename


echo "Extracting classes from dex"
`pwd`/decompilers/dex2jar/d2j-dex2jar.sh $filename/classes.dex 
mv -v classes-dex2jar.jar $filename/

#$dec/jad $filename/classes-dex2jar.jar
unzip $filename/classes-dex2jar.jar -d $filename
rm -rf $filename/android

if [ ! -d $filename/src ]
then
    mkdir -v $filename/src
fi

for f in $(find $filename -iname "*.class")
do
    jad -d $filename/src -v -o -noctor -safe -r  -s java -lnc $f
done

apktool --verbose decode  $apk_filename $filename/$filename

#rm -rf $filename/res
mv -v $filename/$filename/$manifest $filename
mv -v -f $filename/$filename/res/menu/* $filename/res/menu/
mv -v -f $filename/$filename/res/layout/* $filename/res/layout/
if [ ! -f $filename/res/values ]
then
    mkdir -v $filename/res/values/
fi
mv -v $filename/$filename/res/values $filename/res/


echo "Cleaning all the build files"
find $filename/src -type f -name "*.class"  -exec rm -vf {} \;
find $filename -type f -name "BuildConfig.java"  -exec rm -vf {} \;
find $filename -type f -name "R.java"  -exec rm -vf {} \;
find $filename/src -type f -name "R\$*"  -exec rm -vf {} \; 
rm -rf $filename/com
rm $filename/classes.dex
rm -rf $filename/$filename
rm -rf $class_dir/*.class
rm -rf $filename/META-INF
rm -rf $filename/resources.arsc
rm -rf $filename/$filename.apk.zip

