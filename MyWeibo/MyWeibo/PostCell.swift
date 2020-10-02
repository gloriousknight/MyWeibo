//
//  PostCell.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/9/17.
//
//程序主界面
import SwiftUI

struct PostCell: View {
    let post: Post
    
    var bindingPost: Post {
        userData.post(forId: post.id)!
    }
    
    @State var presentComment = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        //定义局部变量post，使用bindingPost变量
        var post = bindingPost
        
        //增加微博详情+图片
        return VStack(alignment: .leading, spacing: 10) {
            //水平头像/昵称/关注按钮
            HStack(spacing: 5) {
                //显示头像
                post.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    //添加Vip标示
                    .overlay(
                        PostVIPBadge(vip: post.vip)
                            .offset(x: 16, y: 16)
                    )
                //纵向排列用户昵称和时间
                VStack(alignment: .leading, spacing: 5) {
                    Text(post.name)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading, 10) //调整上下左右的间距
                //关注按钮
                if !post.isFollowed {
                    //空间占位使昵称和关注按钮分别在屏幕两侧
                    Spacer()
                    
                    Button(action: {
                        //点关注按钮后更新Post的View
                        post.isFollowed = true
                        self.userData.update(post)
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
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
            }
            //微博内容
            Text(post.text)
                .font(.system(size: 17)) //字体大小
            if !post.images.isEmpty {
//                Image(uiImage: UIImage(named: post.images[0]))
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
            }
            //增加分割线
            Divider()
            //添加评论+点赞按钮
            HStack(spacing: 0) {
                Spacer()
                
                PostCellToBarButton(image: "message",
                                    text: post.commentCountText,
                                    color: .black)
                {
                    self.presentComment = true //点击后出现CommentInputView
                }
                //modalPresentationStyle 由下至上显示页面，可以向下拖拽消失
                .sheet(isPresented: $presentComment, content: {
                    CommentInputView(post: post).environmentObject(self.userData)
                })
                
                Spacer()
                
                PostCellToBarButton(image: post.isLiked ? "heart.fill" : "heart",
                                    text: post.likeCountText,
                                    color: post.isLiked ? .red : .black)
                {
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                        
                    }else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    self.userData.update(post)
                }
                Spacer()
            }
            //添加一个与屏幕两边都连接的矩形（分割线）
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
        .padding(.horizontal, 15) //设置VStack和屏幕两边的间距为15
        .padding(.top, 15) //添加上部间距
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
            let userData = UserData()
        return PostCell(post: userData.recommandPostList.list[7]).environmentObject(userData)

        
        
    }
}
