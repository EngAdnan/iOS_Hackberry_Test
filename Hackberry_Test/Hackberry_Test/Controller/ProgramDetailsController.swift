//
//  ProgramDetailsController.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//


import UIKit

class ProgramDetailsController: UIViewController {

    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var editorName: UILabel!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var broadcastInfo: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var programImageWebSite: UIImageView!
    
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    
    var programDetails:RadioProgramDetails!
    var mediaPlatformsURls = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(ProgramDetailsController.tapFunction))
        let instagramTap = UITapGestureRecognizer(target: self, action: #selector(ProgramDetailsController.tapFunction))
        let twitterTap = UITapGestureRecognizer(target: self, action: #selector(ProgramDetailsController.tapFunction))
        let imageWebSiteTap = UITapGestureRecognizer(target: self, action: #selector(ProgramDetailsController.tapFunction))
        programImageWebSite.addGestureRecognizer(imageWebSiteTap)
        facebookLabel.addGestureRecognizer(facebookTap)
        instagramLabel.addGestureRecognizer(instagramTap)
        twitterLabel.addGestureRecognizer(twitterTap)
        for platform in programDetails.socialMediaPlatforms {
            mediaPlatformsURls.updateValue(platform.platformurl, forKey: platform.platform)
            if platform.platform == "Facebook" {
                facebookLabel.isHidden = false
            }
            else if platform.platform == "Twitter" {
                twitterLabel.isHidden = false
            }
            else if platform.platform == "Instagram" {
                instagramLabel.isHidden = false
            }
        }
        setProgramDetails()
        
    }
    
    func setProgramDetails() {
        programName.text = programDetails.name
        editorName.text = "By \(programDetails.responsibleEditor)"
        channelName.text = programDetails.channel.name
        descriptionLabel.text = programDetails.description
        emailLabel.text = "Email: \(programDetails.email)"
        if programDetails.broadcastInfo != nil {
            broadcastInfo.text = "BroadcastInfo: \(programDetails.broadcastInfo ?? "")"
        }
        else {
            broadcastInfo.text = ""
            broadcastInfo.isHidden = true
        }
        if programDetails.programImageWide != "" {
            Utils.fetchTeamLogo(logoUrl: programDetails.programImageWide, programImageView: programImageView)
            
        }
        if programDetails.socialImage != "" {
            Utils.fetchTeamLogo(logoUrl: programDetails.socialImage, programImageView: programImageWebSite)
            
        }
        
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 1:
            Utils.openLinkInSafari(url: mediaPlatformsURls["Facebook"]!)
        case 2:
            Utils.openLinkInSafari(url: mediaPlatformsURls["Instagram"]!)
        case 3:
            Utils.openLinkInSafari(url: mediaPlatformsURls["Twitter"]!)
        case 4:
            Utils.openLinkInSafari(url: programDetails.programUrl)
        default:
            "No Action"
        }
    }


}

