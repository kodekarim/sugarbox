//
//  FeatureCell.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import UIKit

class FeatureCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "FeatureCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
    
    func setupView() {
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let stackView = UIStackView(arrangedSubviews: [imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func configure(with app: Contents) {
        imageView.backgroundColor = .gray
        guard let imageUrl = getImageLink(assets: app.assets) else  {
            return
        }
        imageView.setImage(fromURL: imageUrl)
    }
    
}

extension FeatureCell : SelfConfiguringCell {}
