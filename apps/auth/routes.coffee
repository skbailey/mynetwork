User = require '../../models/user'

module.exports = (app) ->
  
  app.post "/users", (req, res) ->
    # Construct the user obj
    userData = req.body
    newUser = new User userData
    newUser.save (err, user) ->
      if err
        console.log "Error saving the user"
        res.send 500, error: "Error occurred"
      else
        console.log "New user", userData
        res.redirect "/"

  app.get "/users/:username", (req, res) ->
    console.log "What's in param", req.params.username
    res.render "#{__dirname}/views/user",
      username: req.params.username

  app.post "/sessions", (req, res) ->
    console.log "Looking for": req.body.username
    User.findOne username: req.body.username, (err, user) ->
      if err
        console.log "Could not find user"
        res.send 500, error: "Could not find user"
      else
        if user.password is req.body.password
          req.session.currentUser = user.username
          req.session.messages = 
            type: "Info"
            info: "Welcome! Time to get started"
          res.redirect "/users/#{user.username}"
        else
          req.session.messages = 
            type: "Error"
            info: "Your username and/or password are incorrect"
          res.redirect "/"