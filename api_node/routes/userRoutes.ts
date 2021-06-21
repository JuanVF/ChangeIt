import * as express from 'express';

import { Logger } from '../common';
import { getLogins } from '../controllers';

const logger = new Logger()
const app = express()

app.get('/users/:amount', (req : any, res : any, next) => { 
    getLogins(req.params.amount).then(result => {
        res.json({
            message : result.recordsets[0]
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

export { app as users }
