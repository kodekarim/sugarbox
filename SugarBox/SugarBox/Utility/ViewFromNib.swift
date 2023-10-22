//
//  ViewFromNib.swift
//  SugarBox
//
//  Created by abdul karim on 21/10/23.
//

import Foundation
import UIKit

protocol ViewFromNib {}

extension ViewFromNib {
    
    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
//    
//    static func view() -> Self? {
//        let objects = self.nib.instantiate(withOwner: nil, options: nil)self.sections[indexPath.section].type
//        return objects.first as? Self
//    }
//    
//    static func viewController<T: UIViewController>() -> T? {
//        return T(nibName: nibName, bundle: nil)
//    }
//    
//    static func registerCellForCollectionView(_ collectionView: UICollectionView) {
//        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
//    }
//    
//    static func cell<T: UICollectionViewCell>(collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> T {
//        return collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as! T
//    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

