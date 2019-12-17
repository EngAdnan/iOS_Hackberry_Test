//
//  RadioProgramsController.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//

import UIKit

class RadioProgramsController: UITableViewController {
    
    var radioProgramsList:RadioPrograms!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
       // tableView.tableFooterView = UIView()
        if Connectivity.isConnectedToInternet {
            HackberryManager.fetchEventDetail(eventId: 0){ response, error, statusCode in
                if response != nil {
                    
                    self.radioProgramsList = response
                    self.refreshTable()
                }
                else{
                    Utils.showAlertView(title: "Error Message", message: "Something wrong happened", view: self)
                    
                }
                
            }
        }
        else {
            Utils.showAlertView(title: "Error", message: "Check Internet Connection", view: self)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if radioProgramsList != nil {
            return radioProgramsList.programs.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "radioCellIdentifier", for: indexPath) as! RadioProgramCell
        
        let radioProgramLogoUrl = radioProgramsList.programs[indexPath.row].programImage
        let radioProgramName = radioProgramsList.programs[indexPath.row].name
        cell.setRadioProgramName(radioProgramLogoUrl: radioProgramLogoUrl, radioProgramName: radioProgramName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CGFloat(UIScreen.main.bounds.size.width) * 0.3)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProgram = radioProgramsList.programs[indexPath.row]
        viewEventDetails(radioProgram: selectedProgram)
        
    }
    
    func viewEventDetails(radioProgram:RadioProgramDetails){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     //   let eventDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "eventDetailsID") as! FootballEventController
      //  eventDetailsViewController.selectedEventId = selectedEvent.id
       // self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            return
        }
    }
    
}
