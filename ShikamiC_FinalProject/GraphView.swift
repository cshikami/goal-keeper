//
//  GraphView.swift
//  ShikamiC_FinalProject
//
//  Created by Christopher Shikami on 3/14/17.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit

var graphPoints: [Int] = [1]

class GraphView: UIView {
    
    /**
     A class to draw a graph using Core Graphics
 **/
    
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        //set up background clipping area for rounded corners
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return
        }
        
        currentContext.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let startColorComponents = startColor.cgColor.components else {
            return
        }
        
        //let endColor = UIColor.green
        guard let endColorComponents = endColor.cgColor.components else {
            return
        }
        
        let colorComponents: [CGFloat]
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        
        let locations:[CGFloat] = [0.0, 1.0]
        
       
        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0,y: self.bounds.height)
        
        
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        //calculate the x point
        
        let margin:CGFloat = 20.0
        let columnXPoint = {(column: Int) -> CGFloat in
            //Calculate gap berween points
            let spacer = (width - margin*2 - 4) /
                CGFloat((graphPoints.count - 1))
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        //calculate the y point
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()
        let columnYPoint = {(graphPoint:Int) -> CGFloat in var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y // flip the graph
            return y
        }
        
        //draw the line
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        //go to the start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0),
                                   y: columnXPoint(graphPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i),
                                    y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        //stroke the path
        graphPath.stroke()
        setNeedsDisplay()
        
    }
    
    
}
