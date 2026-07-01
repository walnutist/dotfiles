mkdir -p ~/Codes.localized/.localized
mkdir -p ~/Knowledge.localized/.localized
mkdir -p ~/Works.localized/.localized

ln -s ./folders.zh_CN.strings ~/Codes.localized/.localized/zh_CN.strings
ln -s ./folders.zh_CN.strings ~/Knowledge.localized/.localized/zh_CN.strings
ln -s ./folders.zh_CN.strings ~/Works.localized/.localized/zh_CN.strings

folderify ./folder-icons/solid/briefcase.png ~/Works.localized
folderify ./folder-icons/solid/books.png ~/Knowledge.localized
folderify ./folder-icons/solid/code.png ~/Codes.localized