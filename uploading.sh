#!/bin/sh
DIR=-@ dir.txt
EXIFTOOL_PATH=path/to/ExifTool

echo "WHATSAPP photos&videos: add/fix the exif data:'CreateDate'"
ADD_DATE=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '($filename =~ /^IMG-\d{8}-WA\d{4}\.\w*/ or $filename =~ /^VID-\d{8}-WA\d{4}\.\w*/) and (not $CreateDate or $CreateDate eq "0000:00:00 00:00:00")' '-CreateDate<filename' $DIR -overwrite_original)
echo -e "$ADD_DATE\n"

echo "MISC photos (videos have incorrect name): add/fix the exif data:'CreateDate' to instagram/telegram.. photos"
ADD_DATE_MISC=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG_\d{8}_\d{6}_\d{3}\.\w*/' '-CreateDate<filename' $DIR -overwrite_original)
echo -e "$ADD_DATE_MISC\n"

echo "SCREENSHOTS photos: add/fix the exif data:'CreateDate' and add 'model' which is the app where the screenshot was taken"
ADD_DATE_SCREENSHOTS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^Screenshot_\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{3}_com\.\w*[\.\w]*\.\w*/' '-CreateDate<filename' '-model<${Filename;s/^Screenshot_\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{3}_com\.(\w*)[\.\w]*\.\w*/$1/}' $DIR -overwrite_original)
echo -e "$ADD_DATE_SCREENSHOTS\n"

echo "Change NAME to whatsapp photos, accordingly to their exif:'CreateDate'"
CHANGE_NAME_PHOTOS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG-\d{8}-WA\d{4}\.\w*/' -d 'IMG_%Y%m%d%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo "... same thing for whatsapp videos"
CHANGE_NAME_VIDEOS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^VID-\d{8}-WA\d{4}\.\w*/' -d 'VID_%Y%m%d%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo "... same thing for instagram photos"
CHANGE_NAME_MISC=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^IMG_\d{8}_\d{6}_\d{3}\.\w*/' -d 'IMG_%Y%m%d_%H%M%S%%-c.%%e' '-filename<CreateDate' $DIR -overwrite_original)
echo "... same thing for screenshots, adding the location of where the screenshot was taken"
CHANGE_NAME_SCREENSHOTS=$($EXIFTOOL_PATH -recurse -ignore '@eaDir' -if '$filename =~ /^Screenshot_\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{3}_com\.\w*[\.\w]*\.\w*/' -d 'Screenshot_%Y%m%d_%H%M%S%%-c' '-filename<$CreateDate-$model.%e' $DIR -overwrite_original)
echo -e "$CHANGE_NAME_PHOTOS\n"
echo -e "$CHANGE_NAME_VIDEOS\n"
echo -e "$CHANGE_NAME_MISC\n"
echo -e "$CHANGE_NAME_SCREENSHOTS"
