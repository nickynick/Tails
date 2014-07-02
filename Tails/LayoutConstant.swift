//
//  LayoutConstant.swift
//  Tails
//
//  Created by Nick Tymchenko on 29/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation
import UIKit

protocol LayoutConstant {
    func valueForLayoutAttribute(layoutAttribute: NSLayoutAttribute) -> CGFloat
    
    @prefix func - (v: Self) -> Self
    func + (lhs: Self, rhs: Self) -> Self
}

func - <T: LayoutConstant>(lhs: T, rhs: T) -> T {
    return lhs + -rhs
}


extension CGFloat : LayoutConstant {
}


extension Int : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        return CGFloat(self)
    }
}


extension Float : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        return CGFloat(self)
    }
}


extension Double : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        return CGFloat(self)
    }
}


extension CGPoint : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        switch attribute {
        case .CenterX:
            return self.x
        case .CenterY:
            return self.y
        default:
            return 0
        }
    }
}

@prefix func - (v: CGPoint) -> CGPoint {
    return CGPoint(x: -v.x, y: -v.y)
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}


extension CGSize : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        switch attribute {
        case .Width:
            return self.width
        case .Height:
            return self.height
        default:
            return 0
        }
    }
}

@prefix func - (v: CGSize) -> CGSize {
    return CGSize(width: -v.width, height: -v.height)
}

func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}


extension UIEdgeInsets : LayoutConstant {
    func valueForLayoutAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        switch attribute {
        case .Top:
            return self.top
        case .Left:
            return self.left
        case .Bottom:
            return -self.bottom
        case .Right:
            return -self.right
        default:
            return 0
        }
    }
}

@prefix func - (v: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(
        top: -v.top,
        left: -v.left,
        bottom: -v.bottom,
        right: -v.right)
}

func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(
        top: lhs.top + rhs.top,
        left: lhs.left + rhs.left,
        bottom: lhs.bottom + rhs.bottom,
        right: lhs.right + rhs.right
    )
}
