#!/bin/bash

DST_DIR='/Applications'
APP_NAME='JBCall.app'
USER='root'
PASSWD='mypass'
IP='10.231.65.56'
PROFILE_NAME='iPhone Developer: FirstName  SecondName (XXXXXXXXXX)'
APP_ON_MAC="/Users/username/Library/Developer/Xcode/DerivedData/JBCall-cktasembftvbmqaaiiunvljdwocs/Build/Products/Debug-iphoneos/JBCall.app"

echo "Uploading file"

echo "FROM:" $SRC_DIR
echo "TO  :" $DST_DIR

echo "====== [ Installin App ] ======"
echo "IP        : "   $ip
echo "Remote dir: "   $DST_DIR
echo "Local  dir: "   $APP_NAME
echo "Mac    dir: "   $APP_ON_MAC
echo "============================="

# Clear temp directory
echo "Deleting local directory: $APP_NAME"
rm -fr $APP_NAME

echo "Copy..."
echo "From: $APP_ON_MAC"
echo "To  : $APP_NAME"

## Copy the app file to temp directory
cp -Rf "$APP_ON_MAC" "$APP_NAME"
echo "Copy is done."

echo "Singing app..."
codesign --sign="$PROFILE_NAME" --entitlements entitlements.xml $APP_NAME

echo "Singing is done"

echo "Uploading files on device..."
sshpass -p $PASSWD scp -r $APP_NAME $USER@$IP:$DST_DIR
echo "Uploading is finished!"

echo "Refresing UI on device..."
sshpass -p $PASSWD ssh $USER@$IP su mobile -c uicache 1>/dev/null 2>&1

echo "Clean up. Deleting  directory: $APP_NAME"
rm -fr $APP_NAME

echo "Done"
