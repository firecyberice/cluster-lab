#!/bin/bash

docker_pull () {
    local image="$1"
    docker pull "$image"
}

docker_save () {
    local filename="${filepath}/$1"
    local image="$2"
    mkdir -p "$filepath"
#    echo "save $image to $filename"
    docker save --output "$filename" "$image"
}

convertnames_tar () {
    local img="$1"
    local fil=$(echo -n "$img.tar" |sed -e "s|/|-|g" -e "s|:|_|g")
    docker_pull "$img"
    docker_save "$fil" "$img"
}

filepath="./demo"
filename="$1"

fileItemString=$(tr "\n" " " < "$filename")
fileItemArray=($fileItemString)

for i in ${fileItemArray[*]}; do

    docker_pull "$i"
#    convertnames_tar "$i"
    echo ""
done
