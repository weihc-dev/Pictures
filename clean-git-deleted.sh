#!/bin/bash

git add -u
git commit -m "Remove deleted files"
git push

deleted_files=$(git diff --name-only HEAD~1 HEAD --diff-filter=D)

if [ -z "$deleted_files" ]; then
    echo "done."
    exit 0
fi

echo "start deleted："
echo "$deleted_files"

for file in $deleted_files; do
    git filter-repo --invert-paths --path "$file"
done

git push origin --force --all
git push origin --force --tags

git gc --prune=now --aggressive

echo "done."