import { Logger } from '../common'
const sql = require('mssql')
const configData = require('./config.json')

sql.on('error', (err : any) => {
    console.log(err)
}) 

class DBManager {
    private static instance : DBManager = null
    private poolConnector : any = null
    private globalPool : any = null
    private logger : Logger

    private constructor(){
        if (this.poolConnector == null){
            this.poolConnector = new sql.ConnectionPool(configData)
            this.globalPool = this.poolConnector.connect()
            this.logger = new Logger()
        }
    }

    public static getInstance(){
        if (DBManager.instance == null){
            DBManager.instance = new DBManager()
        }

        return DBManager.instance
    }

    public executeRequest(request : string){
        return new Promise<any>((resolve, reject) => {
            this.globalPool.then((pool : any)=>{
                pool.request().query(request)
                .then((data : any) => {
                    resolve(data)
                })
                .catch((err : any) => {
                    reject(err)
                })
            })
        })
    }
}

export default DBManager