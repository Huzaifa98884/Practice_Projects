//
//  FullImageCVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 23/06/2023.
//

import UIKit
import ImageScrollView

class FullImageCVC: UICollectionViewCell {

    
    @IBOutlet weak var imageScrollView: ImageScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageScrollView.setup()
        // Initialization code
    }

}
