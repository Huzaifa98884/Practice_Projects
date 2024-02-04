//
//  MainTableViewCell.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 21/06/2023.
//

import UIKit

class AllAppsTVC: UITableViewCell {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var nibBackground: UIView!
    @IBOutlet weak var appImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackgroundProperties()
    }
    
    
    
    func setBackgroundProperties(){
        nibBackground.layer.cornerRadius = 10
//        let startColor = UIColor.systemTeal
//        let endColor = UIColor.systemTeal.withAlphaComponent(0.2)
//        let gradientColor = createGradientColor(startColor: startColor, endColor: endColor, size: nibBackground.frame.size)
//
//        nibBackground.backgroundColor = gradientColor
        nibBackground.backgroundColor = .systemTeal.createGradientColorWith(endColor: .systemTeal.withAlphaComponent(0.2), size: nibBackground.frame.size)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
}




