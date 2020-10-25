#!/bin/bash
 
WEB_PATH='/wwwroot/blog-backend'
WEB_USER='root'
WEB_USERGROUP='root'
 
echo "Start deployment blog-backend"
cd $WEB_PATH
echo "pulling source code..."
# git clean -f
git fetch --all && git reset --hard origin/master && git pull
git checkout master
echo "changing permissions..."
sudo chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
sudo chmod -R 777 $WEB_PATH
pm2 stop blog-devops
pm2 stop blog-backend
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
rm -rf ./dist/*
npm run build -- --dbport=24680
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
pm2 restart blog-backend
pm2 restart blog-devops
echo "Finished."