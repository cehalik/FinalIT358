//
//  PollSession.swift
//  IT358FinalHalikias
//
//  Created by Beverly L Brown on 5/6/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import Foundation
struct PollSession: Codable {
    var ClassroomId: String?
    var LastUpdated: String?
    var GotItCount: Int?
    var LostMeCount: Int?
    var UnsureCount: Int?
}

struct PolliDObj {
    var ClassroomId: String
    
    init?(ClassroomId: String){
        self.ClassroomId = ClassroomId
    }
    
}
