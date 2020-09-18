//
//  PostImageCell.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
//显示微博下方多张图片
import SwiftUI

struct PostImageCell: View {
    let images: [String]
    
    //宽度设置
    let width: CGFloat
    
    var body: some View {
        Group {
            if images.count == 1{
                loadImage(name: images[0])
                    .resizable()
                    .scaledToFill() //保持宽高比填充整个空间
                    .frame(width: width, height: (UIScreen.main.bounds.width - 30) * 0.75) //设置显示宽高比4:3，width：屏幕宽度 - 左右两边的间距（30） height: 宽度 * 0.75
                    .clipped()
            } else if images.count == 2 {
                
            } else if images.count == 3 {
                
            } else if images.count == 4 {
                
            } else if images.count == 5 {
                
            } else if images.count == 6 {
                
            }
        }
    }
}

struct PostImageCellRow: View {
    let images: [String]
    //一整行的宽度
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(images, id: \.self) { image in
                loadImage(name: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: self.width - 6 * CGFloat(self.images.count - 1)) //在闭包里使用属性需要加Self
                
            }
        }
    }
}

struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
        let images = postList.list[0].images
        let width = UIScreen.main.bounds.width
        return PostImageCell(images: Array(images[0...0]), width: width)
    }
}
