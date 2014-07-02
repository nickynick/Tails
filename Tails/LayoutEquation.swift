//
//  LayoutEquation.swift
//  Tails
//
//  Created by Nick Tymchenko on 29/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation
import UIKit

class LayoutEquation {
    let lhs: ViewAttributes
    let rhs: LayoutEquationRightSide
    let relation: NSLayoutRelation
    let priority: Int
    
    init(lhs: ViewAttributes, rhs: LayoutEquationRightSide, relation: NSLayoutRelation = NSLayoutRelation.Equal, priority: Int = UILayoutPriorityRequired) {
        self.lhs = lhs
        self.rhs = rhs
        self.relation = relation
        self.priority = priority
    }
    
    func withPriority(priority: Int) -> LayoutEquation {
        return LayoutEquation(lhs: self.lhs, rhs: self.rhs, relation: self.relation, priority: priority)
    }
    
    func install() -> NSLayoutConstraint[] {
        self.lhs.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constraints = NSLayoutConstraint[]()
        let attributePairs = self.pairAttributes()
        
        for attributePair in attributePairs {
            constraints.append(self.createConstraintWithAttributes(attributePair.0, rhsAttribute: attributePair.1))
        }
        
        return constraints
    }
    
    func pairAttributes() -> (NSLayoutAttribute, NSLayoutAttribute)[] {
        let lhsAttributes = self.lhs.attributes!
        
        if let rhsAttributes = self.rhs.getViewAttributes()?.attributes {
            if areAttributesEqual(lhsAttributes, otherAttributes: rhsAttributes) {
                return lhsAttributes.map { return ($0, $0) }
            } else if lhsAttributes.count == 1 {
                return rhsAttributes.map { return (lhsAttributes[0], $0) }
            } else if rhsAttributes.count == 1 {
                return lhsAttributes.map { return ($0, rhsAttributes[0]) }
            } else {
                assert(false, "Equations with different composite attributes are not supported!")
                return []
            }
        } else {
            return lhsAttributes.map { return ($0, $0) }
        }
    }
    
    func areAttributesEqual(attributes: NSLayoutAttribute[], otherAttributes: NSLayoutAttribute[]) -> Bool {
        for attribute in attributes {
            if !contains(otherAttributes, attribute) {
                return false
            }
        }
        return true
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
            multiplier: self.rhs.getMultiplier(lhsAttribute),
            constant: self.rhs.getConstant(lhsAttribute))
        
        constraint.priority = UILayoutPriority(self.priority)
        
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


operator infix ~~ {}

func ~~ (lhs: LayoutEquation, rhs: Int) -> LayoutEquation {
    return lhs.withPriority(rhs)
}
