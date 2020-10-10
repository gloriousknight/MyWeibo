//
//  HomeView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/20.
//
///环境对象（enviromentObject）



import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 1 //@State属性通常是这个View自己用，或者传递给这个View的子View，如果需要传递给子View，子View中的定义就要换成@Binding，这两个属性就绑定到了一起。@Binding见 HomeNavigationBar.swift和HScrollView.swift
    var body: some View {
            NavigationView {
                GeometryReader { geometry in
                    HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),
                                          leftPercent: self.$leftPercent) {
                        HStack(spacing: 0) {
                            PostListView(category: .recommand)
                                .frame(width: UIScreen.main.bounds.width)
                            PostListView(category: .hot)
                                .frame(width: UIScreen.main.bounds.width)
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                
                //添加左右滑动的ScrollView，忽略安全区域
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent)) //将首页的属性leftPercent与HomeNavigationBar的属性绑定到一起
                .navigationBarTitle("首页", displayMode: .inline)
            }
            .navigationViewStyle(StackNavigationViewStyle()) //适配iPad

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone X")
            .environmentObject(UserData.testData)
    }
}
