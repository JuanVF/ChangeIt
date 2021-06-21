export class Post {
    public idPost : Number
    public socialMedia : string
    public link : string
    public description : string
    public postTime : string
    public actionLink : string
    public postType : string

    public static fromJson(post : any) : Post {
        let generated = new Post()

        generated.idPost = post.idPost
        generated.socialMedia = post.socialMedia
        generated.link = post.link
        generated.description = post.description
        generated.actionLink = post.actionLink
        generated.postType = post.postType
        generated.postTime = post.postTime
        
        return generated
    }

    public isValid() : string{
        if (this.socialMedia && this.socialMedia == "") return "Social Media can not be null"
        if (this.link && this.link == "") return "Post Link have to exists..."
        if (this.postType && this.postType == "") return "Post Type can not be null"

        return null
    }
}

export default Post