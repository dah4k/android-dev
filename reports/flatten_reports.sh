#!/bin/sh

find . -name "*.html" | while read x; do
    y=$(echo $x | sed -e 's#/lib/#/#' -e 's#/build/reports/lint-#-lint-#')
    mv $x $y
done

find . -empty -delete
