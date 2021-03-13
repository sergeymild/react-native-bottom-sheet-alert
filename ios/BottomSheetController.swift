//
//  BottomSheetController.swift
//  testBottom
//
//  Created by Sergei Golishnikov on 13/03/2021.
//

import Foundation
import UIKit

class BottomSheetController: UIViewController {
    let saveCompletion: (() -> Void)?
    var menus: [ListTileView] = []
    let scrollView = UIScrollView()
    let scrollViewStack = UIView()
    let titleText: String?
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = UIColor.lightGray
        return view
    }()
    
    lazy var headerContainer = UIView()
    lazy var headerBorderBottom = UIView()
    
    lazy var saveButton = UIButton()
    
    init(
        items: [ListTileView],
        title: String?,
        saveButtonText: String?,
        saveCompletion: (() -> Void)? = nil
    ) {
        self.saveCompletion = saveCompletion
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
        self.menus = items
        if saveButtonText != nil {
            saveButton.setTitle(saveButtonText, for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonPress), for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func saveButtonPress() {
        saveCompletion?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let showHeader = titleText != nil || saveCompletion != nil
        if showHeader {
            view.addSubview(headerContainer)
            headerContainer.addSubview(headerBorderBottom)
            headerBorderBottom.backgroundColor = UIColor(
                red: 213.0 / 255.0,
                green: 213.0 / 255.0,
                blue: 213.0 / 255.0,
                alpha: 1
            )
        }
        
        if saveCompletion != nil {
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            saveButton.setTitleColor(.black, for: .normal)
            saveButton.setTitleColor(UIColor(white: 0, alpha: 0.5), for: .highlighted)
            headerContainer.addSubview(saveButton)
            saveButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            saveButton.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16).isActive = true
            saveButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor).isActive = true
        }
        
        if titleText != nil {
            headerContainer.addSubview(titleView)
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.text = titleText
            
            titleView.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor).isActive = true
            titleView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16).isActive = true
//            titleView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16).isActive = true
//            if saveCompletion != nil {
//                titleView.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16).isActive = true
//            } else {
//                titleView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16).isActive = true
//            }
            
        }
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewStack)
        menus.forEach(self.scrollViewStack.addSubview)
        self.sheetViewController?.handleScrollView(scrollView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var index: CGFloat = 0
        
        let showHeader = titleText != nil || saveCompletion != nil
        let titleHeight: CGFloat = showHeader ? 56 : 0
        if showHeader {
            headerContainer.frame = .init(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: 56
            )

            headerBorderBottom.frame = .init(x: 0, y: 56, width: view.frame.width, height: 1)
        }
        
        for v in scrollViewStack.subviews {
            v.frame = .init(
                x: 0,
                y: index * 56,
                width: view.frame.width,
                height: 56
            )
            index += 1
        }
        
        scrollView.frame = .init(
            x: 0,
            y: titleHeight,
            width: view.frame.width,
            height: view.frame.height - titleHeight
        )
        scrollViewStack.frame = .init(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: scrollViewStack.subviews.last!.frame.maxY
        )
        scrollView.contentSize.height = scrollViewStack.frame.height
    }
    
    deinit {
        //debugPrint("DEINI bottom sheet")
    }
}
