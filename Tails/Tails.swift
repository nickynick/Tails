//
//  Tails.swift
//  Tails
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import Foundation

struct Tails {
    static func install(equations: LayoutEquation...) -> LayoutEquation[] {
        return self.install(equations)
    }
    
    static func install(equations: LayoutEquation[]) -> LayoutEquation[] {
        for equation in equations {
            equation.install()
        }
        return equations
    }
}
