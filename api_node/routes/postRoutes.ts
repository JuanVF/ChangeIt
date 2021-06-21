import * as express from 'express';

import { Logger } from '../common';
import { registerPost, registerInteraction, getPosts } from '../controllers';
import { Post } from '../model';
const { parse } = require('json2csv');

const logger = new Logger()
const app = express()
const fields = ['idPost', 'link', 'description', 'postTime', 'linkAction']

app.post('/post/', (req : any, res : any, next) => { 
    const post : Post = Post.fromJson(req.body.post)
    const user_id : string = req.body.user_id

    registerPost(post, user_id).then(result => {
        res.json({
            message : "Post has been registered!"
        })
    })
    .catch(error => {
        logger.info(error)

        res.status(400)
        res.json({
            error : error.message
        })
    });
}) 

app.get('/posts/:amount', (req : any, res : any, next) => {
    const amount : Number = req.params.amount

    getPosts(amount).then(result => {
        const csv = parse(result.recordsets[0], {fields})

        res.type('text/csv')
        res.attachment('posts.csv').send(csv)
    })
    .catch(error => {
        logger.info(error)

        res.status(400)
        res.json({
            error : error.message
        })
    })
})

app.post('/post/interaction', (req : any, res : any, next) => {
    console.log(req.body.post)
    const post : Post = Post.fromJson(req.body.post)
    const user_id : string = req.body.user_id
    const interaction : string = req.body.interaction
    const value : Number = req.body.value

    registerInteraction(post, interaction, value, user_id)
    .then(result => {
        res.json({
            message : "Interaction has been registered!"
        })
    })
    .catch(error => {
        logger.info(error)

        res.status(400)
        res.json({
            error : error.message
        })
    })
})

export { app as posts }
