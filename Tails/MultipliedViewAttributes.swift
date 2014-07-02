//
//  MultipliedViewAttributes.swift
//  Tails
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

class MultipliedViewAttributes {
    let viewAttributes: ViewAttributes
    let multiplier: CGFloat
    
    init(viewAttributes: ViewAttributes, multiplier: CGFloat) {
        self.viewAttributes = viewAttributes
        self.multiplier = multiplier
    }
}

extension MultipliedViewAttributes: LayoutEquationRightSide {
    func getViewAttributes() -> ViewAttributes? {
        return self.viewAttributes
    }
    
    func getMultiplier(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return self.multiplier
    }
    
    func getConstant(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return 0
    }
}

extension MultipliedViewAttributes: LayoutExpressionAttributes {
    func add<T: LayoutConstant>(constant: T) -> LayoutExpression<T> {
        return LayoutExpression(viewAttributes: self.viewAttributes, multiplier: self.multiplier, constant: constant)
    }
    
    func multiply(multiplier: CGFloat) -> LayoutExpressionAttributes {
        return MultipliedViewAttributes(viewAttributes: self.viewAttributes, multiplier: self.multiplier * multiplier)
    }
}