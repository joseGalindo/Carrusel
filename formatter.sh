#!/bin/bash

for fn in $(ls $1)
do
    echo "<body style=\"text-align: justify; font-family: georgia; font-size: 30px\">\\n$(cat $1/$fn)" > $1/$fn
    echo "</body>" >> $1/$fn
done
