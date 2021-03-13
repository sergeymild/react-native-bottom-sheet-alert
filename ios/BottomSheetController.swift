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
  let titleText: String?
  lazy var titleView: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    view.textColor = UIColor.lightGray
    return view
  }()
    
    lazy var headerContainer = UIView()
    lazy var headerBorderBottom = UIView()
  
  init(items: [ListTileView], title: String?) {
    self.titleText = title
    super.init(nibName: nil, bundle: nil)
    self.menus = items
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    if titleText != nil {
        headerContainer.addSubview(titleView)
        headerContainer.addSubview(headerBorderBottom)
        headerBorderBottom.backgroundColor = UIColor(
            red: 213.0 / 255.0,
            green: 213.0 / 255.0,
            blue: 213.0 / 255.0,
            alpha: 1
        )
      titleView.text = titleText
      view.addSubview(headerContainer)
        
    }
    
    self.view.addSubview(scrollView)
    scrollView.addSubview(scrollViewStack)
    menus.forEach(self.scrollViewStack.addSubview)
    self.sheetViewController?.handleScrollView(scrollView)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    var index: CGFloat = 0
    
    let titleHeight: CGFloat = titleText != nil ? 56 : 0
    if titleText != nil {
        headerContainer.frame = .init(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 56
        )
        titleView.frame = .init(
            x: 16,
            y: 0,
            width: headerContainer.frame.width - 32,
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
