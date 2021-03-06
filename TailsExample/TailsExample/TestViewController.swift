//
//  TestViewController.swift
//  TailsExample
//
//  Created by Nick Tymchenko on 01/07/14.
//  Copyright (c) 2014 Nick Tymchenko. All rights reserved.
//

import UIKit
import Tails

class TestViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.greenColor()
        view1.layer.borderColor = UIColor.blackColor().CGColor
        view1.layer.borderWidth = 2
        self.view.addSubview(view1)
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.redColor()
        view2.layer.borderColor = UIColor.blackColor().CGColor
        view2.layer.borderWidth = 2
        self.view.addSubview(view2)
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.blueColor()
        view3.layer.borderColor = UIColor.blackColor().CGColor
        view3.layer.borderWidth = 2
        self.view.addSubview(view3)
        
        let view4 = UIView()
        view4.backgroundColor = UIColor.yellowColor()
        view4.layer.borderColor = UIColor.blackColor().CGColor
        view4.layer.borderWidth = 2
        self.view.addSubview(view4)
        
        let padding: CGFloat = 10;
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        Tails.install(
            view1~.top == self.topLayoutGuide~.bottom + padding,
            view1~.left == self.view~ + insets,
            view1~.height == 200,
            
            view2~.top == view1~.bottom + padding + 25,
            view2~.right == view1~,
            view2~.bottom.left == self.view~ + insets,
            
            view3~.top == view1~,
            view3~.left == view1~.right + padding,
            view3~.right == insets,
            view3~.size == view1~ / 2,
            
            view4~.centerX == view3~,
            view4~.top == view3~.bottom + padding,
            view4~.bottom == view1~,
            view4~.size == CGSize(width: 50, height: 100) ~~ UILayoutPriorityDefaultHigh,
            view4~.width == 500 ~~ UILayoutPriorityDefaultLow
        )
    }
}
