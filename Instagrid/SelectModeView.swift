//
//  SelectModeView.swift
//  Instagrid
//
//  Created by Ludovic HENRY on 03/01/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class SelectModeView: UIStackView {
    
    @IBOutlet private var buttonMode: [UIButton]!
    
    enum Mode {
        case abcc, aacd, abcd
    }
    
    var mode: Mode = .abcc {
        didSet {
            setMode(mode: mode)
        }
    }
    
    /// Activates a button according to the chosen mode.
    /// - Parameter mode: Defines which button will be activated
    private func setMode(mode: Mode) {
        clearButtons()
        for button in buttonMode {
            switch mode {
            case .aacd:
                if button.tag == 0 { button.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)}
            case .abcc:
                if button.tag == 1 { button.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)}
            case .abcd:
                if button.tag == 2 { button.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)}
            }
        }
    }
    
    /// This method deletes all images in the buttons.
    /// Useful to disable all buttons.
    private func clearButtons() {
        for button in buttonMode {
            button.setImage(nil, for: .normal)
        }
    }
    
}
