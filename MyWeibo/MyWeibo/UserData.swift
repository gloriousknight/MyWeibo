//
//  UserData.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/21.
//
import Combine
//定义环境对象的类型
class UserData: ObservableObject {
    @Published var recommandPostList: PostList = loadPostListData("PostListData_recommend_1.json") //@Published修饰词修饰后如果环境对象发生变化，所有View的环境对象都更新
    @Published var hotPostList: PostList = loadPostListData("PostListData_hot_1.json")
    //定义字典类型保存一一对应的微博信息
    private var recommandPostDic: [Int: Int] = [:]//key:每条微博的ID，value：每条微博所在的序号
    private var hotPostDic: [Int: Int] = [:]//id: index
    
    init() {
        //取出每一条微博，更新字典
        for i in 0..<recommandPostList.list.count {
            let post = recommandPostList.list[i]
            recommandPostDic[post.id] = i
        }
        for i in 0..<hotPostList.list.count {
            let post = hotPostList.list[i]
           hotPostDic[post.id] = i
        }
    }
}
//枚举定义微博列表类型，推荐和关注
enum PostListCategory {
    case recommand, hot
}

extension UserData {
    func postList(for category: PostListCategory) -> PostList {
        switch category {
        case .recommand: return recommandPostList
        case .hot: return hotPostList
        }
    }
    
    /// 给定一个ID，找到对应的微博
    /// - Parameter id: 微博id
    /// - Returns: 找到的微博内容，如果没有则返回nil
    func post(forId id: Int) -> Post? {
        if let index = recommandPostDic[id] {
            return recommandPostList.list[index]
        }
        if let index = hotPostDic[id] {
            return hotPostList.list[index]
        }
        return nil
    }
    
    /// 更新一条微博，外部参数为空
    /// - Parameter post:微博列表
    /// - Returns:
    func update(_ post: Post) {
        if let index = recommandPostDic[post.id] {
            recommandPostList.list[index] = post
        }
        if let index = hotPostDic[post.id] {
            hotPostList.list[index] = post
        }
    }
}
