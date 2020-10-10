//
//  SimpleExample.swift
//  WebImageDemo
//
//  Created by BaronZhang.
//  自定义的网络图片加载任务

import SwiftUI

struct SimpleExample: View {
    //定义图片URL
    let url: URL?
    //定义图片数据
    @State private var data: Data?
    //根据图片数据生成UIImage
    private var image: UIImage? {
        if let data = self.data { return UIImage(data: data) }
        return nil
    }
    //有图片数据显示图片，没有图片数据显示灰色
    var body: some View {
        let image = self.image
        return Group {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray
            }
        }
        .frame(height: 200)
        .clipped()
        //在控件显示的时候执行onAppear的闭包指令
        .onAppear {
            //url不为空，图片数据为空
            if let url = self.url, self.data == nil {
//                //加载图片数据，给data赋值，在主线程执行，影响代码执行
//                self.data = try? Data(contentsOf: url)
                //使用子线程执行
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            }
        }
    }
}


