//
//  KeyBoardResponder.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/10/2.
//
//键盘监听

import SwiftUI

class KeyBoardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0 //键盘高度属性
    
    var keyboardShow: Bool { keyboardHeight > 0} //设置键盘是否显示的属性，高度大于0显示
    
    /// 监听键盘的弹出和消失
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil) //在默认的通知中心，添加一个通知监听者用来监听键盘即将出现的通知，当键盘即将出现的时候，调用keboardWillShow方法
        //监听键盘退出事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    ///析构方法销毁监听事件
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        } //获取键盘的位置和大小,并尝试转换为CGRect
        
        keyboardHeight = frame.height //获取键盘高度
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
    }
}

