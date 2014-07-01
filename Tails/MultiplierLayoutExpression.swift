//
//  MultiplierLayoutExpression.swift
//  Tails
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

struct MultiplierLayoutExpression : LayoutExpression {
    let viewAttributes: ViewAttributes?
    let multiplier: CGFloat
    
    func constant(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return 0
    }
    
    func multiply(multiplier: CGFloat) -> MultiplierLayoutExpression {
        return MultiplierLayoutExpression(viewAttributes: self.viewAttributes, multiplier: self.multiplier * multiplier)
    }
    
    func add<T: LayoutConstant>(constant: T) -> ConstantLayoutExpression<T> {
        return ConstantLayoutExpression(viewAttributes: self.viewAttributes, multiplier: self.multiplier, constant: constant)
    }
}


func * (lhs: ViewAttributes, rhs: CGFloat) -> MultiplierLayoutExpression {
    return MultiplierLayoutExpression(viewAttributes: lhs, multiplier: rhs)
}

func * (lhs: CGFloat, rhs: ViewAttributes) -> MultiplierLayoutExpression {
    return rhs * lhs
}

func / (lhs: ViewAttributes, rhs: CGFloat) -> MultiplierLayoutExpression {
    return MultiplierLayoutExpression(viewAttributes: lhs, multiplier: 1 / rhs)
}


func * (lhs: MultiplierLayoutExpression, rhs: CGFloat) -> MultiplierLayoutExpression {
    return lhs.multiply(rhs)
}

func * (lhs: CGFloat, rhs: MultiplierLayoutExpression) -> MultiplierLayoutExpression {
    return rhs * lhs
}

func / (lhs: MultiplierLayoutExpression, rhs: CGFloat) -> MultiplierLayoutExpression {
    return lhs.multiply(1 / rhs)
}
