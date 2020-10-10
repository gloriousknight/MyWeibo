//
//  PostListViewBBSwift.swift
//  MyWeibo
//  Created by BaronZhang on 2020/10/10.
//  添加下拉刷新功能

import SwiftUI
import BBSwiftUIKit

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
        BBTableView(userData.postList(for: category).list) { post in
            NavigationLink(destination: PostDetailView(post: post)) {
                PostCell(post: post)
            }
            .buttonStyle(OriginalButtonStyle())
        }
        .bb_setupRefreshControl { control in
            control.attributedTitle = NSAttributedString(string: "加载中")
            
        }
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
            self.userData.refreshPostList(for: self.category)
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            self.userData.loadMorePostList(for: self.category)
        }
        .bb_reloadData($userData.reloadData)
        //页面加载时调用loadPostListIfNeeded方法
        .onAppear {
            self.userData.loadPostListIfNeeded(for: self.category)
        }
        //加载错误提示语
        .overlay(
            Text(userData.loadingErrorText)
                .bold()
                .frame(width: 200)
                .padding()
                .background(
                    //圆角矩形
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    
                )
                .animation(nil)
                .scaleEffect(userData.showLoadingError ? 1 : 0.5) //设置缩放
                .animation(.spring(dampingFraction: 0.5)) //添加sping动画回弹效果
                .opacity(userData.showLoadingError ? 1 : 0) //根据showEmptyTextHUD设置文字不透明度
                .animation(.easeInOut) //添加动画
        )
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
