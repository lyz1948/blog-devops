const PROJECT_PATH = '/deploy'
const SECRET_KEY = 'ykpine.blog'
const PORT = 3000

const http = require('http')
const fs = require('fs')
const shell = require('shelljs')
const consola = require('consola')
const createHandler = require('github-webhook-handler')
const handler = createHandler({ path: PROJECT_PATH, secret: SECRET_KEY })
const html = fs.readFileSync('index.html')
const deployHandler = require('./utils/deploy')

http.createServer((req, res) => {
  handler(req, res, _ => {
    if (req.url !== PROJECT_PATH) {
      res.writeHead(200, {
        'Content-Type': 'text/html',
        'Content-Length': html.length
      })
      res.write(html)
    }
    res.end()
  })
}).listen(PORT, () => {
  consola.ready(`service is running at port ${PORT}`, new Date())
  shell.exec('echo shell test OK!')
})

handler.on('push', event => { deployHandler(event, 'push') })

handler.on('commit_comment', event => { deployHandler(event, 'commit') })

handler.on('error', err => {
  consola.warn('Error:', err.message)
})

