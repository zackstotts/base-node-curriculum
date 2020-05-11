const debugServer = require('debug')('app:server');
const debugFiles = require('debug')('app:files');
const http = require('http');
const fs = require('fs');
const querystring = require('querystring');

const hostname = process.env.HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;

const server = http.createServer((request, response) => {
  debugServer(`${request.method} ${request.url}`);

  const url = new URL(request.url, `http://${request.headers.host}`);
  switch (url.pathname) {
    case '/': {
      // Home Page
      serveStaticFile(response, '/index.html');
      break;
    }
    case '/contact': {
      // Contact Form
      if (request.method == 'POST') {
        let body = '';
        request.on('data', (chunk) => {
          body += chunk.toString();
        });
        request.on('end', () => {
          debugServer(body);
          const params = querystring.parse(body);

          debugServer('Message Received!');
          debugServer(`\temail: ${params.email}`);
          debugServer(`\tsubject: ${params.subject}`);
          debugServer(`\tmessage: ${params.message}`);

          if (params.email && params.subject && params.message) {
            serveStaticFile(response, '/contact_sent.html');
          } else {
            serveStaticFile(response, '/contact_error.html');
          }
        });
      } else {
        serveStaticFile(response, '/contact.html');
      }
      break;
    }
    default: {
      // Otherwise, serve static files from public dir
      serveStaticFile(response, url.pathname);
      break;
    }
  }
});

server.listen(port, hostname, () => {
  debugServer(`Server running at http://${hostname}:${port}/`);
});

function serveStaticFile(response, url) {
  const filename = __dirname + '/public' + url;
  fs.exists(filename, (exists) => {
    if (!exists) {
      response.statusCode = 404;
      response.setHeader('Content-Type', 'text/plain');
      response.end('FILE NOT FOUND');
      debugFiles(`FILE NOT FOUND ${filename}`);
    } else {
      fs.readFile(filename, (err, data) => {
        if (err) {
          response.statusCode = 404;
          response.setHeader('Content-Type', 'application/json');
          response.end(JSON.stringify(err));
          debugFiles(`ERROR ${filename}`);
        } else {
          response.statusCode = 200;
          response.end(data);
          //debugFiles(`SERVED ${filename}`);
        }
      });
    }
  });
}
