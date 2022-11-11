# WHY

In some cases, when uploading photos directly from android smartphones to Synology NAS, some crucial exif data are missing. This is not a Synology problem, because basically social media erase not all but most of them.
In fact, this workaround doesn't effect at all photos taken with the camera or screenshots, but only photos coming from whatsapp, instagram, telegram... which have not a real creation date info (in their exif data), except for their name.

# WHAT IT DOES

It scans the specified folder for photos with this format name:

- IMG/VID-YYYYMMDD-WAXXXX.ext
- IMG_YYYYMMDD_HHmmSS-XXX.ext

If it finds matches, it inserts the 'Create Date' exif data to them, based on their name.
Then it standardize their name with the format IMG/VID_YYYYMMDD.ext plus HHmmSS in the second match case, plus a counter at the end '-X.ext' if more then one media has the same name. 

# INSTALLATION

### Prerequisite

- Install Perl from Synology Package Center.
- Install ExifTool in your Synology NAS. You have to enable SSH for this, then you can follow this [official tutorial](https://exiftool.org/install.html#Unix) or [this thread](https://exiftool.org/forum/index.php?PHPSESSID=54b53923ba2abeef75bed7bcc1097fee&topic=12794.msg69217#msg70056) (be careful to use the last version of [ExifTool](https://exiftool.org/) and in the 3rd point remove only the `Image-ExifTool-XX.XX.tar.gz`. Point 6th to 8th are not mandatory but recommended.) 

### Installing the script

1. First of all, download the script and the dir.txt. After you download it in your machine, modify the `DIR` variable and the `EXIFTOOL_PATH` accordingly. This means that if you have followed the 2nd tutorial, then `EXIFTOOL_PATH=/usr/share/applications/ExifTool/exiftool` and if you have planned to use it only in in one directory (`/Photos` for example) you can not use dir.txt and change directly in the shell script the `DIR=/volumeX/homes/UserName/Photos/`.

2. If you use absolute paths like I did in the examples in the first point, you can place the script and the dir.txt wherever you want on your Synology NAS, but you have to put them in the same directory (if you use both, so if you have more then one directory in which you want to use the script).

3. We are going to use the Scheduler Task. Open the Control Panel > Task Scheduler > Create > Scheduled Task > User-defined script. Give it a name, a time schedule, and in Run command (in Task Settings) write `bash path/to/script`

