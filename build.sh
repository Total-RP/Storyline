#!/bin/bash

cd Src
files=$(find . -name "*lua" -type f)
fileNames=""
for i in $files; do
    fileName=$i
    fileName="${fileName:2:$((${#fileName} - 5 - 1))}"
    if [ fileName != "Main" ] && [[ $fileName != *"tests"* ]];
    then
      fileNames="${fileNames} ${fileName}"
    fi
done
echo "$fileNames"
lua ../lua-amalg/src/amalg.lua -d -o ../Storyline.lua -s Main.lua ${fileNames}

