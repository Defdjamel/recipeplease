//
//  Network.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

let Hostname = "https://wzp.solutions"
let ServiceApi = Hostname + "/tests/ios-custom-icons/"

struct Api {
    static let getIcons = ServiceApi + "IconsData.json"
}
