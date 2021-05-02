#!/bin/sh

<< DESC
  A script for Vue3 project to quick deploying on github pages.
  The process is referenced from the this page:
  https://medium.com/@Roli_Dori/deploy-vue-cli-3-project-to-github-pages-ebeda0705fbd
DESC

set -e

read -p 'Before the next step, Please create a new repository on your github then copy the repositoey URL, It is useful for you on the next step! (Press any key to continue)'

read -p "Enter your remote repository URL (required)：" REPO_URL

if [ -z "$REPO_URL" ]; then
  echo "-WARN: Repository URL is required"
  exit 1
fi

REPO_NAME=$(cut -d'/' -f5 <<< \'"$REPO_URL"\' | awk -F. '{print $1}')
CONFIG_FILE=vue.config.js
configfileExists=FALSE

for JS_FILE in $(ls *.js)  
  do
    if [ "$JS_FILE" = "$CONFIG_FILE" ]; then
      configfileExists=TRUE
    fi
  done

if [[ "$configfileExists" = "FALSE" ]]; then
  echo "module.exports = {\n  publicPath: '"$REPO_NANE"'\n}" > "$CONFIG_FILE"
else
  CONFIG_CONTENT=$(cat "$CONFIG_FILE")
  if  grep -i --silent 'publicPath:' "$CONFIG_FILE"; then
    # echo 'the string exists';
    perl -i -pe"s/publicPath:\s*['|\"]?[\w+|\-|_|@|'|\"]+['|\"]?/publicPath: '"$REPO_NANE"'/g" "$CONFIG_FILE"
  else
    # echo 'the string does not exist';
    perl -i -pe"s/module.exports\s*\=\s*\{\s*/module.exports = {\n  publicPath: '"$REPO_NANE"',\n/g" "$CONFIG_FILE"
  fi
fi

perl -i -pe"s/^[^#]?(\/?)(?=dist)/# /g" .gitignore

[ -r .git ] || git init
npm run build
git add dist && git commit -m "Initial dist subtree commit"
git branch | grep gh-pages || git branch gh-pages
git remote add origin "$REPO_URL"
git subtree push --prefix dist origin gh-pages

echo '-DONE.'