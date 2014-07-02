//
//  LayoutExpressionAttributes.swift
//  Tails
//
//  Created by Nick Tymchenko on 02/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

protocol LayoutExpressionAttributes: LayoutEquationRightSide {
    func add<T: LayoutConstant>(constant: T) -> LayoutExpression<T>
    func multiply(multiplier: CGFloat) -> LayoutExpressionAttributes
}


func + <T: LayoutConstant> (lhs: LayoutExpressionAttributes, rhs: T) -> LayoutExpression<T> {
    return lhs.add(rhs)
}

func + <T: LayoutConstant> (lhs: T, rhs: LayoutExpressionAttributes) -> LayoutExpression<T> {
    return rhs + lhs
}

func - <T: LayoutConstant> (lhs: LayoutExpressionAttributes, rhs: T) -> LayoutExpression<T> {
    return lhs + -rhs
}

func - <T: LayoutConstant> (lhs: T, rhs: LayoutExpressionAttributes) -> LayoutExpression<T> {
    return rhs - lhs
}


func * (lhs: LayoutExpressionAttributes, rhs: CGFloat) -> LayoutExpressionAttributes {
    return lhs.multiply(rhs)
}

func * (lhs: CGFloat, rhs: LayoutExpressionAttributes) -> LayoutExpressionAttributes {
    return rhs * lhs
}

func / (lhs: LayoutExpressionAttributes, rhs: CGFloat) -> LayoutExpressionAttributes {
    return lhs * (1 / rhs)
}

