//
//  ViewController.swift
//  IT358FinalHalikias
//
//  Created by Beverly L Brown on 5/6/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var searchPolls: [String]?
    var myindex = 0
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        searchPolls = PollManager.sharedInstance.idData
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchPolls = PollManager.sharedInstance.idData
        self.tableView.reloadData()
    }
    @IBAction func unwindToCourseList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? AddPoll, let poll = sourceViewController.pollNew{
            PollManager.sharedInstance.createPoll(idNew: poll)
            PollManager.sharedInstance.addId(Id: poll)
            
            searchPolls = PollManager.sharedInstance.idData
            self.tableView.reloadData()
            
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        var searchText = searchTextfield.text
        if searchText == ""{
            searchTextfield.placeholder = "Pleas enter a Poll Id"
        } else{
            PollManager.sharedInstance.addId(Id: searchText!)
            searchTextfield.text = ""
        }
        searchPolls = PollManager.sharedInstance.idData
        self.tableView.reloadData()
    }
    // MARK: Table Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nflTeams = searchPolls else {

            return 0
        }
        return nflTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        if let nflTeams = searchPolls {
            
            let team = nflTeams[indexPath.row]


            cell.textLabel!.text = "\(team)"

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex = indexPath.row
        let vc = storyboard?.instantiateViewController(withIdentifier: "PollController") as? PollController
        vc?.pollID = PollManager.sharedInstance.idData[myindex]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

