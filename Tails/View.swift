//
//  View.swift
//  Tails
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

operator postfix ~ {}

@postfix func ~ (view: UIView) -> ViewAttributes {
    return ViewAttributes(view: view, attributes: nil)
}

@postfix func ~ (layoutGuide: UILayoutSupport) -> ViewAttributes {
    let view = layoutGuide as AnyObject as UIView
    return ViewAttributes(view: view, attributes: nil)
}
