#!/bin/bash

git fetch origin master

if [ -z `git diff --dirstat=files,0 --name-only origin/master | grep -v .github | grep -v .tflint` ]; then
    CHANGED_TF_MODULES_JSON=$(printf '[]\n')

    echo "TF Modules JSON: " $CHANGED_TF_MODULES_JSON
else
    CHANGED_TF_MODULES=`git diff --dirstat=files,0 --name-only origin/master | sed -E 's/^[ 0-9.]+% //g' | cut -d '/' -f1 | grep -v .github | grep -v .tflint | uniq | sort`

    echo "TF Modules: " $CHANGED_TF_MODULES

    if [ -z "$CHANGED_TF_MODULES" ]; then
        CHANGED_TF_MODULES_JSON=$(printf '[]\n')
    else
        CHANGED_TF_MODULES_JSON=$(printf '['; for i in ${CHANGED_TF_MODULES[@]}; do printf ' \"%s\", ' $i; done | sed 's/,\([^,]*\)$/\1/'; printf ']\n')
    fi

    echo "TF Modules JSON: " $CHANGED_TF_MODULES_JSON
fi

echo "::set-output name=tf_modules::$CHANGED_TF_MODULES_JSON"