//
//  FullImageVC.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 23/06/2023.
//

import UIKit

class FullImageVC: UIViewController {
    var index = 2
    @IBOutlet weak var fullImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullImageCollectionView.dataSource = self
        fullImageCollectionView.delegate = self
        fullImageCollectionView.register(UINib(nibName: "FullImageCVC", bundle: nil), forCellWithReuseIdentifier: "FullImageCVC")
       // createLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.fullImageCollectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
            self.fullImageCollectionView.isPagingEnabled = true
        }
    }
    override func viewDidLayoutSubviews() {
        createLayout()
    }
    
    
}

extension FullImageVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullImageCVC", for: indexPath) as! FullImageCVC
        if let imagedata = imagesArray[indexPath.row].image,
            let image = UIImage(data: imagedata) {
                cell.imageScrollView.display(image: image)
            }
        return cell
    }
}

extension FullImageVC : UICollectionViewDelegate{
  
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//   }
}

extension FullImageVC :  UICollectionViewDelegateFlowLayout{
    func createLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
        self.fullImageCollectionView?.collectionViewLayout = layout
    }
}
