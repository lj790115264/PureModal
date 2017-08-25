//
//  PureProgressView.swift
//  PureModal
//
//  Created by 孙一萌 on 2017/8/25.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

public enum PureProgressViewStyle {
    case circle
    case line
}

open class PureProgressView: UIProgressView {
    convenience init(withStyle style: PureProgressViewStyle?) {
        self.init(progressViewStyle: .default)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
