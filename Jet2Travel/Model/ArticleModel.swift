//
//  ArticleModel.swift
//  Jet2Travel
//
//  Created by MCB-Air-036 on 02/05/20.
//  Copyright © 2020 Amol Deshmukh. All rights reserved.
//

import Foundation

struct ArticleModel : Codable {
    var article_IdString : String?
    var article_CreatedAtString : String?
    var article_ContentString : String?
    var article_CommentsCount : Int?
    var article_LikesCount : Int?
    var article_MediaArray : [MediaModel]?
    var article_UserArray : [UserModel]?

    enum CodingKeys: String, CodingKey {
        case article_IdString = "id"
        case article_CreatedAtString = "createdAt"
        case article_ContentString = "content"
        case article_CommentsCount = "comments"
        case article_LikesCount = "likes"
        case article_MediaArray = "media"
        case article_UserArray = "user"
    }
}

struct MediaModel : Codable {
    var media_IdString : String?
    var media_BlogIdString : String?
    var media_CreatedAtString : String?
    var media_Image : String?
    var media_Title : String?
    var media_Url : String?

    enum CodingKeys: String, CodingKey {
        case media_IdString = "id"
        case media_BlogIdString = "blogId"
        case media_CreatedAtString = "createdAt"
        case media_Image = "image"
        case media_Title = "title"
        case media_Url = "url"
    }
}

struct UserModel : Codable {
    var user_IdString : String?
    var user_BlogIdString : String?
    var user_CreatedAtString : String?
    var user_NameString : String?
    var user_AvatarString : String?
    var user_LastnameString : String?
    var user_CityString : String?
    var user_DesignationString : String?
    var user_AboutString : String?

    enum CodingKeys: String, CodingKey {
        case user_IdString = "id"
        case user_BlogIdString = "blogId"
        case user_CreatedAtString = "createdAt"
        case user_NameString = "name"
        case user_AvatarString = "avatar"
        case user_LastnameString = "lastname"
        case user_CityString = "city"
        case user_DesignationString = "designation"
        case user_AboutString = "about"
    }
}
