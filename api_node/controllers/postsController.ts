import DBManager from '../db'
import { Post } from '../model'

const dbManager = DBManager.getInstance()

export const registerPost = async (post : Post, user_id : string) => {
    let error = post.isValid()

    if (error != null) throw new Error(error)
    if (user_id == null) throw new Error("User Id can not be null...")

    return await dbManager.executeRequest(`
        exec sp_register_post '${post.socialMedia}', '${post.link}', 
        '${post.description}', '${user_id}', '${post.postType}', '${post.postTime}', '${post.actionLink}'`)
}

export const registerInteraction = async (post : Post, interaction : String, value : Number, user_id : String) => {
    let error = post.isValid()

    if (error != null) throw new Error(error)
    if (user_id == null) throw new Error("User Id can not be null...")

    return await dbManager.executeRequest(
        `exec sp_register_reaction ${post.idPost}, '${interaction}', ${value}, '${post.postTime}', '${user_id}'`
    )
}

export const getPosts = async (amount : Number) => {
    if (amount < 1) throw new Error("Amount of posts can not be zero or negative...")

    return await dbManager.executeRequest(
        `exec sp_get_post ${amount};`
    )
}