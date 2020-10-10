//
//  PostImageCell.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
//显示微博下方多张图片
import SwiftUI

//定义全局变量：图片间距6
private let kImageSpace: CGFloat = 6

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
                PostImageCellRow(images: images, width: width)
            } else if images.count == 3 {
                PostImageCellRow(images: images, width: width)
            } else if images.count == 4 {
                VStack(spacing: kImageSpace) {
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...3]), width: width)
                }
            } else if images.count == 5 {
                VStack(spacing: kImageSpace) {
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...4]), width: width)
                }
                
            } else if images.count == 6 {
                VStack(spacing: kImageSpace) {
                    PostImageCellRow(images: Array(images[0...2]), width: width)
                    PostImageCellRow(images: Array(images[3...5]), width: width)
                }
            }
        }
    }
}

struct PostImageCellRow: View {
    let images: [String]
    //一整行的宽度
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: kImageSpace) {
            ForEach(images, id: \.self) { image in
                loadImage(name: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (self.width - kImageSpace * CGFloat(self.images.count - 1)) / CGFloat(self.images.count), height: (self.width - kImageSpace * CGFloat(self.images.count - 1)) / CGFloat(self.images.count))//在闭包里使用属性需要加self。图片宽度= 传入的width 减6乘图片数量减1除以图片数量
                    .clipped()
            }
        }
    }
}

struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
        let images = UserData.testData.recommandPostList.list[0].images
        let width = UIScreen.main.bounds.width
        return Group {
            PostImageCell(images: Array(images[0...0]), width: width)
            PostImageCell(images: Array(images[0...1]), width: width)
            PostImageCell(images: Array(images[0...2]), width: width)
            PostImageCell(images: Array(images[0...3]), width: width)
            PostImageCell(images: Array(images[0...4]), width: width)
            PostImageCell(images: Array(images[0...5]), width: width)
        }
        .previewLayout(.fixed(width: width, height: 300))
    }
}
