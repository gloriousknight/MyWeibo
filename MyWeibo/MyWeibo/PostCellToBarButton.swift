//
//  PostCellToBarButton.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/18.
//
//定义点赞+评论按钮
import SwiftUI

struct PostCellToBarButton: View {
    //添加属性
    let image: String
    let text: String
    let color: Color
    //添加行动属性（闭包）
    let action: () -> Void // closure, function
    
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: image)
                    .resizable() //可缩放
                    .scaledToFit() //填充适应界面
                    .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToBarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToBarButton(image: "heart", text: "点赞", color: .red) {
            print("点赞")
        }
    }
}
