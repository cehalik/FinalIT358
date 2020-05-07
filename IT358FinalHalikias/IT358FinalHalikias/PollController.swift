//
//  PollController.swift
//  IT358FinalHalikias
//
//  Created by Beverly L Brown on 5/6/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit

class PollController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gotItLabel: UILabel!
    @IBOutlet weak var lostMeLabel: UILabel!
    @IBOutlet weak var UnsureLabel: UILabel!
    @IBOutlet weak var noResponseLabel: UILabel!
    var pollID = ""
    var pollDetails: PollSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pollID)
        pollDetails = PollManager.sharedInstance.getPoll(id: pollID)
        titleLabel.text = pollDetails?.ClassroomId!
        if (pollDetails?.GotItCount == 0) && (pollDetails?.LostMeCount == 0) && (pollDetails?.UnsureCount == 0){
            gotItLabel.text = ""
            lostMeLabel.text = ""
            UnsureLabel.text = ""
        } else {
            gotItLabel.text = String(pollDetails!.GotItCount!)
            lostMeLabel.text = String(pollDetails!.LostMeCount!)
            UnsureLabel.text = String(pollDetails!.UnsureCount!)
            noResponseLabel.text = ""
        }
        // Do any additional setup after loading the view.
    }
    func updateCounts(){
        pollDetails = PollManager.sharedInstance.getPoll(id: pollID)
        gotItLabel.text = String(pollDetails!.GotItCount!)
        lostMeLabel.text = String(pollDetails!.LostMeCount!)
        UnsureLabel.text = String(pollDetails!.UnsureCount!)
    }
    
    @IBAction func updateGotItCount(_ sender: Any) {
        pollDetails?.GotItCount! += 1
        gotItLabel.text = String(pollDetails!.GotItCount!)
        noResponseLabel.text = ""
        PollManager.sharedInstance.updateResults(pollPost: pollDetails!)
        updateCounts()
    }
    
    @IBAction func updateLostMeCount(_ sender: Any) {
        pollDetails?.LostMeCount! += 1
        lostMeLabel.text = String(pollDetails!.LostMeCount!)
        noResponseLabel.text = ""
        PollManager.sharedInstance.updateResults(pollPost: pollDetails!)
        updateCounts()
    }
    @IBAction func updateUnsureCount(_ sender: Any) {
        pollDetails?.UnsureCount! += 1
        UnsureLabel.text = String(pollDetails!.UnsureCount!)
        noResponseLabel.text = ""
        PollManager.sharedInstance.updateResults(pollPost: pollDetails!)
        updateCounts()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
