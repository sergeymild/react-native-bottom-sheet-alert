//
//  BottomSheetController.swift
//  testBottom
//
//  Created by Sergei Golishnikov on 13/03/2021.
//

import Foundation
import UIKit

class BottomSheetController: UIViewController {
    var menus: [ListTileView] = []
    let scrollView = UIScrollView()
    let scrollViewStack = UIView()
    var headerView: BottomSheetHeaderView!
    var showHeader: Bool
    
    
    init(
        items: [ListTileView],
        title: String?,
        saveButtonText: String?,
        saveCompletion: (() -> Void)? = nil
    ) {
        showHeader = title != nil || saveCompletion != nil
        if showHeader {
            headerView = BottomSheetHeaderView(
                title: title,
                saveButtonText: saveButtonText,
                saveCompletion: saveCompletion
            )
        }
        super.init(nibName: nil, bundle: nil)
        self.menus = items
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        if showHeader { view.addSubview(headerView) }
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewStack)
        menus.forEach(self.scrollViewStack.addSubview)
        self.sheetViewController?.handleScrollView(scrollView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var index: CGFloat = 0

        let titleHeight: CGFloat = showHeader ? 56 : 0
        if showHeader {
            headerView.frame = .init(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: 56
            )
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
