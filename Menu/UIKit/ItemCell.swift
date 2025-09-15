//
//  ItemCell.swift
//  Menu
//
//  Created by Not Null on 13.09.2025.
//  Copyright © 2025 DoorDash, Inc. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    static let identifier = "ItemCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark") //nil
        iv.tintColor = .label
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "title" //nil
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "description description description description description description description" //nil
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .top
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        titleLabel.isHidden = item.title == nil
        
        if let imageUrl = item.imageUrl {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.myImageView.image = image
                    }
                }
            }
            myImageView.isHidden = false
        } else {
            myImageView.isHidden = true
        }
        
        descriptionLabel.text = item.description
    }

    private func setupUI() {
        self.textStackView.addArrangedSubview(titleLabel)
        self.textStackView.addArrangedSubview(descriptionLabel)
        
        self.mainStackView.addArrangedSubview(textStackView)
        self.mainStackView.addArrangedSubview(myImageView)
        
        self.contentView.addSubview(mainStackView)
        
        self.contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            myImageView.heightAnchor.constraint(equalToConstant: 80),
            myImageView.widthAnchor.constraint(equalToConstant: 80),
            
        ])
    }
}
