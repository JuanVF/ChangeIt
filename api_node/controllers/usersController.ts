import DBManager from '../db'

const dbManager = DBManager.getInstance()

// This is for robot testing
export const getLogins = async (amount : Number) => {
    if (amount < 1) throw new Error("Invalid amount, value should be positive")

    return await dbManager.executeRequest(`exec sp_get_logins ${amount}`)
}