//
//  UIImageView+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 18/10/21.
//

import Foundation
import UIKit

extension UIImageView {
    // way to hack stored property in extension, we using static hence needed dictionary to store based on address
    private static var urlStore = [String:String]()

    
    func setImage(url: String, placeholderImage: UIImage? = nil) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView.urlStore[tmpAddress] = url
        
        if let image = placeholderImage {
            self.image = image
        } else{
            self.backgroundColor = .gray
        }
        
//        ImageDownloader().downloadAndCacheImage(url: url, onSuccess: { (image, url) in
//            DispatchQueue.main.async {
//            if UIImageView.urlStore[tmpAddress] == url {
//                        self.image = image
//                        self.backgroundColor = .clear
//                    }
//            }
//        }) { error in
//        }
    }
}

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            }else {
                setImage(image: nil)
            }
        }
    }
}

