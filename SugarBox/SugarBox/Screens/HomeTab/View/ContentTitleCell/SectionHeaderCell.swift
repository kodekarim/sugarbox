//
//  SectionHeaderCell.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import UIKit

class SectionHeaderCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "SectionHeaderCell"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .medium))
        
        let stackView = UIStackView(arrangedSubviews: [title])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
    
    
}
