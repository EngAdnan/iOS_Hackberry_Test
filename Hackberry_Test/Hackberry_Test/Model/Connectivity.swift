//
//  Connectivity.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//

import Foundation
import Alamofire

 // class to check Internet Connection
class Connectivity {
    
    class var isConnectedToInternet:Bool {
           return NetworkReachabilityManager()!.isReachable
       }
    
}
