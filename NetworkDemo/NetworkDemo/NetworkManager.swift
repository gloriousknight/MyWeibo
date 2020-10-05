//
//  NetworkManager.swift
//  NetworkDemo
//
//  Created by BaronZhang on 2020/10/4.
//单例模式，封装HTTP请求

import Foundation
import Alamofire
//定义域名路径
private let NetworkAPIBaseURL = "https://github.com/gloriousknight/MyWeibo/raw/master/MyWeibo/MyWeibo/Resources/"
//定义网络请求返回值类型
typealias NetworkRequestResult = Result<Data, Error>
//定义网络请求回调类型
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

class NetworkManager {
    static let shared = NetworkManager()  //单例模式定义
    private init() {} //外部无法使用NetworkManager创建新的变量的定义
    
    var commonHeaders : HTTPHeaders { ["user_id": "123", "token": "XXX"] }
    
    /// 定义封装Get请求
    /// - Parameters:
    ///   - path: 拼接在域名后的路径
    ///   - parameters: HTTP拼接在路径后的参数
    ///   - completion: 请求完成后的闭包(回调)，是一个逃逸闭包，闭包参数类型是Result（枚举类型）
    /// - Returns: 返回DataRequest，可以不使用返回值
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15})
            .responseData {response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
            }
    }
    
    
    
    /// 封装HTTP POST请求
    /// - Parameters:
    ///   - path: 拼接在域名后的路径
    ///   - parameters: HTTP拼接在路径后的参数
    ///   - completion: 请求完成后的闭包(回调)，是一个逃逸闭包，闭包参数类型是Result（枚举类型）
    /// - Returns: 返回DataRequest，可以不使用返回值
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData {response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
            }
 
    }
    
    /// 处理网络请求超时的错误信息
    /// - Parameter error: 错误信息
    /// - Returns: 自定义的请求结果NetworkRequestResult
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code =  nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
               code == NSURLErrorTimedOut ||
               code == NSURLErrorInternationalRoamingOff ||
               code == NSURLErrorDataNotAllowed ||
               code == NSURLErrorCannotFindHost ||
               code == NSURLErrorCannotConnectToHost ||
               code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Network Error"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
    
}


