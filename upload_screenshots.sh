#!/bin/sh
echo "Screen shots will be uploaded to Google Drive"
wget https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64
chmod +x ./gdrive-linux-x64

ARCHIVE=$(date +%Y-%m-%d_%H_%M_%S)-$TRAVIS_PULL_REQUEST_BRANCH.tar
echo "Creating archive $ARCHIVE"
tar cvf $ARCHIVE test_e2e/cypress/snapshots/
FILESIZE=$(stat -c%s "$ARCHIVE")
echo "Finished archive (size $FILESIZE), starting Google Drive upload"

GDRIVE_REFRESH_TOKEN=1/z1zAb_R6LG_vIkl1-3PdB7220U-ouZDavW-44CWEGMk
GDRIVE_DIR=1rAnjWMGv4-ht9RD97llfVWHFwJFGqX5a
./gdrive-linux-x64 upload --refresh-token $GDRIVE_REFRESH_TOKEN --parent $GDRIVE_DIR "$ARCHIVE"
echo "Finished Google Drive upload"