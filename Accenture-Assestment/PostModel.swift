//
//  PostModel.swift
//  Accenture-Assestment
//
//  Created by ILB on 18/12/22.
//

import Foundation

struct PostModel: Decodable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}
