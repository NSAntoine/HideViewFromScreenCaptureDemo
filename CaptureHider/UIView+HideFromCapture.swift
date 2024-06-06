//
//  UIView+HideFromCapture.swift
//  CaptureHider
//
//  Created by Serena (Antoine) on 06/06/2024.
//  

import UIKit

extension UIView {
    // hides view/layer when:
    // 1) a screenshot is taken
    // 2) a screen recording is happening
    // the screen recording can either be on-device, like from the Control Center
    // or can be from another source, like recording the screen from a mac on QuickTime
    func hideViewFromCapture(hide: Bool) -> Bool {
        let propertyBase64 = "ZGlzYWJsZVVwZGF0ZU1hc2s=" /* "disableUpdateMask" encoded in base64 */
        
        guard let propertyData = Data(base64Encoded: propertyBase64),
              let propertyString = String(data: propertyData, encoding: .utf8) else {
            print("Couldn't decode property string")
            return false
        }
        
        guard layer.responds(to: NSSelectorFromString(propertyString)) else {
            print("Feature is unavailable")
            return false
        }
        
        if hide {
            let hideFlag = (1 << 1) | (1 << 4)
            layer.setValue(NSNumber(value: hideFlag), forKey: propertyString)
        } else {
            layer.setValue(NSNumber(value: 0), forKey: propertyString)
        }
        
        return true
    }
}
