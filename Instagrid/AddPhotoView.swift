//
//  AddPhotoView.swift
//  Instagrid
//
//  Created by Ludovic HENRY on 03/01/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class AddPhotoView: UIView {

    @IBOutlet private var images: [UIImageView]!
    @IBOutlet private var buttonsAdd: [UIButton]!
    @IBOutlet weak private var stackUp: UIStackView!
    @IBOutlet weak private var stackDown: UIStackView!

    enum Mode {
        case abcc, aacd, abcd
    }

    var mode: Mode = .abcc {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.setMode(mode: self.mode)
            }
        }
    }
    
    /// This method doubles the size of a UIImage.
    /// Useful to double the size of the "+" Buttons, and thus be conform to the design.
    func doubleImagesSize(){
        for image in images {
            let newWidth  = image.image!.size.width * 2
            let newHeight = image.image!.size.height * 2
            let newSize: CGSize = CGSize(width: newWidth, height: newHeight)
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.image!.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            image.image = newImage
        }
    }
    
    /// Changes the layout of the images contained in this AddPhotoView.
    /// - Parameter mode: Defines how the images will be arranged.
    private func setMode(mode: Mode) {
        switch mode {
        case .aacd:
            images[1].isHidden = false
            images[3].isHidden = true
            buttonsAdd[1].isHidden = false
            buttonsAdd[3].isHidden = true
        case .abcc:
            images[1].isHidden = true
            images[3].isHidden = false
            buttonsAdd[1].isHidden = true
            buttonsAdd[3].isHidden = false
        case .abcd:
            images[1].isHidden = false
            images[3].isHidden = false
            buttonsAdd[1].isHidden = false
            buttonsAdd[3].isHidden = false
        }
    }
    
    /// A method that allows you to insert an image in the AddPhotoView
    /// - Parameters:
    ///   - tag: The rank of the image to be displayed [0...3].
    ///   - photo: The UIImage to be displayed
    func insertPhoto(tag: Int, photo: UIImage) {
        switch tag {
        case 0:
            images[tag].image = photo
            images[tag].contentMode = .scaleAspectFill
        case 1:
            images[tag].image = photo
            images[tag].contentMode = .scaleAspectFill
        case 2:
            images[tag].image = photo
            images[tag].contentMode = .scaleAspectFill
        case 3:
            images[tag].image = photo
            images[tag].contentMode = .scaleAspectFill
        default:
            break
        }
    }
}
