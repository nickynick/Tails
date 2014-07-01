//
//  LayoutExpression.swift
//  Tails
//
//  Created by Nick Tymchenko on 29/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

protocol LayoutExpression {
    var viewAttributes: ViewAttributes? { get }
    var multiplier: CGFloat { get }
    func constant(layoutAttribute: NSLayoutAttribute) -> CGFloat
}