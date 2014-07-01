//
//  ConstantLayoutExpression.swift
//  Tails
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

struct ConstantLayoutExpression<T: LayoutConstant> : LayoutExpression {
    let viewAttributes: ViewAttributes?
    let multiplier: CGFloat
    
    // A sad attempt to jump over compiler bugs :<
//    var constant: T
    let constant: Any
    
    init(viewAttributes: ViewAttributes?, multiplier: CGFloat, constant: T) {
        self.viewAttributes = viewAttributes
        self.multiplier = multiplier
        self.constant = constant
    }
    
    func add(constant: T) -> ConstantLayoutExpression<T> {
        let typedConstant = self.constant as T
        return ConstantLayoutExpression(viewAttributes: self.viewAttributes, multiplier: self.multiplier, constant: typedConstant + constant)
    }
    
    func constant(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        let typedConstant = self.constant as T
        return typedConstant.valueForLayoutAttribute(layoutAttribute)
    }
}


func + <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> ConstantLayoutExpression<T> {
    return ConstantLayoutExpression<T>(viewAttributes: lhs, multiplier: 1, constant: rhs)
}

func + <T: LayoutConstant> (lhs: MultiplierLayoutExpression, rhs: T) -> ConstantLayoutExpression<T> {
    return lhs.add(rhs)
}

func + <T: LayoutConstant> (lhs: ConstantLayoutExpression<T>, rhs: T) -> ConstantLayoutExpression<T> {
    return lhs.add(rhs)
}
