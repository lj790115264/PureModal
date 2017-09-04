//
//  PureProgressView.swift
//  PureModal
//
//  Created by 孙一萌 on 2017/8/25.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

public enum PureProgressViewStyle {
    case spinning
    case progress
}

open class PureProgressView: UIView {
    var style: PureProgressViewStyle!
    let spinDuration = 1.6
    var animator: UIViewPropertyAnimator {
        let angle: CGFloat = 180
        let rotate: () -> Void = {
            self.transform = self.transform.rotated(by: angle.asRadians)
        }
        let animator = UIViewPropertyAnimator(duration: spinDuration, curve: .linear, animations: nil)
        animator.addAnimations(rotate)
        animator.addAnimations(rotate)
        return animator
    }
    
    var currentAnimator: UIViewPropertyAnimator?
    
    public init(withStyle style: PureProgressViewStyle) {
        super.init(frame: CGRect(x: 20, y: 20, width: 32, height: 32))
        backgroundColor = UIColor(white: 0, alpha: 0)
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    open override func draw(_ rect: CGRect) {
        let centerPoint: CGPoint = {
            var point = CGPoint()
            point.x = self.bounds.midX
            point.y = self.bounds.midY
            return point
        }()

        let innerRect: CGRect = {
            let ringWidth: CGFloat = 4.8
            let width = self.bounds.size.width - ringWidth * 2

            let size = CGSize(width: width, height: width)
            let origin = CGPoint(x: ringWidth, y: ringWidth)
            return CGRect(origin: origin, size: size)
        }()

        switch style {
        case .spinning:
            let start: CGFloat = -90, end: CGFloat = 132
            let outerArc = UIBezierPath()
            outerArc.move(to: centerPoint)
            outerArc.addArc(withCenter: centerPoint, radius: centerPoint.x, startAngle: start.asRadians, endAngle: end.asRadians, clockwise: true)
            outerArc.close()
            tintColor.setFill()
            outerArc.fill()

            let innerCircle = UIBezierPath(ovalIn: innerRect)
            self.superview?.backgroundColor?.setFill()
            innerCircle.fill()
            
            startSpinning()
        default:
            break
        }
    }
    
    private func startSpinning() {
        let timer = Timer.scheduledTimer(withTimeInterval: spinDuration, repeats: true) { _ in
            self.animator.startAnimation()
        }
        timer.fire()
    }
}

extension CGFloat {
    var asRadians: CGFloat {
        return self * .pi / 180.0
    }
}

