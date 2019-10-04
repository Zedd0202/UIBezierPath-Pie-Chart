//
//  ViewController.swift
//  UIBezierPath
//
//  Created by Zedd on 27/09/2019.
//  Copyright © 2019 Zedd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = ZeddView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.center = self.view.center
        view.backgroundColor = .clear
        self.view.addSubview(view)
    }
}

class ZeddView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let colors = [UIColor.orange, UIColor.black, UIColor.systemGreen, UIColor.systemPink, UIColor.cyan, UIColor.systemTeal]

        let values: [CGFloat] = [10, 20, 70]
        let total = values.reduce(0, +)
        
        //x degree = x * π / 180 radian
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0
        
        values.forEach { (value) in
            endAngle = (value / total) * (.pi * 2)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                        radius: 60,
                        startAngle: startAngle,
                        endAngle: startAngle + endAngle,
                        clockwise: true)
            
            colors.randomElement()?.set()
            path.fill()
            startAngle += endAngle
        }
    }
}
