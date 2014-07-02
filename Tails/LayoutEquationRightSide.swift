//
//  LayoutEquationRightSide.swift
//  Tails
//
//  Created by Nick Tymchenko on 02/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

protocol LayoutEquationRightSide {
    func getViewAttributes() -> ViewAttributes?
    func getMultiplier(layoutAttribute: NSLayoutAttribute) -> CGFloat
    func getConstant(layoutAttribute: NSLayoutAttribute) -> CGFloat
}