//
//  TimeInterval+text.swift
//  reciplease
//
//  Created by james on 28/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

extension TimeInterval{ 
     func getMinutesHoursFromSeconds()-> String{
        
        let hours = Double(Int(self / 3600))
        let minutes = (self - (hours * 3600)) / 60
        if hours > 0 {
            return String(format: "%1.0fh%02.0f",  Float(hours), Float(minutes))
        }
        else {
            return String(format: "%2.0fm", Float(minutes))
        }
        
    }
}
