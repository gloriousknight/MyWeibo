//
//  OriginalButtonStyle.swift
//  MyWeibo
//
//  Created by BaronZhang on 2020/10/10.
//  定义原始Button样式

import SwiftUI

struct OriginalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
