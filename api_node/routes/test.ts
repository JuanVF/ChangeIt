import * as express from 'express';

import DBManager from '../db'
import { Logger } from '../common';

const logger = new Logger()
const app = express()

const dbManager = DBManager.getInstance()

const getUsers = async () => {
    const num : Number = Math.floor(Math.random() * 30)
    return await dbManager.executeRequest(`
    SELECT 
        CONCAT(us.name, us.idUser, ' ', us.lastName) AS FULLNAME,
        gen.gender AS GENERO,
        im.link PROFILE_PIC
    FROM dbo.Users us
    INNER JOIN dbo.Gender gen
        ON gen.idGender = us.idGender
    INNER JOIN dbo.Images im
        ON im.idImage = us.idProfilePicture
    WHERE us.idUser = ${num};
    `)
}

app.get('/test', (req, res, next) => { 
    getUsers().then(r => {
        res.json({ 
            message : r
        })
    })
    .catch(error => {
        logger.error(error)
    })
})

export { app as test }
