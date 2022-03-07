export PROJECT_NAME="dpkg-example"
export VERSION="1.0.0"

BASE_FOLDER="${PROJECT_NAME}_${VERSION}"
RELEASE_FOLDER="files"
DEBIAN_ARHITECTURE=amd64

rm -rf release
mkdir release

mkdir $BASE_FOLDER
cp -R ./debian "$BASE_FOLDER/debian"
sed -i "s/replace-me/$DEBIAN_ARHITECTURE/g" "$BASE_FOLDER/debian/control"
cd $BASE_FOLDER
cd ..

dh_installsystemd

mkdir -p "$BASE_FOLDER/$RELEASE_FOLDER/"
cp -r ${STARTED_FROM}/{file1, file2} ${BASE_FOLDER}/${RELEASE_FOLDER}/
cp -r ${STARTED_FROM}/folder ${BASE_FOLDER}/
cp -r ${STARTED_FROM}/folder2 ${BASE_FOLDER}/


cd $BASE_FOLDER
LD_LIBRARY_PATH=$LIBRARY_PATH dpkg-buildpackage -us -uc -b --host-arch $DEBIAN_ARHITECTURE
cd ..
rm -rf $BASE_FOLDER 

find . -maxdepth 1 -name "$BASE_FOLDER*" -exec cp {} ./release/ \;
find . -maxdepth 1 -name "$BASE_FOLDER*" -exec rm {} \;
find . -maxdepth 1 -name "*.ddeb" -exec rm {} \;

