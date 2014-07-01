//
//  ViewAttributes.swift
//  Tails
//
//  Created by Nick Tymchenko on 30/06/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation
import UIKit

struct ViewAttributes {
    let view: UIView
    let layoutAttributes: NSLayoutAttribute[]?
    
    func add(layoutAttribute: NSLayoutAttribute) -> ViewAttributes {
        if var layoutAttributes = self.layoutAttributes {
            if contains(layoutAttributes, layoutAttribute) {
                return self
            } else {
                layoutAttributes.append(layoutAttribute)
                return ViewAttributes(view: self.view, layoutAttributes: layoutAttributes)
            }
        } else {
            return ViewAttributes(view: self.view, layoutAttributes: [layoutAttribute])
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