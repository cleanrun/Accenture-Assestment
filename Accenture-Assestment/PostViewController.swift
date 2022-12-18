//
//  PostViewController.swift
//  Accenture-Assestment
//
//  Created by ILB on 18/12/22.
//

import UIKit
import Combine

final class PostsViewController: UIViewController {
    
    private var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var viewModel = PostsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCancellables()
        Task {
            await viewModel.getAllPosts()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.REUSE_IDENTIFIER)
        postCollectionView.register(PostHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PostHeaderView.REUSE_IDENTIFIER)
        
        view.addSubview(postCollectionView)
        
        NSLayoutConstraint.activate([
            postCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            postCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            postCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            postCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupCancellables() {
        viewModel.$posts
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.postCollectionView.reloadData()
            }.store(in: &cancellables)
    }
    
}

extension PostsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.groupedPosts.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Array(viewModel.groupedPosts)[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.REUSE_IDENTIFIER, for: indexPath) as! PostCell
        cell.setContents(Array(viewModel.groupedPosts)[indexPath.section].value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/2) - 10
        return CGSize(width: width, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PostHeaderView.REUSE_IDENTIFIER, for: indexPath) as! PostHeaderView
            let key = Array(viewModel.groupedPosts)[indexPath.section].key
            view.setTitle("User Id: \(key)")
            return view
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
    
}

