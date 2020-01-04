//
//  ViewController.swift
//  Instagrid
//
//  Created by Ludovic HENRY on 01/01/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addPhotoVIew: AddPhotoView!
    @IBOutlet weak var selectModeView: SelectModeView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    private var tagSelectedImageView: Int?

    enum Orientation {
        case landscape, portrait
    }
    
    var orientation: Orientation = .portrait {
        didSet {
            switch orientation {
            case .landscape:
                swipeLabel.text = "Swipe left to share"
                arrowImage.image = #imageLiteral(resourceName: "Arrow Left") //Arrow left icon
            case .portrait:
                swipeLabel.text = "Swipe up to share"
                arrowImage.image = #imageLiteral(resourceName: "Arrow Up") // Arrow up icon
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orientation = .portrait
        addPhotoVIew.mode = .aacd
        selectModeView.mode = .aacd
        addPhotoVIew.foisdeux()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeUp.direction = .up
        addPhotoVIew.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeLeft.direction = .left
        addPhotoVIew.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            if orientation == .portrait {
                animation()
            }
        }
        if sender.direction == .left {
            if orientation == .landscape {
                animation()
            }
        }
    }
    
    private func animation() {
        let animation: CGAffineTransform!
        switch orientation {
        case .landscape:
            animation = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        case .portrait:
            animation = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.addPhotoVIew.transform = animation!
            self.swipeLabel.transform = animation!
            self.arrowImage.transform = animation!
        }) { (isComplet) in
            if isComplet {
                let ac = UIActivityViewController(activityItems: [self.image(with: self.addPhotoVIew)!], applicationActivities: nil)
                self.present(ac, animated: true, completion: nil)
                ac.completionWithItemsHandler = self.afterActivityView(activityType:completed:items:Error:)
            }
        }
    }
    
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    private func afterActivityView(activityType: UIActivity.ActivityType?, completed: Bool, items: [Any]?, Error: Error?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.addPhotoVIew.transform = .identity
            self.swipeLabel.transform = .identity
            self.arrowImage.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func switchToAACD() {
        selectModeView.mode = .aacd
        addPhotoVIew.mode = .aacd
    }
    
    @IBAction func switchToABCC() {
        selectModeView.mode = .abcc
        addPhotoVIew.mode = .abcc
    }

    @IBAction func switchToABCD() {
        selectModeView.mode = .abcd
        addPhotoVIew.mode = .abcd
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            tagSelectedImageView = sender.tag
            showImagePicker()
        case 1:
            tagSelectedImageView = sender.tag
            showImagePicker()
        case 2:
            tagSelectedImageView = sender.tag
            showImagePicker()
        case 3:
            tagSelectedImageView = sender.tag
            showImagePicker()
        default:
            break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            orientation = .landscape
        default:
            orientation = .portrait
        }
    }
        
    private func showImagePicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {

            addPhotoVIew.insertPhoto(tag: tagSelectedImageView!, photo: image)
        } else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
}

