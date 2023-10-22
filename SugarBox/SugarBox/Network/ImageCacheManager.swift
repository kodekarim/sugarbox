//
//  ImageCacheManager.swift
//  SugarBox
//
//  Created by abdul karim on 22/10/23.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()

    private let cache = NSCache<NSString, UIImage>()

    func getImage(fromURL url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            // If not cached, fetch the image from the URL
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                // Cache the fetched image
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}

extension UIImageView {
    func setImage(fromURL url: URL) {
        ImageCacheManager.shared.getImage(fromURL: url) { [weak self] image in
            guard let StrongSelf = self else  { return }
            if let image = image {
                DispatchQueue.main.async {
                    StrongSelf.self.image = image
                }

            } else {
                // Handle the case where the image couldn't be loaded
            }
        }
    }
}
