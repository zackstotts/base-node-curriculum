const express = require("express");
const app = express();
const morgan = require('morgan');

//	Create the Router() object
const router = express.Router();

//	Add the code below after const router = express.Router();
router.use(function(req,res,next) {
    console.log("/" + req.method);
    next();
  });

  router.use("/user/:id",function(req, res, next) {
    console.log(req.params.id)
    try
    {
      if(req.params.id == 0) {
          throw new Error({"message" : "You must pass an ID other than 0"});
      }
      res.json({"message" : "Hello User: " + req.params.id});
      next();
    }
    catch(err) {
      next(err);
    }
  });

  logVar = morgan(function (tokens, req, res) {
    return [
      tokens.method(req, res),
      tokens.url(req, res),
      tokens.status(req, res),
      tokens.res(req, res, 'content-length'), '-',
      tokens['response-time'](req, res), 'ms'
    ].join(' ')
  });
  
  console.log("The following has been logged: " + logVar);

// Provide all routes here, starting with the Home page.

router.get("/",function(req,res){
  res.json({"message" : "Hello World"});
});

// Tell express to use this router with /api before.
// You can put just '/' if you don't want any sub path before routes.

app.use("/api", router);

// Listen to this Port

app.listen(3000,function(){
  console.log("Live at Port 3000");
});
