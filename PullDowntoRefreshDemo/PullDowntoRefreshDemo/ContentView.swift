//
//  ContentView.swift
//  PullDowntoRefreshDemo
//
//  Created by BaronZhang.
//  下拉刷新和上拉加载更多

import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    //定义初始化数组
    @State var list: [Int] = (0..<50).map { $0 }
    //是否刷新参数
    @State var isRefreshing = false
    //判断是否需要加载更多
    @State var isLoadingMore = false
    var body: some View {
        BBTableView(list) { i in
            Text("Text\(i)")
                .padding()
                .background(Color.blue)
            
        }
        //设置下拉刷新图标的样式
        .bb_setupRefreshControl{ control in
            control.tintColor = .red
            control.attributedTitle = NSAttributedString(string: "加载中...", attributes: [.foregroundColor: UIColor.blue])
        }
        .bb_pullDownToRefresh(isRefreshing: $isRefreshing) {
            print("Refresh")
            //1秒后结束刷新，重置数据
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.list = (0..<50).map { $0 }
                self.isRefreshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            if self.isLoadingMore || self.list.count >= 100 {
                return
            }
            self.isLoadingMore = true
            print("Load more")
            //1秒后结束加载，并添加数据
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let more = self.list.count..<self.list.count + 10
                self.list.append(contentsOf: more)
                self.isLoadingMore = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
