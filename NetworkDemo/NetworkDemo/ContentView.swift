//
//  ContentView.swift
//  NetworkDemo
//
//  Created by BaronZhang on 2020/10/4.
//

import SwiftUI

struct ContentView: View {
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
        let url = URL(string: "https://github.com/gloriousknight/MyWeibo/raw/master/MyWeibo/MyWeibo/Resources/PostListData_recommend_1.json")!
        
        //设置请求参数
        var request = URLRequest(url: url)
        //设置请求超时的时间
        request.timeoutInterval = 15
        
        //测试POST方法，body里存放字典，并修改为JSON数据
        request.httpMethod = "POST"
        let dic = ["key": "Value"]
        let data = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        request.httpBody = data
        //HTTP Header参数设置
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        ///URL Session变量很消耗内存，创建共享的URLSession datatask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            ///检查error，尝试取出error参数，如果有错误就不执行代码
            if let error = error {
                //为了不写线程，使用DispatchQueue，异步执行
                self.updateText(error.localizedDescription)
                return
            }
            ///检查response，如果返回码是200则有效
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                self.updateText("Invalid Response")
                return
            }
            
            ///检查Data，保证Data不为空
            guard let data = data else {
                self.updateText("No Data")
                return
            }
            
            ///解析JSON数据
            guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
                self.updateText("Cannot parse data")
                return
            }
            self.updateText("Post count \(list.list.count)")
        }
        //执行任务
        task.resume()
    }
    
    /// 返回错误信息
    /// - Parameter text: 错误信息
    func updateText(_ text: String) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
