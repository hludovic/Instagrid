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
        case aacd, abcc , abcd
    }

    var mode: Mode = .aacd {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.setMode(mode: self.mode)
            }
        }
    }
        
    /// Convert a UIView into an UIImage
    /// - Parameter view: The UIView that will  be converted into an UIImage.
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }

    /// Changes the layout of the images contained in this AddPhotoView.
    /// - Parameter mode: Defines how the images will be arranged.
    private func setMode(mode: Mode) {
        for image in images {
            for button in buttonsAdd {
                switch mode {
                case .aacd:
                    if image.tag == 1 { image.isHidden = true}
                    if image.tag == 3 { image.isHidden = false}
                    if button.tag == 1 { button.isHidden = true}
                    if button.tag == 3 { button.isHidden = false}
                    break
                case .abcc:
                    if image.tag == 1 { image.isHidden = false}
                    if image.tag == 3 { image.isHidden = true}
                    if button.tag == 1 { button.isHidden = false}
                    if button.tag == 3 { button.isHidden = true}
                    break
                case .abcd:
                    if image.tag == 1 { image.isHidden = false}
                    if image.tag == 3 { image.isHidden = false}
                    if button.tag == 1 { button.isHidden = false}
                    if button.tag == 3 { button.isHidden = false}
                    break
                }
            }
        }
    }
    
    /// A method that allows you to insert an image in the AddPhotoView
    /// - Parameters:
    ///   - tag: The rank of the image to be displayed [0...3].
    ///   - photo: The UIImage to be displayed
    func insertPhoto(tag: Int, photo: UIImage) {
        for image in images {
            if image.tag == tag {
                image.image = photo
                image.contentMode = .scaleAspectFill
            }
        }
    }
}
