//
//  RadioPrograms.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan LKallas. All rights reserved.
//

import Foundation
import UIKit

struct RadioPrograms:Decodable {
    
    let copyright:String
    var programs:[RadioProgramDetails]
    var pagination:PaginationRadioPrograms

    mutating func updateProgramsList(listOfPrograms: [RadioProgramDetails]) {
        programs.append(contentsOf: listOfPrograms)
        
    }
}

struct RadioProgramDetails:Decodable {
    let id:Int
    let name:String
    let description:String
    let broadcastInfo:String?
    let responsibleEditor:String?
    let email:String
    let phone:String
    let programUrl:String
    let programSlug:String?
    let programImage:String
    let programImageTemplate:String
    let programImageWide:String
    let programImageTemplateWide:String
    let socialImage:String
    let socialImageTemplate:String
    let socialMediaPlatforms:[SocialMedia]
    let channel:RadioChannel
    let archived:Bool
    let hasOnDemand:Bool
    let hasPod:Bool
    
    private enum CodingKeys : String, CodingKey {
        case id, name, description, email, phone, channel, archived
        case broadcastInfo = "broadcastinfo", programImage = "programimage", programImageTemplateWide = "programimagetemplatewide", programImageWide = "programimagewide"
        case responsibleEditor = "responsibleeditor", programUrl = "programurl" , programSlug = "programslug" , programImageTemplate = "programimagetemplate"
        case socialImage = "socialimage", socialImageTemplate = "socialimagetemplate"
        case socialMediaPlatforms = "socialmediaplatforms",hasOnDemand = "hasondemand", hasPod = "haspod"
    }
    
    


    
}

struct SocialMedia:Decodable {
    let platform:String
    let platformurl:String
}

struct RadioChannel:Decodable {
    let id:Int
    let name:String
}

struct PaginationRadioPrograms:Decodable {
    let page:Int
    let size:Int
    let totalhits:Int
    let totalpages:Int
    let nextpage:String?
    
}


