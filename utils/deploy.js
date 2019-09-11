const shell = require('shelljs')
const consola = require('consola')
const projects = ['blog-backend', 'blog-frontend', 'blog-admin', 'run.ykpine.com']

module.exports = (event, action) => {
  const branch = event.payload.ref
  const project = event.payload.repository.name
  const message = event.payload.head_commit.message || ''
  if (projects.includes(project) && message.includes('doDeploy')) {
    consola.info(`收到一个关于项目 ${project} - ${branch} 分支的 ${action} 事件，要求服务端部署！`, new Date())
    shell.exec(`sh ./projects/${project}.sh`, (code, stdout, stderr) => {
      consola.info('Exit code:', code, new Date())
      consola.info('执行完毕！Program output:', stdout)
      // consola.info('执行完毕！错误信息：？', new Date(), stderr)
    })
  }
}