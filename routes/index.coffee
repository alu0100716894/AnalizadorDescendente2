express = require('express')
router = express.Router()

### GET home page. ###

router.get '/', (req, res, next) ->
  res.render 'index', title: 'Express'
  return
module.exports =
  index: (req, res) ->
    res.render 'index',
      title: 'Analizador Descendente Predictivo Recursivo'
      posts: []
      
  newPost: (req, res) ->
    res.render 'add_post', title:"Write New Post"