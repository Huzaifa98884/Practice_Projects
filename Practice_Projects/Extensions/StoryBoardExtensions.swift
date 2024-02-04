//
//  StoryBoardExtensions.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 22/06/2023.
//

import Foundation
import UIKit
enum AppStoryboard: String {
   case main = "Main"
   case torch = "TorchVC"
   case gallery = "GalleryVC"
   case maps = "GoogleMapsVC"
   case user = "MainVC"
   case chat = "ChatMain"
}

extension UIViewController{

    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func joinStrings(_ strings: String...) -> String {
        return strings.joined(separator: " ")
    }

}
