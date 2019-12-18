//
//  RadioProgramsController.swift
//  Hackberry_Test
//
//  Created by Adnan Kallas on 2019-12-17.
//  Copyright © 2019 Adnan Alkallas. All rights reserved.
//

import UIKit
import ViewAnimator
class RadioProgramsController: UITableViewController {
    
    var radioProgramsList:RadioPrograms!
    var previousPage:String = ""
    var isFechingData:Bool = false
    private let animations = [AnimationType.from(direction: .left, offset: 20.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
        self.clearsSelectionOnViewWillAppear = true
        tableView.tableFooterView = UIView()
        fetchListOfPrograms(url: Utils.fetchRadioProgramsUrl)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all

    }
    
    func fetchListOfPrograms(url:String){
        if Connectivity.isConnectedToInternet {
            HackberryManager.fetchEventDetail(getProgramsUrl: url){ response, error, statusCode in
                if response != nil {
                    if self.radioProgramsList == nil {
                        self.radioProgramsList = response
                    }
                    else{
                        if response?.pagination.nextpage != self.radioProgramsList.pagination.nextpage {
                        self.radioProgramsList.updateProgramsList(listOfPrograms: response!.programs)
                        self.radioProgramsList.pagination = response!.pagination
                            
                        }
                        self.refreshTable()
                    }
                    self.previousPage = url
                    self.refreshTable()
                    self.isFechingData = false

                }
                else{
                    Utils.showAlertView(title: "Error Message", message: "Something wrong happened", view: self)
                    self.isFechingData = false

                    
                }
                
            }
        }
        else {
            Utils.showAlertView(title: "Error", message: "Check Internet Connection", view: self)
            self.isFechingData = false

        }
    }
    
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.animate(animations: animations, duration: 1.5)
        let lastElement = self.radioProgramsList.programs.count - 2
        if indexPath.row == lastElement  {
            if self.radioProgramsList.programs.count < self.radioProgramsList.pagination.totalhits && self.radioProgramsList.programs.count > 0 && self.isFechingData != true {
                fetchListOfPrograms(url: self.radioProgramsList.pagination.nextpage!)
                self.isFechingData = true
            }
        }
        print(self.radioProgramsList.programs.count)

    }
    
    func viewEventDetails(radioProgram:RadioProgramDetails){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let eventDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "programDetailsID") as! ProgramDetailsController
        eventDetailsViewController.programDetails = radioProgram
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            return
        }
    }
    
}
