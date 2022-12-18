//
//  Webservice.swift
//  Accenture-Assestment
//
//  Created by ILB on 18/12/22.
//

import Foundation

final class Webservice {
    typealias PostResponse = (Data, URLResponse)
    private let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    static let shared = Webservice()
    
    private init() {}
    
    func getAllPosts() async throws -> [PostModel] {
        let request = URLRequest(url: url)
        let response: PostResponse = try await URLSession.shared.data(for: request)
        
        let postList = try JSONDecoder().decode([PostModel].self, from: response.0)
        return postList
    }
}
