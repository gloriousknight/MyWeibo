//
//  PostCell.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/17.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        //水平排列
        HStack(spacing: 5) {
            //显示头像
            Image(uiImage: UIImage(named: "630584a6gy1gau54zl806j20m80etmzo.jpg")!)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                //添加Vip标示
                .overlay(
                    PostVIPBadge()
                        .offset(x: 16, y: 16)
                )
                
            
            
            //纵向排列用户昵称和时间
            VStack(alignment: .leading, spacing: 5) {
                Text("用户昵称")
                    .font(Font.system(size: 16))
                    .foregroundColor(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                    .lineLimit(1)
                Text("2020-09-11")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
//                Image(uiImage: UIImage(named: "avatar.jpg")!)
                
            }
            .padding(.leading, 10) //调整上下左右的间距
            //空间占位使昵称和关注按钮分别在屏幕两侧
            Spacer()
            
            Button(action: {
                print("Click Following Button")
            }) {
                Text("关注")
                    .font(.system(size: 14))
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 26) //设置按钮的宽高，方便设置圆角半径，并增大按钮点击区域
                    .overlay( //叠加视图画圆角矩形
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.orange, lineWidth: 1) //描边
                    )
            }

        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}
