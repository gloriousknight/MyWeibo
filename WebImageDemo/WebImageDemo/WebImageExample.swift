//
//  WebImageExample.swift
//  WebImageDemo
//
//  Created by BaronZhang.
//网络图片库：网络图片控件（没有图片数据显示占位图，有图片数据显示图片）
// 图片下载管理（如果对同一个URL连续启动两个加载任务，可以合并加载任务）
// 图片数据解码（解析图片格式）
//图片缓存管理（一个URL对应一张图片，最近用到的图片直接从本地获取，减少图片加载时间）

import SwiftUI
import SDWebImageSwiftUI

struct WebImageExample: View {
    let url: URL?
    var body: some View {
        //展示网络图片控件
        WebImage(url: url)
            .placeholder { Color.gray }
            .resizable()
            //清除缓存功能
            .onSuccess(perform: {_, _, _ in
                print("Success")
                SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)
            })
            .onFailure(perform: { _ in
                print("Failure")
                
            })
            .scaledToFill()
            .frame(width: 300, height: 300, alignment: .center)
            .clipped()
    }
}


