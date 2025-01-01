//
//  NetworkManager.swift
//  lec7
//
//  Created by Ambrose Blay on 12/30/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    let decoder = JSONDecoder()
    
    private init () { }
    
    let endpoint = "https://ios-course-backend.cornellappdev.com/api/members/"
    
    func fetchRoster(completion: @escaping ([Member]) -> Void) {
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Member].self, decoder: decoder) { response in
                
                switch response.result {
                case .success(let members):
                    print("Successfully got \(members.count) Members")
                    completion(members)
                case .failure(let error):
                    print("Error in MetworkManager.fetRoster", error)
                }
            }
    }
    
    func addToRoster(member: Member, completion: @escaping ((Member) -> Void)) {
        let parameters: Parameters = [
            "name": member.name,
            "position": member.position,
            "subteam": member.subteam
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Member.self, decoder: decoder) { response in
                switch response.result {
                case .success(let member):
                    print("Successfully added \(member.name) to the roster")
                    completion(member)
                case .failure(let error):
                    print("Error in NetworkManager.addToRoster: \(error.localizedDescription)")
                }
            }
    }
}
