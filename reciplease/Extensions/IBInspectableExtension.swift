//
//  IBInspectableExtension.swift
//  SwiftHelpers
//
//  Created by intergoldex llc on 09/04/2015.
//  Copyright (c) 2016 intergoldex. All rights reserved.
//

#if os(iOS)

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
  
    @IBInspectable var layerMasksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}
   enum Shape: String {
        case Rectangle = "rectangle" // lowercase to make it case-insensitive
        case Triangle = "triangle"
        case Circle = "circle"
    }

#endif
