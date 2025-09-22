//
//  ItemCell.swift
//  Menu
//
//  Created by Not Null on 13.09.2025.
//  Copyright © 2025 DoorDash, Inc. All rights reserved.
//

import UIKit

final class ItemCell: UITableViewCell {
    
    static let identifier = "ItemCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        titleLabel.isHidden = item.title == nil
        
        descriptionLabel.text = item.description
        
        if let imageUrl = item.imageUrl {
            myImageView.isHidden = false
            
            let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                
                guard let self else { return }
                
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                
                guard let data else {
                    print("\(String(describing: error?.localizedDescription))")
                    return
                }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.myImageView.image = image
                    }
                } else {
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
            task.resume()
            
        } else {
            myImageView.isHidden = true
        }
        
        descriptionLabel.text = item.description
    }

    private func setupUI() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        
        mainStackView.addArrangedSubview(textStackView)
        mainStackView.addArrangedSubview(myImageView)
        
        contentView.addSubview(mainStackView)
        
        contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            myImageView.heightAnchor.constraint(equalToConstant: 80),
            myImageView.widthAnchor.constraint(equalToConstant: 80),
            
        ])
    }
}
