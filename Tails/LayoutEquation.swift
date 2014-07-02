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
    let rhs: LayoutEquationRightSide
    let relation: NSLayoutRelation
    
    init(lhs: ViewAttributes, rhs: LayoutEquationRightSide, relation: NSLayoutRelation) {
        self.lhs = lhs
        self.rhs = rhs
        self.relation = relation
    }
    
    func install() -> NSLayoutConstraint[] {
        self.lhs.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constraints = NSLayoutConstraint[]()
        
        for lhsAttribute in self.lhs.attributes! {
            if let rhsAttributes = self.rhs.getViewAttributes()?.attributes {
                for rhsAttribute in rhsAttributes {
                    constraints.append(self.createConstraintWithAttributes(lhsAttribute, rhsAttribute: rhsAttribute))
                }
            } else {
                constraints.append(self.createConstraintWithAttributes(lhsAttribute, rhsAttribute: lhsAttribute))
            }
        }
        
        return constraints
    }
    
    func createConstraintWithAttributes(lhsAttribute: NSLayoutAttribute, rhsAttribute: NSLayoutAttribute) -> NSLayoutConstraint {
        var rhsView = self.rhs.getViewAttributes()?.view
        
        if (rhsView == nil && self.attributeItemRequired(rhsAttribute)) {
            rhsView = self.lhs.view.superview
        }
        
        let rhsViewAttribute = rhsView != nil ? rhsAttribute : NSLayoutAttribute.NotAnAttribute
        
        let constraint = NSLayoutConstraint(
            item: self.lhs.view,
            attribute: lhsAttribute,
            relatedBy: self.relation,
            toItem: rhsView,
            attribute: rhsViewAttribute,
            multiplier: self.rhs.getMultiplier(rhsAttribute),
            constant: self.rhs.getConstant(rhsAttribute))
        
        let superview = self.findCommonSuperview(self.lhs.view, viewOrNil: rhsView)
        assert(superview != nil, "Views must have a common superview!")
        
        superview.addConstraint(constraint)

        return constraint
    }
    
    func attributeItemRequired(attribute: NSLayoutAttribute) -> Bool {
        return !contains([.Width, .Height], attribute)
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


func == (lhs: ViewAttributes, rhs: LayoutEquationRightSide) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.Equal)
}

func == <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs == LayoutExpression(viewAttributes: nil, multiplier: 1, constant: rhs)
}


func >= (lhs: ViewAttributes, rhs: LayoutEquationRightSide) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.GreaterThanOrEqual)
}

func >= <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs >= LayoutExpression(viewAttributes: nil, multiplier: 1, constant: rhs)
}


func <= (lhs: ViewAttributes, rhs: LayoutEquationRightSide) -> LayoutEquation {
    return LayoutEquation(lhs: lhs, rhs: rhs, relation: NSLayoutRelation.LessThanOrEqual)
}

func <= <T: LayoutConstant> (lhs: ViewAttributes, rhs: T) -> LayoutEquation {
    return lhs <= LayoutExpression(viewAttributes: nil, multiplier: 1, constant: rhs)
}
