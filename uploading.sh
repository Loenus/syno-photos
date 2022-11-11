#!/bin/sh
DIR=-@ dir.txt
EXIFTOOL_PATH=path/to/ExifTool

echo "add/fix the exif data:'CreateDate' to whatsapp photos and videos"
ADD_DATE=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '($filename =~ /^IMG-\d{8}-WA\d{4}\.\w*/ or $filename =~ /^VID-\d{8}-WA\d{4}\.\w*/) and (not $CreateDate or $CreateDate eq "0000:00:00 00:00:00")' '-CreateDate<filename' $DIR -overwrite_original)
echo -e "$ADD_DATE\n"

echo "add/fix the exif data:'CreateDate' to instagram photos (and not only, telegram too?)"
ADD_DATE_INSTA=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG_\d{8}_\d{6}_\d{3}\.\w*/' '-CreateDate<filename' $DIR -overwrite_original)
echo -e "$ADD_DATE_INSTA\n"

echo "Change NAME to whatsapp photos, accordingly to their exif:'CreateDate'"
CHANGE_NAME_PHOTOS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG-\d{8}-WA\d{4}\.\w*/' -d 'IMG_%Y%m%d%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo "... same thing for whatsapp videos"
CHANGE_NAME_VIDEOS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^VID-\d{8}-WA\d{4}\.\w*/' -d 'VID_%Y%m%d%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo "... same thing for instagram photos"
CHANGE_NAME_INSTA=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG_\d{8}_\d{6}_\d{3}\.\w*/' -d 'IMG_%Y%m%d_%H%M%S%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo -e "$CHANGE_NAME_PHOTOS\n"
echo -e "$CHANGE_NAME_VIDEOS\n"
echo -e "$CHANGE_NAME_INSTA"
