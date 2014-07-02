//
//  ViewAttributes.swift
//  Tails
//
//  Created by Nick Tymchenko on 30/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation
import UIKit

class ViewAttributes {
    let view: UIView
    let attributes: NSLayoutAttribute[]?
    
    init(view: UIView, attributes: NSLayoutAttribute[]?) {
        self.view = view
        self.attributes = attributes
    }

    func add(attribute: NSLayoutAttribute) -> ViewAttributes {
        if var attributes = self.attributes {
            if contains(attributes, attribute) {
                return self
            } else {
                attributes.append(attribute)
                return ViewAttributes(view: self.view, attributes: attributes)
            }
        } else {
            return ViewAttributes(view: self.view, attributes: [attribute])
        }
    }
    
    var left: ViewAttributes { return self.add(.Left) }
    var right: ViewAttributes { return self.add(.Right) }
    var top: ViewAttributes { return self.add(.Top) }
    var bottom: ViewAttributes { return self.add(.Bottom) }
    var leading: ViewAttributes { return self.add(.Leading) }
    var trailing: ViewAttributes { return self.add(.Trailing) }
    var width: ViewAttributes { return self.add(.Width) }
    var height: ViewAttributes { return self.add(.Height) }
    var centerX: ViewAttributes { return self.add(.CenterX) }
    var centerY: ViewAttributes { return self.add(.CenterY) }
    var baseline: ViewAttributes { return self.add(.Baseline) }
    var firstBaseline: ViewAttributes { return self.add(.FirstBaseline) }
    
    var center: ViewAttributes { return self.centerX.centerY }
    var size: ViewAttributes { return self.width.height }
    var edges: ViewAttributes { return self.top.left.bottom.right }
}

extension ViewAttributes: LayoutEquationRightSide {
    func getViewAttributes() -> ViewAttributes? {
        return self
    }
    
    func getMultiplier(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return 1
    }
    
    func getConstant(layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return 0
    }
}

extension ViewAttributes: LayoutExpressionAttributes {
    func add<T: LayoutConstant>(constant: T) -> LayoutExpression<T> {
        return LayoutExpression(viewAttributes: self, multiplier: 1, constant: constant)
    }
    
    func multiply(multiplier: CGFloat) -> LayoutExpressionAttributes {
        return MultipliedViewAttributes(viewAttributes: self, multiplier: multiplier)
    }
}