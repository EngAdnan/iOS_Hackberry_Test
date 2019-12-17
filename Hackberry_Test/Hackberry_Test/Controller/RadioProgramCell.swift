//
//  RadioProgramCell.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//

import UIKit

class RadioProgramCell: UITableViewCell {

    
    @IBOutlet weak var radioProgramImageView: UIImageView!
    @IBOutlet weak var radioProgramNameLabel: UILabel!
    
    
    func setRadioProgramName(radioProgramLogoUrl:String?, radioProgramName:String?) {
        if radioProgramLogoUrl != "" {
            Utils.fetchTeamLogo(logoUrl: radioProgramLogoUrl!, programImageView: radioProgramImageView)
            
        }
        radioProgramNameLabel.text = radioProgramName
        
    }
}
