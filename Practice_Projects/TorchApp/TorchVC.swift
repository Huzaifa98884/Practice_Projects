//
//  TorchApp.swift
//  Practice_Projects
//
//  Created by Huzaifa Ali Abbasi on 21/06/2023.
//

import UIKit
import AVFoundation

class TorchVC: UIViewController {

    @IBAction func imageTapped(_ sender: Any) {
        toogleflashlight()
    }
    @IBOutlet weak var torchImage: UIImageView!
    var status = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func toogleflashlight(){
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Flashlight is not available on this device.")
            return
        }
        if device.hasTorch && device.isTorchAvailable {
            do {
                try device.lockForConfiguration()
                if(device.torchMode == .off){
                    device.torchMode = .on
                    torchImage.image = UIImage(named: "torchon-image")
                }else{
                    device.torchMode = .off
                    torchImage.image = UIImage(named: "torchoff-image")
                }
                device.unlockForConfiguration()
            } catch {
                print("Error: Could not access flashlight.")
            }
        } else {
            print("Flashlight is not available on this device.")
        }
        
    }
}
