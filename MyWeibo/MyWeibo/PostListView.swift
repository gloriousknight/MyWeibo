//
//  PostListView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
///显示微博列表
import SwiftUI

struct PostListView: View {
    let category: PostListCategory
//   已经修改为环境对象
//    var postList: PostList {
//        switch category {
//        case .recommand:
//            return loadPostListData("PostListData_recommend_1.json")
//        case .hot:
//            return loadPostListData("PostListData_hot_1.json")
//        }
//    }
    @EnvironmentObject var userData: UserData
    //隐藏分割线
    var body: some View {
        List {
            ForEach(userData.postList(for: category).list) { post in
                ZStack {
                    PostCell(post: post)
//                    NavigationLink(destination: PostDetailView(post: post)) {
//                        EmptyView()
//                    }
                    NavigationLink(destination: PostDetailView(post: post)) {
                       EmptyView()
                    }
//                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(category: .recommand)
                .navigationBarItems(leading: Text("Sss"))
//                .edgesIgnoringSafeArea(.all)
//                .navigationBarTitle("Title")
//                .navigationBarHidden(true)
        }
        .environmentObject(UserData())
        
    }
}
