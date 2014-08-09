#!/bin/bash

DST_DIR='/Applications'
APP_NAME='JBCall.app'
USER='root'
PASSWD='mypass'
IP='10.231.65.56'


echo "====== [ Removing App ] ======"
echo "IP        : "   $ip
echo "Remote dir: "   $DST_DIR
echo "============================="

echo "Removing app on device..."
sshpass -p $PASSWD ssh $USER@$IP rm -fr $DST_DIR/$APP_NAME
echo "Files were removed!"

echo "Refresing UI on device..."
sshpass -p $PASSWD ssh $USER@$IP su mobile -c uicache 1>/dev/null 2>&1
echo "Done"
