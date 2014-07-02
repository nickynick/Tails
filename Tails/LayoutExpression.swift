//
//  LayoutExpression.swift
//  Tails
//
//  Created by Nick Tymchenko on 29/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

class LayoutExpression<T: LayoutConstant> {
    var viewAttributes: ViewAttributes?
    var multiplier: CGFloat
    let constant: Any // an ugly attempt to jump over compiler bugs :<
    
    init(viewAttributes: ViewAttributes?, multiplier: CGFloat, constant: T) {
        self.viewAttributes = viewAttributes
        self.multiplier = multiplier
        self.constant = constant
    }
}

extension LayoutExpression: LayoutEquationRightSide {
    func getViewAttributes() -> ViewAttributes? {
        return self.viewAttributes
    }

    func getMultiplier(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return self.multiplier
    }
    
    func getConstant(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        let typedConstant = self.constant as T
        return typedConstant.valueForLayoutAttribute(layoutAttribute)
    }
}


func + <T: LayoutConstant> (lhs: LayoutExpression<T>, rhs: T) -> LayoutExpression<T> {
    let typedConstant = lhs.constant as T
    return LayoutExpression(viewAttributes: lhs.viewAttributes, multiplier: lhs.multiplier, constant: typedConstant + rhs)
}

func + <T: LayoutConstant> (lhs: T, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    return rhs + lhs
}

func - <T: LayoutConstant> (lhs: LayoutExpression<T>, rhs: T) -> LayoutExpression<T> {
    return lhs + -rhs
}

func - <T: LayoutConstant> (lhs: T, rhs: LayoutExpression<T>) -> LayoutExpression<T> {
    return rhs - lhs
}