//
//  UserData.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/21.
//
import Foundation
import Combine
//定义环境对象的类型
class UserData: ObservableObject {
    @Published var recommandPostList: PostList = PostList(list: []) //@Published修饰词修饰后如果环境对象发生变化，所有View的环境对象都更新
    @Published var hotPostList: PostList = PostList(list: [])
    //下拉刷新的Bool值
    @Published var isRefreshing: Bool = false
    //上拉加载更多
    @Published var isLoadingMore: Bool = false
    //加载失败的提示框
    @Published var loadingError: Error?
    //定义BBTableView是否需要强制刷新所有数据的标志
    @Published var reloadData: Bool = false
    //定义字典类型保存一一对应的微博信息
    private var recommandPostDic: [Int: Int] = [:]//key:每条微博的ID，value：每条微博所在的序号
    private var hotPostDic: [Int: Int] = [:]//id: index

    //已从网络中获取请求，无需本地初始化
//    init() {
//        //取出每一条微博，更新字典
//        for i in 0..<recommandPostList.list.count {
//            let post = recommandPostList.list[i]
//            recommandPostDic[post.id] = i
//        }
//        for i in 0..<hotPostList.list.count {
//            let post = hotPostList.list[i]
//           hotPostDic[post.id] = i
//        }
//    }
}
//枚举定义微博列表类型，推荐和关注
enum PostListCategory {
    case recommand, hot
}

extension UserData {
    //创建本地测试的UserData
    static let testData: UserData = {
        let data = UserData()
        data.handleRefreshPostList(loadPostListData("PostListData_hot_1.json"), for: .hot)
        data.handleRefreshPostList(loadPostListData("PostListData_recommand_1.json"), for: .recommand)
        return data
    }() //闭包+() 是执行这个闭包
    
    
    
    //是否展示加载错误的信息
    var showLoadingError: Bool{ loadingError != nil }
    //需要展示的错误信息，默认为""
    var loadingErrorText: String { loadingError?.localizedDescription ?? "" }
    
    func postList(for category: PostListCategory) -> PostList {
        switch category {
        case .recommand: return recommandPostList
        case .hot: return hotPostList
        }
    }
    
    /// 在微博列表为空的时候加载微博列表
    /// - Parameter category: 分类
    func loadPostListIfNeeded(for category: PostListCategory) {
        if postList(for: category).list.isEmpty {
            refreshPostList(for: category)
        }
    }
    
    /// 定义刷新微博列表的方法
    /// - Parameter category: 根据category参数判断需要刷新的列表是哪个
    func refreshPostList (for category: PostListCategory) {
        //定义局部变量completion代替闭包
        let completion: (Result<PostList, Error>) -> Void = { result in
            switch result {
            case let .success(list): self.handleRefreshPostList(list, for: category)
            case let .failure(error): self.handleLoadingError(error)
            }
            //请求结束，刷新圈消失
            self.isRefreshing = false
        }
        switch category {
        case .recommand: NetworkAPI.recommandPostList(completion: completion)
        case .hot: NetworkAPI.hotPostList(completion: completion)
        }
    }
    
    /// 定义上拉加载更多方法
    /// - Parameter category: 根据分类加载
    func loadMorePostList(for category: PostListCategory) {
        //定义局部变量代替闭包重复调用
        let completion: (Result<PostList, Error>) -> Void = { result in
            switch result {
            case let .success(list) : self.handleLoadMorePostList(list, for: category)
            case let .failure(error) : self.handleLoadingError(error)
            }
            //把isLoadingMore参数重置，停止加载更多
            self.isLoadingMore = false
            
        }
        //如果正在加载更多或者加载的微博数量超过10个就返回
        if isLoadingMore || postList(for: category).list.count > 10 { return }
        isLoadingMore = true
        switch category {
        case .recommand: NetworkAPI.hotPostList(completion: completion) //获取热门列表的数据
        case .hot: NetworkAPI.recommandPostList(completion: completion) //获取推荐列表的数据
        }
    }
    
    /// 处理上拉加载更多网络请求得到的数据，并实时更新
    /// - Parameters:
    ///   - list: 得到的List
    ///   - category: 分类
    private func handleLoadMorePostList(_ list: PostList , for category: PostListCategory) {
        switch category {
        case .recommand:
            //遍历整个数组，取出元素Post，检查是否重复
            for post in list.list {
                //先更新本地数据
                update(post)
                //找到了数据，重复，进入下一次循环
                if recommandPostDic[post.id] != nil { continue }
                //没有找到数据，添加数据
                recommandPostList.list.append(post)
                //添加数组序号
                recommandPostDic[post.id] = recommandPostList.list.count - 1
            }
        
        case .hot:
            for post in list.list {
                //先更新本地数据
                update(post)
                //找到了数据，重复，进入下一次循环
                if hotPostDic[post.id] != nil { continue }
                //没有找到数据，添加数据
                hotPostList.list.append(post)
                //添加数组序号
                hotPostDic[post.id] = hotPostList.list.count - 1
            }
        }
    }
    
    /// 处理下拉刷新网络请求得到的数据，并实时更新
    /// - Parameters:
    ///   - list: 请求得到的List
    ///   - category: 分类
    private func handleRefreshPostList(_ list: PostList, for category: PostListCategory) {
        //定义临时字典和List
        var tempList: [Post] = []
        var tempDic: [Int: Int] = [:]
        //循环得到每一个list中的index和post
        for (index, post) in list.list.enumerated() {
            //如果找到了id参数，则说明有重复，进入下一次操作
            if tempDic[post.id] != nil { continue }
            //如果没有找到id参数，则说明是新元素，需要加入数组
            tempList.append(post)
            tempDic[post.id] = index
            update(post) //更新本地数据
            
        }
        //需要更新recommandPostDic和recommandPostList
        switch category {
        case .recommand:
            recommandPostList.list = tempList
            recommandPostDic = tempDic
        case .hot:
            hotPostList.list = tempList
            hotPostDic = tempDic
        }
        reloadData = true

        
    }
    
    /// 处理错误方法
    /// - Parameter error: 错误信息
    private func handleLoadingError(_ error: Error) {
        loadingError = error
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingError = nil
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
