//
//  AlamofireOpration.swift
//  NetworkDemo
//
//  Created by BaronZhang on 2020/10/4.
//

import SwiftUI


struct AlamofireOpration: View {
    @State private var text = ""
    var body: some View {
        VStack {
            Text(text).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.startLoad()
            }) {
                Text("Start").font(.largeTitle)
            }
            
            Button(action: {
                self.text = ""
            }) {
                Text("Clear").font(.largeTitle)
            }
        }
    }
    
    //发送网络请求，获取微博列表，显示一共有几条微博
    func startLoad() {
        //使用NetworkAPI
        NetworkAPI.hotPostList { result in
            switch result {
            case let .success(list) : self.updateText("Post count \(list.list.count)")
            case let .failure(error) : self.updateText(error.localizedDescription)
            }
            
        }
        //直接使用Alamofire，比较烦杂
//        NetworkManager.shared.requestGet(path: "PostListData_recommend_1.json", parameters: nil) { result in
//            switch result {
//            case let .success(data):
//                ///解析JSON数据
//                guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
//                    self.updateText("Cannot parse data")
//                    return
//                }
//                self.updateText("Post count \(list.list.count)")
//            case let .failure(error):
//                self.updateText(error.localizedDescription)
//            }
//        }
    }
    
    /// 返回错误信息
    /// - Parameter text: 错误信息
    func updateText(_ text: String) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
    
    
}

struct AlamofireOpration_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
