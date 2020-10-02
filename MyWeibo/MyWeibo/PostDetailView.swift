//
//  PostDetaiView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/20.
//
//微博详情页面，显示微博与评论
import SwiftUI

struct PostDetailView: View {
    let post: Post
    var body: some View {
        List {
            PostCell(post: post)
                .listRowInsets(EdgeInsets()) //间距为空
            //循环生成评论
            ForEach(1...10, id: \.self) { i  in
                Text("评论\(i)")
            }
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
            let userData = UserData()
            return PostDetailView(post: userData.recommandPostList.list[0]).environmentObject(userData)
       
    }
}
