//
//  CAShapeLayerViewController.swift
//  UIBezierPath
//
//  Created by Zedd on 04/10/2019.
//  Copyright © 2019 Zedd. All rights reserved.
//

import UIKit

class CAShapeLayerViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let view = CAView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        view.backgroundColor = .lightGray
        self.view.addSubview(view)
    }
}

private class CAView: UIView, CAAnimationDelegate {
    
    let circleLayer: CAShapeLayer = CAShapeLayer()
    
    var startAngle: CGFloat = (-(.pi) / 2)
    var endAngle: CGFloat = 0.0
    let values: [CGFloat] = [10, 20, 70]
    var currentIndex: Int = 0
    var myCenter = CGPoint.zero

    let colors = [UIColor.orange, UIColor.systemYellow, UIColor.systemGreen, UIColor.systemPink, UIColor.cyan, UIColor.systemTeal, UIColor.systemIndigo, UIColor.systemPurple]
    
    override func draw(_ rect: CGRect) {
        self.myCenter = CGPoint(x: rect.midX, y: rect.midY)
        self.add(value: values[currentIndex])
    }
    
    func add(value: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        let total = values.reduce(0, +)
        endAngle = (value / total) * (.pi * 2)
        let path = UIBezierPath(arcCenter: self.myCenter, radius: 60, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = self.colors.randomElement()?.cgColor
        sliceLayer.lineWidth = 80
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        self.layer.addSublayer(sliceLayer)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let isFinished = flag
        if isFinished && currentIndex < self.values.count - 1 {
            self.currentIndex += 1
            self.startAngle += endAngle
            self.add(value: self.values[currentIndex])
        }
    }
}
