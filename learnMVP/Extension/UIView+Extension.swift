//
//  UIView+Extension.swift
//  MoviesDemoApp
//
//  Created by karma on 9/22/22.
//

import UIKit

extension UIView {
    
    var width: CGFloat{
           return frame.size.width
       }
       
       var height: CGFloat{
           return frame.size.height
       }
       
       var left: CGFloat{
           return frame.origin.x
       }
       
       var right: CGFloat{
           return left + width
       }
       
       var top: CGFloat{
           return frame.origin.y
       }
       
       var bottom: CGFloat {
           return top + height
       }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    
    func set(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }

    func setShadow(height: CGFloat = 3, radius: CGFloat = 6, opacity: Float = 0.5,color:UIColor = .gray) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    func setupBorder(width: CGFloat = 3, color: UIColor, radius:CGFloat, opacity:Float = 10) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    func gradientColors(colors: [UIColor]) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.calculatePoints(for: 137)
        self.layer.addSublayer(gradientLayer)
    }
    
    func setBorder(height: CGFloat = 3, radius: CGFloat = 6, opacity: Float = 0.5) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
}

public extension CAGradientLayer {

    /// Sets the start and end points on a gradient layer for a given angle.
    ///
    /// - Important:
    /// *0°* is a horizontal gradient from left to right.
    ///
    /// With a positive input, the rotational direction is clockwise.
    ///
    ///    * An input of *400°* will have the same output as an input of *40°*
    ///
    /// With a negative input, the rotational direction is clockwise.
    ///
    ///    * An input of *-15°* will have the same output as *345°*
    ///
    /// - Parameters:
    ///     - angle: The angle of the gradient.
    ///
    public func calculatePoints(for angle: CGFloat) {


        var ang = (-angle).truncatingRemainder(dividingBy: 360)

        if ang < 0 { ang = 360 + ang }

        let n: CGFloat = 0.5

        switch ang {

        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b

        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b

        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
           startPoint = a
            endPoint = b

        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b

        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b

        }
    }

    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }


    // Overloads

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Int) {
        calculatePoints(for: CGFloat(angle))
    }

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Float) {
        calculatePoints(for: CGFloat(angle))
    }

    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Double) {
        calculatePoints(for: CGFloat(angle))
    }

}

