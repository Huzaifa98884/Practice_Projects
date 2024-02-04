//
//  UserDetailsVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 14/07/2023.
//

import UIKit
import SDWebImage

class UserDetailsVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    var userData = UserProfile(image: "", name: "", email: "", phoneNumber: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData(data: userData)
        // Do any additional setup after loading the view.
    }
    
    func getUserData(data : UserProfile){
        fullName.text = data.name
        userEmail.text = data.email
        userPhoneNumber.text = data.phoneNumber
        if let url = URL(string: data.image){
            userImage.sd_setImage(with: url)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
