//
//  PostListView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
///显示微博列表
import SwiftUI

struct PostListView: View {
    //隐藏分割线
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    
    var body: some View {
        List {
            ForEach(postList.list) { post in
                PostCell(post: post)
                    .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
