#!/bin/bash
LINES=()
for i in `find .`; do
	if [ -f "$i" ]; then
	REL=$( basename "$i" )
	MD=$(md5sum -b "$i" | cut -d" " -f1)
	SIZE=$(stat --format=%s "$i")
	LINES+=("{ \"$REL\", $MD\", \"$SIZE\" },")
	fi
done

echo "fileMeta myFiles["${#LINES[@]}"] = {"
for LINE in "${LINES[@]}"; do
     echo $LINE
done
echo "};"
