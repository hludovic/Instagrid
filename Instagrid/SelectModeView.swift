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
    
    private func setMode(mode: Mode) {
        switch mode {
        case .aacd:
            clearButtons()
            buttonMode[0].setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        case .abcc:
            clearButtons()
            buttonMode[1].setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        case .abcd:
            clearButtons()
            buttonMode[2].setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        }
    }
    
    private func clearButtons() {
        buttonMode[0].setImage(nil, for: .normal)
        buttonMode[1].setImage(nil, for: .normal)
        buttonMode[2].setImage(nil, for: .normal)
    }
    
}
