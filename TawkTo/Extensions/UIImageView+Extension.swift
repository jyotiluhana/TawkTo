//
//  UIImageView+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 18/10/21.
//

import Foundation
import UIKit

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func url(_ url: String?, setInverted: Bool = false) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = setInverted ? image?.invertedImage() : image
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
    
    func downloaded(from link: String,withPlaceholder placeHolder : UIImage? = UIImage(named: "person_outline"),  contentMode mode: UIView.ContentMode = .scaleAspectFit,size : CGSize) {
        //set Placeholder first
        self.image = placeHolder
        
        //Check images in temoprory Chache files
        if let img = ImageStore.imageCache.object(forKey: NSString(string: link)) {
            self.image = img
            return
        }
        
        //check for network connection
        if NetworkListner.shared.isNetworkAvailable{
            //create url
            guard let url = URL(string: link) else {
                return
            }
            DispatchQueue.global(qos: .userInteractive).async {
                if let img = UIImageView.downsample(imageAt: url , to: size, scale: UIScreen.main.scale) {
                    
                    DispatchQueue.main.async() { [weak self] in
                        self?.image = img
                    }
                    ImageStore.imageCache.setObject(img, forKey: NSString(string: link))
                    print("Image Downsampled :(NSString(string: link).lastPathComponent)")
                    //save compress imaged into offline storage & image Cache
                } else {
                    //download image
                    print("Image Downsampled Failed:(NSString(string: link).lastPathComponent)")
                    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                        guard
                            let httpURLResponse = response as? HTTPURLResponse,( httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300),
                            let data = data, error == nil,
                            let image = UIImage(data: data)
                        else {
                            return
                        }
                        DispatchQueue.main.async() { [weak self] in
                            self?.image = image
                        }
                        //save compress imaged into offline storage & image Cache
                        
                        ImageStore.imageCache.setObject(image, forKey: NSString(string: link))
                    }.resume()
                }
                
            }
        }
    }
    
    static func downsample(imageAt imageURL: URL,
                           to pointSize: CGSize,
                           scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        
        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            print("Image Downsampled failed from image source :(NSString(string: imageURL.absoluteString).lastPathComponent)")
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            print("Image Downsampled failed from thumbnail :(NSString(string: imageURL.absoluteString).lastPathComponent)")
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
    
}

