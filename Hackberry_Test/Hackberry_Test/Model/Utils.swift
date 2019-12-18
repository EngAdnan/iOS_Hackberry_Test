//
//  Utils.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan LKallas. All rights reserved.
//

import Foundation
import UIKit
public class Utils {
    static let fetchRadioProgramsUrl = "https://api.sr.se/api/v2/programs?format=json&size=40"
     
    public static func showAlertView(title:String, message:String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Button", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    public static func fetchProgramImage(logoUrl:String, programImageView:UIImageView){
        
        HackberryManager.downloadImage(Url: logoUrl){  response, error, statusCode in
            programImageView.image = response!
            
        }
        
    }
    
    public static func openLinkInSafari(url:String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    public static func setCellHeight(defaultHeight:Int) -> CGFloat {
        let screenDefaultHeight = CGFloat(UIScreen.main.bounds.size.height)
        let cellDefaultHeight =   CGFloat(defaultHeight)
        let rate:CGFloat = screenDefaultHeight / cellDefaultHeight
        let factor:CGFloat = ((UIScreen.main.bounds.size.height *  rate) / screenDefaultHeight )
        return (UIScreen.main.bounds.size.height / factor)
    }
    
    

}
