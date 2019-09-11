const env2 = require('env2')('./.env')
const { env } = process

module.exports = {
  apps: [
    {
      watch: true,
      script: "index.js",
      name: "run.ykpine.com",
      max_memory_restart: "68M",
      args: [
        "--deploy_secret=" + env.WEBHOOK_SECRET,
        "--dbbackup_qiniu_accessKey=" + env.QINIU_AK,
        "--dbbackup_qiniu_secretKey=" + env.QINIU_SK,
        "--dbbackup_qiniu_bucket=" + env.QINIU_BUCKET
      ],
      error_file: "/usr/local/wwwlogs/run.ykpine.com/error.log",
      out_file: "/usr/local/wwwlogs/run.ykpine.com/out.log"
    }
  ],
  deploy: {
    "production": {
      "user": env.UAER, // 服务器上发布应用的user
      "host": [env.HOST], // 可用配置多个服务ip
      "port" : env.PORT,  // 端口号
      "ref": "origin/master",
      "repo": env.REPO,
      "path":  env.PATH, // 服务器存放文件的地址
      "ssh_options": "StrictHostKeyChecking=no",
      "post-deploy": "npm install && pm2 startOrRestart ecosystem.json --env production",
      "env"  : {
        "NODE_ENV": "production"
      }
    }
  }
}