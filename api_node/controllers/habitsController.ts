import DBManager from '../db'

const dbManager = DBManager.getInstance()

export const registertHabit = async (title : string, desc : string, imgURL :string) => {
    if (title && title == "") throw new Error("Title is empty...")
    if (desc && desc == "") throw new Error("Description is empty...")
    if (imgURL && imgURL == "") throw new Error("Image URL is empty")

    return await dbManager.executeRequest(`exec sp_register_habit '${title}', '${desc}', '${imgURL}'`)
}