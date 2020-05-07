//
//  PollManager.swift
//  IT358FinalHalikias
//
//  Created by Beverly L Brown on 5/6/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import Foundation

struct ItemObj: Codable {
    var Item: PollSession?
    
}
class PollManager{
    // MARK: Variables
    static let sharedInstance = PollManager()
    
    var pollStuff: PollSession?
    var searchData: [PollSession] = []
    var idData: [String] = []
    
    func addPollSession(pollH: PollSession) {
        self.searchData.append(pollH)
    }
    func addId(Id: String){
        idData.append(Id)
    }
    // MARK: POST Create Poll
    func createPoll(idNew: String){
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"ClassroomId\": \"\(idNew)\"\n }"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://4snqyiioih.execute-api.us-east-1.amazonaws.com/prod/pollsession2")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    // MARK: Get Session
    func getPoll(id: String) -> PollSession{
        var result: PollSession?
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://ro2ykdyu1d.execute-api.us-east-1.amazonaws.com/prod/pollsession2?ClassroomId=\(id)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
            }
            let decoder = JSONDecoder()
            
            do {
                let itemDecode = try decoder.decode(ItemObj.self, from: data)
                //print(itemDecode)
                self.pollStuff = itemDecode.Item!
                self.addPollSession(pollH: self.pollStuff!)
                result = itemDecode.Item!
            }
            catch {
                print("Error in JSON parsing")
            }
            
            //print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return result!
    }
    // MARK: POST Update result
    func updateResults(pollPost: PollSession){
        
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"ClassroomId\": \"\(pollPost.ClassroomId!)\",\n    \"LastUpdated\": \"2021-4-4\",\n    \"GotItCount\": \(pollPost.GotItCount!),\n    \"LostMeCount\": \(pollPost.LostMeCount!),\n    \"UnsureCount\": \(pollPost.UnsureCount!)\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://m93m44dzq7.execute-api.us-east-1.amazonaws.com/prod/pollsession2")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
