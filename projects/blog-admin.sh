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
chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
chmod -R 777 $WEB_PATH
sudo pm2 stop blog-admin
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
npm run build
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
sudo pm2 restart blog-admin
echo "Finished."