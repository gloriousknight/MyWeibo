//
//  CommentInputView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/28.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post
    @State private var text: String = ""
    //添加属性表示是否显示评论不能为空文字
    @State private var showEmptyTextHUD: Bool = false
    
    ///根据系统提供的信息使modal页面消失
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    
    @ObservedObject private var keyboardResponder = KeyBoardResponder() //和环境对象类似，但是需要赋值
    
    var body: some View {
        VStack(spacing: 0) {
            CommentTextView(text: $text, beginEditingOnAppear: true)
            
            HStack(spacing: 0) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss() //点击取消modal页面
                }) {
                    Text("取消").padding()
                }
                Spacer()
                
                Button(action: {
//               判断self.text是否为空的字符串，如果为空，就要显示评论不能为空的提示
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmptyTextHUD = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEmptyTextHUD = false
                        } //1.5秒后提示消失
                        return
                    }
                    print(self.text)
                    var post = self.post //定义局部变量post
                    post.commentCount += 1 //使评论数加一
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("发送").padding()
                }
            }
            .font(.system(size: 18))
            .foregroundColor(.black)
    //        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5) //设置缩放
                .animation(.spring(dampingFraction: 0.5)) //添加sping动画回弹效果
                .opacity(showEmptyTextHUD ? 1 : 0) //根据showEmptyTextHUD设置文字不透明度
                .animation(.easeInOut) //添加动画
        ) //添加评论不能为空的提示
        .padding(.bottom, keyboardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponder.keyboardShow ? .bottom : []) //当键盘弹起的时候忽略底部安全距离
        
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData.testData.recommandPostList.list[0])
    }
}
