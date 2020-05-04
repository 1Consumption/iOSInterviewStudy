//
//  PieChartView.swift
//  MyChart
//
//  Created by 신한섭 on 2020/05/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class PieChartView: UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return width
        } set {
            width = newValue
        }
    }
    
    @IBInspectable var isDoughnutVisible: Bool {
        get {
            return doughnutFactor
        } set {
            doughnutFactor = newValue
        }
    }
    
    private var width: CGFloat = 10
    private var doughnutFactor: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var element: [CGFloat] = [1, 2, 3]
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        var curAngle: CGFloat = 0
        element.forEach {
            let path = UIBezierPath()
            path.lineWidth = width
            UIColor.random().setFill()
            UIColor.white.setStroke()
            path.move(to: center)
            path.addArc(withCenter: center, radius: self.frame.width / 2.1, startAngle: curAngle, endAngle: $0 / element.reduce(0, +) * .pi * 2 + curAngle, clockwise: true)
            path.close()
            path.stroke()
            path.fill()
            curAngle += $0 / element.reduce(0, +) * .pi * 2
        }
        if doughnutFactor {
        drawDoughnut(center: center)
        }
    }
    
    func drawDoughnut(center: CGPoint) {
        let path = UIBezierPath(arcCenter: center, radius: self.frame.width / 4, startAngle: 0, endAngle: 360, clockwise: true)
        UIColor.white.set()
        path.fill()
    }
    
    func setGraph(element: [CGFloat]) {
        self.element = element
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
