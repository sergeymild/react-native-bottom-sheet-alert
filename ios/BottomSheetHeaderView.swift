//
//  BottomSheetHeaderView.swift
//  BottomSheetAlert
//
//  Created by Sergei Golishnikov on 14/03/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetHeaderView: UIView {
    let saveCompletion: (() -> Void)?
    
    let titleText: String?
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = UIColor.lightGray
        return view
    }()
    

    var headerBorderBottom = UIView()
    var saveButton = UIButton()
    
    init(
        title: String?,
        saveButtonText: String?,
        saveCompletion: (() -> Void)? = nil
    ) {
        self.saveCompletion = saveCompletion
        self.titleText = title
        super.init(frame: .zero)
        if saveButtonText != nil {
            saveButton.setTitle(saveButtonText, for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonPress), for: .touchUpInside)
        }
        
        addSubview(headerBorderBottom)
        headerBorderBottom.backgroundColor = UIColor(
            red: 213.0 / 255.0,
            green: 213.0 / 255.0,
            blue: 213.0 / 255.0,
            alpha: 1
        )
        
        if saveCompletion != nil {
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            saveButton.setTitleColor(.black, for: .normal)
            saveButton.setTitleColor(UIColor(white: 0, alpha: 0.5), for: .highlighted)
            addSubview(saveButton)
            saveButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
        if titleText != nil {
            addSubview(titleView)
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.text = titleText
            
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
//            titleView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16).isActive = true
//            if saveCompletion != nil {
//                titleView.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16).isActive = true
//            } else {
//                titleView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16).isActive = true
//            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func saveButtonPress() {
        saveCompletion?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerBorderBottom.frame = .init(x: 0, y: 56, width: frame.width, height: 1)
    }
}
