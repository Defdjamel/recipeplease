//
//  NetworkManager.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import Alamofire
class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
}
//MARK: - REQUESTS
extension NetworkManager {
    func getListIcons (success: @escaping (Array<Any>) -> Void, failed: @escaping () -> Void){
          Alamofire.request( Api.getIcons, method: .get ,parameters: nil ,encoding: URLEncoding.default).responseJSON { response in
           
        }
    
        
    }
}
