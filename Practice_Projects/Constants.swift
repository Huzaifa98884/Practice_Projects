//
//  File.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 21/06/2023.
//

import UIKit

//var imagesArray = [UIImage(named: "zoro") , UIImage(named: "zero") , UIImage(named: "zoro")]
var language = "en"
var selectedLanguageIndex = 0
var imagesArray = [ImageModel]()
extension UIColor {
    func createGradientColorWith(endColor: UIColor, size: CGSize) -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        gradientLayer.colors = [self.cgColor, endColor.cgColor]

        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIColor.clear
        }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return UIColor(patternImage: gradientImage ?? UIImage())
    }
    
    
    
}
