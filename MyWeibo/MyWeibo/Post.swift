//
//  Post.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
// 解析JSON数据

import SwiftUI
///定义新结构体PostList，与JSON数据外层key/value对应
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
///将与View相关的属性拓展出来
extension Post {
    var avatarImage: Image {
        return loadImage(name: avatar)
    }
    
    /**
     设置评论按钮的显示格式
     - 如果小于等于0显示“评论”
     - 如果小于1000显示评论数量
     - 如果大于1000就使用带格式的String显示评论数除以1K，保留1位小数
     */
    var commentCountText: String {
        if commentCount <= 0 { return "评论" }
        if commentCount < 1000 { return "\(commentCount)"}
        return String(format: "%.1fK", Double(commentCount) / 1000)
    }
    
    var likeCountText: String {
        if likeCount <= 0 { return "点赞"}
        if likeCount < 1000 { return "\(likeCount)" }
        return String(format: "%.1fK", Double(likeCount) / 1000)
    }
}



//已经使用环境对象，全局变量弃用
//let postList = loadPostListData("PostListData_recommend_1.json")



/// 解析JSON数据方法
/// - Parameter fileName: JSON数据保存位置
/// - Returns: 返回PostList格式数据
func loadPostListData(_ fileName: String) -> PostList {
    //定义url为文件名路径
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Cannot fine \(fileName) in main bundle")
    }
    //根据url加载数据
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Cannot load \(url)")
    }
    //利用JSONDcoder解析data数据
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Cannot parse list json data")
    }
    return list
}


func loadImage(name:String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
}
