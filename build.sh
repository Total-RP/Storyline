#!/bin/bash

cd Src
files=$(find . -name "*lua" -type f)
fileNames=""
for i in $files; do
    fileName=$i
    fileName="${fileName:2:-4}"
    if [ fileName != "Main" ]
    then
      fileNames="${fileNames} ${fileName}"
    fi
done
lua ../lua-amalg/src/amalg.lua -d -o ../Storyline.lua -s Main.lua ${fileNames}

