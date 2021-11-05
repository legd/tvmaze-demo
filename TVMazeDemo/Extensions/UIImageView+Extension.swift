//
//  UIImageView+Extension.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 2/11/21.
//

import UIKit

extension UIImageView {
    
    public func imageFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "coming-soon")!
                }
            }
        }
    }
}
