User = require '../../models/user'

module.exports = (app) ->
  
  app.post "/users", (req, res) ->
    # Construct the user obj
    userData = req.body
    userData.birthday = "#{req.body.month}/#{req.body.day}/#{req.body.year}"
    newUser = new User userData
    newUser.save (err, user) ->
      if err
        console.log "Error saving the user"
      else
        res.redirect "/"
    res.send("Signed Up")