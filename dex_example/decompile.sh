apk_filename=$1
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"
dec="decompilers"
dex="dex2jar-0.0.9.15"
apktool="apktool.jar"
manifest="AndroidManifest.xml"

if echo $1 | grep -q "help"
then
    echo "Decompiles the given apk file"
    echo "USAGE:"
    echo "\t $ ./decompile.sh blob.apk "
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
cp -v $apk_filename $filename/$zipfile
unzip $filename/$zipfile -d $filename

unzip $dec/$dex.zip -d $dec

echo "Extracting classes from dex"
$dec/$dex/./d2j-dex2jar.sh $filename/classes.dex 
mv -v classes-dex2jar.jar $filename/

$dec/jad $filename/classes-dex2jar.jar
unzip $filename/classes-dex2jar.jar -d $filename

java -jar $dec/apktool.jar --verbose d $apk_filename $filename/$filename
#rm -rf $filename/res
mv -v $filename/$filename/$manifest $filename
mv -v $filename/$filename/res/menu/* $filename/res/menu/
mv -v $filename/$filename/res/layout/* $filename/res/layout/
mv -v $filename/$filename/res/values $filename/res/

main_class_path=`find . -name $filename.class`
class_dir=${main_class_path%%$filename.class}

jad -d $filename -v -t -stat -dead -r -o -f -s ".java" $class_dir*.class

echo "Cleaning all the build files"
rm -v $filename/classes-dex2jar.jar
rm -v $filename/classes.dex
rm -v -rf $dec/$dex
#rm -v -rf $filename/$filename
rm -v -rf $class_dir*.class
rm -v -rf $filename/META-INF
#rm -v -rf $filename/android
rm -v -rf $filename/resources.arsc
rm -v -rf $filename/$filename.apk.zip
