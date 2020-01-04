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
    @IBOutlet weak var stackUp: UIStackView!
    @IBOutlet weak var stackDown: UIStackView!

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
    
    func foisdeux(){
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
