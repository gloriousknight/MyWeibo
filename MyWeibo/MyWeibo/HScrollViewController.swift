//
//  HScrollViewController.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/25.
//
//水平方向的ScrollView
import SwiftUI

struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth: CGFloat //每页滑动的宽度
    let contentSize: CGSize //内容的宽度
    let content: Content //泛型
    @Binding var leftPercent: CGFloat
    
    init(pageWidth: CGFloat,
         contentSize: CGSize,
         leftPercent: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
    }
    
    /// 定义Coordinator
    /// - Returns: 返回本身的Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    /// 创建UIViewController
    /// - Parameter context: Context
    /// - Returns: 返回ViewController
    func makeUIViewController(context: Context) -> some UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false //关闭回弹效果
        scrollView.isPagingEnabled = true //开启分页效果
        scrollView.showsHorizontalScrollIndicator = false //隐藏滚动条
        scrollView.showsVerticalScrollIndicator = false //隐藏滚动条
        scrollView.delegate = context.coordinator //定义代理
        context.coordinator.scrollView = scrollView
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        //把Content ScrollView里面的内容添加到scrollView里面
        let host = UIHostingController(rootView: content) //桥接，把SwiftUI的View封装成了UIKit的UIViewController
        vc.addChild(host) //建立两个UIViewController的层级关系
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)  //host已经添加到VC上了
        context.coordinator.host = host
        
        return vc
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let scrollView = context.coordinator.scrollView! //取出UIScrollView里的scrollView
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true) //定义offset，X坐标为（内容的宽度-页面的宽度） * leftPercent
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)  //取出Host并设置host view的大小


    }
    
    /// 定义继承NSObject类的Coordinator
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                if scrollView.contentOffset.x <= parent.pageWidth * 0.5 {
                    parent.leftPercent = 0
//                    print("应该显示左边了")
                }else {
                    parent.leftPercent = 1
//                    print("应该显示右边了")
                }

            }
        }
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            print("1")
//        }
    }
}
