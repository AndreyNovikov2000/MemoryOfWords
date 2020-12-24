//
//  LoginView.swift
//  MemoryOfWords
//
//  Created by AlemTime.
//

import UIKit

class LoginView: UIView {
    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Live cycle
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        setupSelf(inContext: context, rect: rect)
        setupShapeLayer()
    }
    
    // MARK: - Private methods
    
    private func setupSelf(inContext context: CGContext, rect: CGRect) {
        backgroundColor = .clear
        layer.masksToBounds = true
        layer.cornerRadius = 35
    }
    
    private func setupShapeLayer() {
        shapeLayer.path = drawPath().cgPath
        shapeLayer.frame = bounds
        shapeLayer.fillColor = color.cgColor
        
        layer.addSublayer(shapeLayer)
    }
    
    private func drawPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width, y: 100))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}
