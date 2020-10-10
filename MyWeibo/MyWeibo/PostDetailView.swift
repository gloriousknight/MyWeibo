//
//  PostDetaiView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/20.
//
//微博详情页面，显示微博与评论
import SwiftUI
import BBSwiftUIKit

struct PostDetailView: View {
    let post: Post
    var body: some View {
        BBTableView(0...15) { i in
            if i == 0 {
                PostCell(post: self.post)
            } else {
                HStack {
                    Text("评论\(i)") .padding()
                    Spacer()
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData.testData
            return PostDetailView(post: userData.recommandPostList.list[0]).environmentObject(userData)
       
    }
}
