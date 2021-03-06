#!/bin/sh 

script_dir=`dirname $0`
mkdir -p ${script_dir}/release
rm -rf release/*
cd ${script_dir}/yeoman-generator-skinny
rm -rf app/templates/project/project
rm -rf app/templates/project/target
rm -rf app/templates/target
rm -rf app/templates/node_modules
rm -rf app/templates/*/target

npm link
cd -
cd ${script_dir}/release
mkdir skinny-blank-app
cd skinny-blank-app
yo --no-insight skinny
mv _package.json package.json
if [ "$1" != "test" ]; then
  if [ -f "$HOME/ivy2.tar.gz" ]; then
    cp -p $HOME/ivy2.tar.gz .
    tar xvfzp ivy2.tar.gz
    rm -f ivy2.tar.gz
  fi
  ./create_local_ivy2
fi
rm -rf target
rm -rf project/project
rm -rf src/main/webapp/WEB-INF/assets/target
rm -rf */target
rm -rf node_modules
rm -f  create_local_ivy2
cd ..
zip -r skinny-blank-app-with-deps.zip ./skinny-blank-app
rm -rf skinny-blank-app/ivy2
zip -r skinny-blank-app.zip ./skinny-blank-app

