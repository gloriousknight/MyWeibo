//
//  HomeView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            PostListView()
                .navigationBarItems(leading: Text("s"))
                .navigationBarTitle("首页", displayMode: .inline)

            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
