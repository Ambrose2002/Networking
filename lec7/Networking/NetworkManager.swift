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
    
    private init () { }
    
    func fetchRoster(completion: @escaping ([Member]) -> Void) {
        
        let endpoint = "https://ios-course-backend.cornellappdev.com/api/members/"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
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
}
