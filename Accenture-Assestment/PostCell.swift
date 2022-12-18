//
//  PostCell.swift
//  Accenture-Assestment
//
//  Created by ILB on 18/12/22.
//

import UIKit

final class PostCell: UICollectionViewCell {
    static let REUSE_IDENTIFIER = "PostCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setContents(_ model: PostModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
    }
}
