#!/bin/bash
 
WEB_PATH='/usr/local/wwwroot/blog-frontend'
WEB_USER='root'
WEB_USERGROUP='root'
 
echo "Start deployment ykpine.com"
cd $WEB_PATH
echo "pulling source code..."
# git clean -f
git fetch --all && git reset --hard origin/master && git pull
git checkout master
echo "changing permissions..."
chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
chmod -R 777 $WEB_PATH
sudo pm2 stop ykpine.com
pm2 stop blog-backend
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
npm run build
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
pm2 restart blog-backend
sudo pm2 restart ykpine.com
echo "Finished."