//
//  CommentTextView.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/28.
//编辑多行文本的页面，将UIKit中UITextView封装成SwiftUI的View

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text: String
    
    let beginEditingOnAppear: Bool  //定义刚打开评论页面的时候就开始编辑的属性
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15) //设置字体与View边框的间距
        view.delegate = context.coordinator //设置代理
        view.text = text
        return view
    }
    
    /// 更新View的时候让UITextView进入编辑状态
    /// - Parameters:
    ///   - uiView: <#uiView description#>
    ///   - context: <#context description#>
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if beginEditingOnAppear,
           !context.coordinator.didBecomeFirstResponder,
           uiView.window != nil,
           //如果不是第一响应者
           !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent : CommentTextView
        //添加属性判断是否已经进入过编辑状态
        var didBecomeFirstResponder: Bool = false
        init(_ view: CommentTextView) { parent = view }
        ///文本框的内容发生变化的时候调用，每一次输入一个字母都会被调用，可以用这个文本更新数据
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text //取出当前文本框的文本赋值给当前的的binding text属性
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant("ss"), beginEditingOnAppear: true)
    }
}
