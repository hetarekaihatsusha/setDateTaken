# setDateTaken
Set of batches that sets the image timestamp to earliest file modification date or file creation time. Processes .jpg,.jpeg,.jfif,.png. Can correct extensions that are incorrectly named.
Requires exiftool by Phil Harvey(last checked v12.7.0.0). Furthur updates of exiftool may have additional files.
# How to use
Run "set date.bat" as Admin with images in the same folder and wait for task to finish.
# Output
Will create a "processed.txt" of all files that has been scanned. Will create "errors.txt" if some errors or warnings have been made according to exiftool, otherwise will delete errors.
