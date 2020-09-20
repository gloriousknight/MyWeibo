//
//  HomeNavigationBar.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/20.
//
//定义主页导航页面
import SwiftUI
private let kLabelWidth: CGFloat = 60
private let kButtonHeight:CGFloat = 24
private let kButtonBetweenWidth:CGFloat = UIScreen.main.bounds.width * 0.5

struct HomeNavigationBar: View {
    @State var leftPercent: CGFloat //0 for Left, 1 for Right //属性可更改
    
    var body: some View {
        //添加左右两边拍照和新建按钮
        HStack(alignment: .top, spacing: 0) {
            //相机按钮
            Button(action:  {
                print("Click Camara Button")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 6)
                    .foregroundColor(.black)
                
            }
            Spacer()
            
            //添加下划线（垂直）
            VStack(spacing: 3) {
                //推荐+热门（水平）
                HStack(spacing: 0) {
                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        //点击推荐后下划线移动并更改透明度
                        .opacity(Double(1 - leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 0
                            }
                        }
                    
                    Spacer()
                    
                    Text("热门")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                            }
                        }
                }
                .font(.system(size: 20))
                //下划线(圆角)
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.orange)
                    .frame(width: 30, height: 4)
                    .offset(x: kButtonBetweenWidth * (self.leftPercent - 0.5) + kLabelWidth * (0.5 - self.leftPercent))
                
    //            GeometryReader { geometry in
    //
    //            }
    //            .frame(height: 60)
            }
            .frame(width: kButtonBetweenWidth)
            Spacer()
            //新建按钮
            Button(action:  {
                print("Click Add Button")
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 6)
                    .foregroundColor(.orange)
            }

        }
        .frame(width: UIScreen.main.bounds.width)
    }
        
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: 0)
    }
}
