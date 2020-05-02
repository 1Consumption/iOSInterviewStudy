//
//  BarChartView.swift
//  MyChart
//
//  Created by 신한섭 on 2020/05/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable class BarChartView: UIView {
    
    @IBInspectable var barGraphColor: UIColor {
        get {
            return barPathColor
        } set {
            barPathColor = newValue
        }
    }
    
    @IBInspectable var lineGraphColor: UIColor {
        get {
            return linePathColor
        } set {
            linePathColor = newValue
        }
    }
    
    @IBInspectable var showBarGraph: Bool {
        get {
            return isBarGraphVisible
        } set {
            isBarGraphVisible = newValue
        }
    }
    
    @IBInspectable var showLineGraph: Bool {
        get {
            return isLineGraphVisible
        } set {
            isLineGraphVisible = newValue
        }
    }
    
    private var isBarGraphVisible = true
    private var isLineGraphVisible = true
    private var element: [CGFloat] = [1,2,3,4]
    private var barPathColor = UIColor.black
    private var linePathColor = UIColor.black
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .gray
        setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let chartWidth = self.frame.width / (CGFloat)(element.count * 2 - 1)
        if isBarGraphVisible {
            drawBarGraph(chartWidth: chartWidth)
        }
        
        if isLineGraphVisible {
            drawLineGraph(chartSpace: chartWidth)
            drawCircle(chartSpace: chartWidth)
        }
    }
    
    func drawBarGraph(chartWidth: CGFloat) {
        for (index, num) in element.enumerated() {
            let path = UIBezierPath()
            barPathColor.set()
            path.move(to: CGPoint(x: CGFloat(index * 2) * chartWidth, y: self.frame.height))
            path.addLine(to: CGPoint(x: CGFloat(index * 2 + 1) * chartWidth, y: self.frame.height))
            path.addLine(to: CGPoint(x: CGFloat(index * 2 + 1) * chartWidth, y: self.frame.height - (num / 100.0) * self.frame.height))
            path.addLine(to: CGPoint(x: CGFloat(index * 2) * chartWidth, y: self.frame.height -  (num / 100.0) * self.frame.height))
            path.close()
            path.fill()
            path.stroke()
        }
    }
    
    func drawLineGraph(chartSpace: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: CGFloat(chartSpace / 2), y: self.frame.height - (element.first! / 100.0) * self.frame.height))
        path.lineWidth = chartSpace * 0.15
        path.lineJoinStyle = .round
        linePathColor.set()
        for (index, num) in element.enumerated() {
            path.addLine(to: CGPoint(x: CGFloat(chartSpace / 2) + CGFloat(index * 2) * chartSpace, y: self.frame.height - (num / 100.0) * self.frame.height))
        }
        path.stroke()
    }
    
    func drawCircle(chartSpace: CGFloat) {
        for (index, num) in element.enumerated() {
            let circle = UIBezierPath(arcCenter: CGPoint(x: CGFloat(chartSpace / 2) + CGFloat(index * 2) * chartSpace, y: self.frame.height - (num / 100.0) * self.frame.height), radius: chartSpace * 0.2, startAngle: 0, endAngle: 360, clockwise: true)
            UIColor.white.set()
            circle.fill()
        }
    }
    
    func setGraph(element: [CGFloat]) {
        self.element = element
    }
}
