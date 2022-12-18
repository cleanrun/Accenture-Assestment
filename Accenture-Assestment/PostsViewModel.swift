//
//  PostsViewModel.swift
//  Accenture-Assestment
//
//  Created by ILB on 18/12/22.
//

import Foundation
import Combine

final class PostsViewModel: ObservableObject {
    @Published private(set) var posts: [PostModel] = []
    @Published private(set) var groupedPosts: Dictionary<Int, [PostModel]> = [:]
    
    init() {}
    
    func getAllPosts() async {
        do {
            let posts = try await Webservice.shared.getAllPosts()
            self.posts = posts
            self.groupedPosts = Dictionary(grouping: self.posts, by: { $0.userId })
        } catch {
            print(error.localizedDescription)
            self.posts.removeAll()
        }
    }
}
