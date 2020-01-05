//
//  ViewController.swift
//  Instagrid
//
//  Created by Ludovic HENRY on 01/01/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Properties
    @IBOutlet weak var addPhotoVIew: AddPhotoView!
    @IBOutlet weak var selectModeView: SelectModeView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    private var tagSelectedImageView: Int?

    enum Orientation {
        case landscape, portrait
    }
    
    private var orientation: Orientation = .portrait {
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
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orientation = .portrait
        addPhotoVIew.mode = .aacd
        selectModeView.mode = .aacd
        addPhotoVIew.doubleImagesSize()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeUp.direction = .up
        addPhotoVIew.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeLeft.direction = .left
        addPhotoVIew.addGestureRecognizer(swipeLeft)
    }
    
    /// This method will be called when a swipe is exerted on the AddPhotoView.
    /// - Parameter sender: The UISwipeGestureRecognizer that was performed.
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
    
    /// Slides the AddPhotoView out of the screen, and adjusts to the screen orientation.
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
                if let image = self.imageConverter(self.addPhotoVIew) {
                    let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                    self.present(ac, animated: true, completion: nil)
                    ac.completionWithItemsHandler = self.afterActivityView(activityType:completed:items:Error:)
                }
            }
        }
    }
    
    /// Convert a UIView into an UIImage
    /// - Parameter view: The UIView that will  be converted into an UIImage.
    private func imageConverter(_ view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    /// This method is an UIActivityViewController.CompletionWithItemsHandler. It is executed when the Activity View Controller has finished executing.
    /// Here the AddPhotoView returns to its place.
    /// - Parameters:
    ///   - activityType: The type of the service that was selected by the user.
    ///   - completed: true if the service was performed or false if it was not.
    ///   - items: An array of NSExtensionItem objects containing any modified data.
    ///   - Error: An error object if the activity failed to complete, or nil if the the activity completed normally.
    private func afterActivityView(activityType: UIActivity.ActivityType?, completed: Bool, items: [Any]?, Error: Error?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.addPhotoVIew.transform = .identity
            self.swipeLabel.transform = .identity
            self.arrowImage.transform = .identity
        }, completion: nil)
    }
    
    // This method is called when the size of the view has changed.
    // Here it adapts the content of the view if the phone is in landscape or portrait mode.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            orientation = .landscape
        default:
            orientation = .portrait
        }
    }
    
    /// This method displays an ImagePicker
    private func showImagePicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    // This method is called after the image has been selected in the ImagePicker.
    // Here she inserts the chosen photo in the AddPhotoView.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            addPhotoVIew.insertPhoto(tag: tagSelectedImageView!, photo: image)
        } else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @IBAction
    
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

}

