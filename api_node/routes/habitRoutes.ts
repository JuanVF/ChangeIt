import * as express from 'express';

import { Logger } from '../common';
import { registertHabit } from '../controllers';

const logger = new Logger()
const app = express()

app.post('/habit/', (req : any, res : any, next) => { 
    const title : string = req.body.title
    const desc : string = req.body.desc
    const imgURL : string = req.body.imgURL

    registertHabit(title, desc, imgURL).then(result => {
        res.json({
            message : "Habit has been registered!"
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

export { app as habits }
