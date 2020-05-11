const debug = require('debug')('app:startup');
const http = require('http');
const fs = require('fs');

const hostname = process.env.HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;

const server = http.createServer((request, response) => {
  console.log(`${request.method} ${request.url}`);

  const url = new URL(request.url, `http://${request.headers.host}`);
  switch (url.pathname) {
    case '/': {
      // Home Page
      serveStaticFile(response, '/index.html');
      break;
    }
    default: {
      // Serve static files from public dir
      serveStaticFile(response, url.pathname);
      break;
    }
  }
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

function serveStaticFile(response, url) {
  const filename = __dirname + '/public' + url;
  fs.exists(filename, (exists) => {
    if (!exists) {
      response.statusCode = 404;
      response.setHeader('Content-Type', 'text/plain');
      response.end("file not found");
    } else {
      fs.readFile(filename, (err, data) => {
        if (err) {
          response.statusCode = 404;
          response.setHeader('Content-Type', 'application/json');
          response.end(JSON.stringify(err));
        } else {
          response.statusCode = 200;
          response.end(data);
        }
      });
    }
  });
}