#!/bin/bash
 
WEB_PATH='/wwwroot/blog-admin'
WEB_USER='root'
WEB_USERGROUP='root'
 
echo "Start deployment blog-admin"
cd $WEB_PATH
echo "pulling source code..."
# git clean -f
git fetch --all && git reset --hard origin/master && git pull
git checkout master
echo "changing permissions..."
sudo chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
sudo chmod -R 777 $WEB_PATH
pm2 stop blog-admin
pm2 stop blog-devops
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
npm run build
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
pm2 restart blog-admin
pm2 restart blog-devops
echo "Finished."