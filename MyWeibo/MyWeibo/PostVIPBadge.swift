//
//  PostVIPBadge.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/17.
//
//定义VIP标志
import SwiftUI
//定义VIP标志
struct PostVIPBadge: View {
    //指定判断是否为Vip标志
    let vip: Bool
    var body: some View {
       //将Vip标志放置在Group里，如果是Vip就显示Vip，如果不是就为空
        Group {
            if vip{
                Text("V") //文字V
                    .bold() //加粗
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow) //字体颜色
                    .background(Color.red) //北京颜色
                    .clipShape(Circle()) //切割成圆形
                    //添加圆角边框，半径是宽度的一半，颜色是白色，线宽为1
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(Color.white, lineWidth: 1)
                    )
                
            }
            
        }


    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip: true)
    }
}
