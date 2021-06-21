import * as express from 'express';
import * as bodyParser from 'body-parser';
import { Logger } from '../common';
import { users } from './userRoutes'
import { habits } from './habitRoutes'
import { posts } from './postRoutes'

class Routes {
    public express: express.Application;
    public logger: Logger;

    constructor() {
        this.express = express();
        this.logger = new Logger();

        this.middleware();
        this.routes();
    }

    // Configure Express middleware.
    private middleware(): void {
        this.express.use(bodyParser.json());
        this.express.use(bodyParser.urlencoded({ extended: false }));
    }

    private routes(): void { 
        this.express.use('', users)
        this.express.use('', habits)
        this.express.use('', posts)
        this.logger.info("Routes loaded");
    }
}

export default new Routes().express;

