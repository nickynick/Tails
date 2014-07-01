//
//  LayoutEquation.swift
//  Tails
//
//  Created by Nick Tymchenko on 29/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation
import UIKit

struct LayoutEquation {
    let lhs: ViewAttributes
    let rhs: LayoutExpression
    let relation: NSLayoutRelation
    
    init(lhs: ViewAttributes, rhs: LayoutExpression, relation: NSLayoutRelation) {
        self.lhs = lhs
        self.rhs = rhs
        self.relation = relation
    }
    
    func install() -> NSLayoutConstraint[] {
        self.lhs.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constraints = NSLayoutConstraint[]()
        
        for lhsAttribute in self.lhs.layoutAttributes! {
            if let rhsAttributes = self.rhs.viewAttributes?.layoutAttributes {
                for rhsAttribute in rhsAttributes {
                    constraints.append(self.createConstraintWithAttributes(lhsAttribute, rhs: rhsAttribute))
                }
            } else {
                constraints.append(self.createConstraintWithAttributes(lhsAttribute, rhs: lhsAttribute))
            }
        }
        
        let superview = self.findCommonSuperview(self.lhs.view, viewOrNil: self.rhs.viewAttributes?.view)
        assert(superview != nil, "Views must have a common superview!")
        
        superview.addConstraints(constraints)
        
        return constraints
    }
    
    func createConstraintWithAttributes(lhs: NSLayoutAttribute, rhs: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.lhs.view,
            attribute: lhs,
            relatedBy: self.relation,
            toItem: self.rhs.viewAttributes?.view,
            attribute: rhs,
            multiplier: self.rhs.multiplier,
            constant: self.rhs.constant(rhs))
    }
    
    func findCommonSuperview(view: UIView, viewOrNil: UIView?) -> UIView! {
        if let anotherView = viewOrNil {
            var currentView = view
            while currentView != nil && !anotherView.isDescendantOfView(currentView) {
                currentView = currentView.superview
            }
            return currentView
        } else {
            return view
        }
    }
}


func == (lhs: ViewAttributes, rhs: LayoutExpression) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.Equal)
}

func == (lhs: ViewAttributes, rhs: ViewAttributes) -> LayoutEquation {
    return lhs == MultiplierLayoutExpression(viewAttributes: rhs, multiplier: 1)
}

func == <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs == ConstantLayoutExpression<T>(viewAttributes: nil, multiplier: 0, constant: rhs)
}


func >= (lhs: ViewAttributes, rhs: LayoutExpression) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.GreaterThanOrEqual)
}

func >= (lhs: ViewAttributes, rhs: ViewAttributes) -> LayoutEquation {
    return lhs >= MultiplierLayoutExpression(viewAttributes: rhs, multiplier: 1)
}

func >= <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs >= ConstantLayoutExpression<T>(viewAttributes: nil, multiplier: 0, constant: rhs)
}


func <= (lhs: ViewAttributes, rhs: LayoutExpression) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.LessThanOrEqual)
}

func <= (lhs: ViewAttributes, rhs: ViewAttributes) -> LayoutEquation {
    return lhs <= MultiplierLayoutExpression(viewAttributes: rhs, multiplier: 1)
}

func <= <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs <= ConstantLayoutExpression<T>(viewAttributes: nil, multiplier: 0, constant: rhs)
}
