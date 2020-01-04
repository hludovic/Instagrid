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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func switchToABCC() {
        selectModeView.mode = .abcc
        addPhotoVIew.mode = .abcc
    }
    
    @IBAction func switchToAACD() {
        selectModeView.mode = .aacd
        addPhotoVIew.mode = .aacd
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

