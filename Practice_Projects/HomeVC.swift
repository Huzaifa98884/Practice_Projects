//
//  ViewController.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 21/06/2023.
//

import UIKit
import AudioToolbox

class HomeVC: UIViewController{
    
    @IBOutlet weak var appsList: UITableView!
    @IBOutlet weak var featuresTitle: UILabel!
    var allApps: [AppsModel] = [
        AppsModel(appName: "Torch App".localizeString(), appIcon: UIImage(named: "torchIcon")! , vc: TorchVC.instantiate(appStoryboard: .torch)) ,
        AppsModel(appName: "Gallery App".localizeString(), appIcon: UIImage(named: "gallery-icon")!.withTintColor(.white), vc: GalleryVC.instantiate(appStoryboard: .gallery)) ,
        AppsModel(appName: "Maps App".localizeString(), appIcon: UIImage(named: "maps-icon")!.withTintColor(.white), vc: GoogleMapsVC.instantiate(appStoryboard: .maps)),
        AppsModel(appName: "User Data".localizeString(), appIcon: UIImage(named: "user-icon")!.withTintColor(.white), vc: LoginVC.instantiate(appStoryboard: .user)),
        AppsModel(appName: "Chat App".localizeString(), appIcon: UIImage(named: "user-icon")!.withTintColor(.white), vc: LoginChatAppVC.instantiate(appStoryboard: .chat))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appsList.dataSource = self
        appsList.delegate = self
        appsList.register(UINib(nibName: "AllAppsTVC", bundle: nil), forCellReuseIdentifier: "AllAppsTVC")
        
    }
    
    @IBAction func settingButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
//    func changeLanguage(lang: String) {
//        featuresTitle.text = "features".localizeString(string: lang)
//    }
    
}

extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAppsTVC", for: indexPath) as! AllAppsTVC
        cell.appName.text = allApps[indexPath.row].appName
        cell.appImage.image = allApps[indexPath.row].appIcon
        return cell
    }
}

extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.selectionStyle = .none
            AudioServicesPlaySystemSound(1519)
            self.navigationController?.pushViewController(allApps[indexPath.row].vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight : CGFloat = 100
        
        let screenHeight = UIScreen.main.bounds.size.height
        
        let maxHeight = screenHeight * 0.8
        
        return min(cellHeight, maxHeight)
    }
    
}
