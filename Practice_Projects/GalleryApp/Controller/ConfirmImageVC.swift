//
//  ConfirmImageVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 26/06/2023.
//

import UIKit
import RealmSwift

class ConfirmImageVC: UIViewController {
    var realmDB: Realm!
    
    @IBOutlet weak var fullImage: UIImageView!
    
    @IBAction func confirmButton(_ sender: UIButton) {
        try! realmDB.write {
            var imagemodel = ImageModel()
            imagemodel.image = fullImage.image!.jpegData(compressionQuality: 1.0)
            realmDB.add(imagemodel)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmDB = try! Realm()
        // Do any additional setup after loading the view.
    }

}
