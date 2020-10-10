//
//  ContentView.swift
//  WebImageDemo
//
//  Created by BaronZhang.
//加载网络图片

import SwiftUI

private let url = URL(string: "https://github.com/gloriousknight/MyWeibo/raw/master/MyWeibo/MyWeibo/Resources/005tnxzUly8gab4i2r73xj30u00u0js8.jpg")!

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SimpleExample(url: url)) {
                    Text("Simple Example")
                }
                NavigationLink(
                    destination: WebImageExample(url: url),
                    label: {
                        Text("Web Image Example")
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
