#!/bin/bash
 
WEB_PATH='/wwwroot/blog-devops'
WEB_USER='root'
WEB_USERGROUP='root'
 
echo "Start deployment deploy"
cd $WEB_PATH
echo "pulling source code..."
# git clean -f
git fetch --all && git reset --hard origin/master && git pull
git checkout master
echo "changing permissions..."
sudo chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
sudo chmod -R 777 $WEB_PATH
echo "Finished."