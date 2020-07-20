#!/bin/bash

cd Source
files=$(find . -name "*lua" -type f)
fileNames=""
for i in $files; do
    fileName=$i
    fileName="${fileName:2:$((${#fileName} - 5 - 1))}"
    if [ fileName != "Main" ]
    then
      echo "Adding source file: $fileName"
      fileNames="${fileNames} ${fileName}"
    fi
done
lua ../Scripts/amalg.lua -d -o ../Storyline.lua -s Main.lua ${fileNames}
echo "Files amalgamated."

