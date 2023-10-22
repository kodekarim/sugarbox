//
//  CollectionCell.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let stackView = UIStackView(arrangedSubviews: [imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }

}

extension ContentCell : SelfConfiguringCell {
    static var reuseIdentifier: String = "ContentCell"
    
    func configure(with app: Contents) {
        imageView.backgroundColor = .gray
        guard let imageUrl = getImageLink(assets: app.assets) else  {
            return
        }
        imageView.setImage(fromURL: imageUrl)
    }
}
