//
//  UIView+InstanceNib.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

extension UIView{
    /**
     Returns instance from Nib
     */
    class func instanceFromNib() -> Any {
        return UINib(nibName: self.className, bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as Any
    }
}

