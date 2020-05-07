//
//  AddPoll.swift
//  IT358FinalHalikias
//
//  Created by Beverly L Brown on 5/7/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit
import os.log

class AddPoll: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pollTextField: UITextField!
    var pollNew: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
        os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        return
    }
        
        pollNew = pollTextField.text
        
        // Set the Course to be passed to TableViewController after unwind segue
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
