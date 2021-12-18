//
//  UIImageExtension.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

enum ImageError: Error {
    case downloadError
}

extension UIImageView {
    func loadImage(urlSting: String, placeholderImage: UIImage) -> DispatchWorkItem? {
        image = placeholderImage
        guard let url = URL(string: urlSting) else { return nil }
        
        // Get image from cache
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return nil
        }
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem { [weak self] in
            // Download the image and store it in cache
            ImageDownloader.downloadImage(url: url) { result in
                guard let item = workItem, !item.isCancelled else { return }
                
                switch result {
                case .success(let data):
                    guard let imageToCache = UIImage(data: data) else { return }
                    imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self?.image = placeholderImage
                    }
                }
            }
        }
        
        DispatchQueue.global().async(execute: workItem!)
        return workItem
    }
    
    func roundCorner(corners: UIRectCorner, radius: Double) {
        let path = UIBezierPath(roundedRect: self.frame,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
      }
}

class ImageDownloader {
    private static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func downloadImage(url: URL, completion: @escaping (Result<Data, ImageError>) -> Void) {
        ImageDownloader.getData(url: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.downloadError))
                return
            }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}
