//
//  GalleryApp.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 22/06/2023.
//

import UIKit
import RealmSwift

class GalleryVC : UIViewController, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cameraIconButton: UIButton!
    @IBAction func camerIconButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
           imagePicker.sourceType = .photoLibrary
           present(imagePicker, animated: true)
    }
    
    let imagePicker = UIImagePickerController()
    private let spacing: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        //createLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        let realmDB = try! Realm()
        let data = realmDB.objects(ImageModel.self)
        imagesArray = Array(data)
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        createLayout()
    }
    
}


extension GalleryVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCVC", for: indexPath) as! GalleryCVC
        if let imagedata = imagesArray[indexPath.row].image,
            let image = UIImage(data: imagedata) {
            cell.ImageFromUser.image = image
            }
        return cell
    }
}

extension GalleryVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc : FullImageVC = FullImageVC.instantiate(appStoryboard: .gallery)
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GalleryVC :  UICollectionViewDelegateFlowLayout{
    func createLayout(){
        cameraIconButton.layer.cornerRadius = cameraIconButton.frame.width / 2
        cameraIconButton.clipsToBounds = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        var width = 0.0
        if UIDevice.current.orientation.isLandscape{
            width = UIScreen.main.bounds.width / 2.325
            print("Screen is in landscape mode")
        } else{
            width = UIScreen.main.bounds.width / 2
            print("Screen is in portrait mode")
        }
        layout.itemSize = CGSize(width: width, height: width)
        self.collectionView?.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "GalleryCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryCVC")
    }
}

extension GalleryVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let vc: ConfirmImageVC = ConfirmImageVC.instantiate(appStoryboard: .gallery)
            vc.loadViewIfNeeded() // Ensure that the view is loaded
            
            if let imageView = vc.fullImage {
                imageView.image = pickedImage
                navigationController?.pushViewController(vc, animated: true)
                picker.dismiss(animated: true, completion: nil)
            } else {
                print("Error: full Image is nil")
            }
        }
    }
}







