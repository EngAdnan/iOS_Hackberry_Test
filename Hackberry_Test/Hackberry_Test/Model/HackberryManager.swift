//
//  HackberryManager.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class HackberryManager {
    
    static func fetchEventDetail(getProgramsUrl:String, completionHandler: @escaping (RadioPrograms?, NSError?,Int?) -> ()) {
        struct HTTPBinResponse: Decodable { let result: RadioPrograms? }
        AF.request(getProgramsUrl)
            .responseDecodable(of: RadioPrograms.self ) { response in
                print(response)
                switch response.result {
                case .success(let value):
                 //   print (value)
                    completionHandler(value, nil, response.response?.statusCode)
                case .failure(let error):
                    completionHandler(nil, error as NSError, response.response?.statusCode)
                }
                
        }
    }
    
    public static func downloadImage(Url:String,completionHandler: @escaping (UIImage?, NSError?,Int?) -> ()) {
        AF.request(Url,method:.get).responseData {response in
            switch response.result {
            case .success(let value):
                let image = UIImage(data:  value )
                completionHandler(image!, nil, response.response?.statusCode)
            case .failure(let error):
                completionHandler(nil, error as NSError, response.response?.statusCode)
                print (error)
                
            }
        }
    }

    
}
