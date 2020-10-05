//
//  NetworkAPI.swift
//  NetworkDemo
//
//  Created by BaronZhang on 2020/10/3.
//封装获取微博列表的API

import Foundation

class NetworkAPI {
    
    
    /// 获取推荐列表的接口
    /// - Parameter completion: 闭包参数
    static func recommandPostList(completion: @escaping (Result<PostList, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "PostListData_recommend_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<PostList, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    /// 获取热门列表的接口
    /// - Parameter completion: 闭包参数
    static func hotPostList(completion: @escaping (Result<PostList, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "PostListData_hot_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<PostList, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    /// 定义一个发微博的接口，假设微博只有文字内容，使用POST方法
    /// - Parameters:
    ///   - text: 发送的文字内容
    ///   - completion: 闭包参数
    static func creatPost(text: String, completion: @escaping (Result<Post, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "Creatpost", parameters: ["text": text]) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<Post, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    /// 定义解析JSON方法
    /// - Parameter data: 待解析的数据，符合泛型T，Decodable协议
    /// - Returns: 返回解析成功或失败的Result
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
            return .failure(error)
        }
        return .success(decodedData)
    }
    
    
}
