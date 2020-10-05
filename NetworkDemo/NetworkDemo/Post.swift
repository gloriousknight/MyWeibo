//
//  Post.swift
//  NetworkDemo
//
//  Created by BaronZhang on 2020/10/4.
//

import Foundation

struct PostList: Codable {
    var list: [Post]
}

/// Data Model, 与JSONList内字典key/value对应
struct Post: Codable, Identifiable{
    //初始化Post内容
    let id: Int //用户ID
    let avatar: String //头像，图片名称
    let vip: Bool //是否为Vip
    let name: String //昵称
    let date: String //日期
    var isFollowed: Bool //是否被关注
    let text: String //微博内容
    let images:[String] //微博图片
    var commentCount: Int //评论数
    var likeCount: Int //点赞数
    var isLiked: Bool //是否点赞

    
}
