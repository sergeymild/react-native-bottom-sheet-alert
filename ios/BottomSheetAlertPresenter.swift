//
//  BottomSheetAlertPresenter.swift
//  testBottom
//
//  Created by Sergei Golishnikov on 13/03/2021.
//

import Foundation
import UIKit
import FittedSheets

var previousBottomSheet: SheetViewController?

class BottomSheetAlertPresenter {
  var strongSelf: BottomSheetAlertPresenter?
  
  var alertWindow: UIWindow?
  
  private func createAlertWindow() {
    if alertWindow != nil { return }
    let frame = RCTSharedApplication()?.keyWindow?.bounds ?? UIScreen.main.bounds
    alertWindow = UIWindow(frame: frame)
    alertWindow?.rootViewController = UIViewController()
    alertWindow?.windowLevel = UIWindow.Level.alert + 1
    alertWindow?.makeKeyAndVisible()
  }
  
  func present(options: NSDictionary, callback: @escaping RCTResponseSenderBlock) {
    strongSelf = self
    createAlertWindow()
    
    let completion = { [weak self] in
      guard let self = self else { return }
      previousBottomSheet = nil
      var menus: [ListTileView] = []
      var sheetController: SheetViewController?
      
      let buttons = options["buttons"] as? Array<NSDictionary> ?? []
      if buttons.isEmpty { return }
      
      for (i, button) in buttons.enumerated() {
        let item = ListTileView(title: button["text"] as! String)
        menus.append(item)
        item.isWarning = button["style"] as? String == "destruction"
        item.tap {
          previousBottomSheet?.closeSheet(completion: {
            callback([i])
          })
        }
      }
      
      let title = options["title"] as? String
      let controller = BottomSheetController(
        items: menus,
        title: title
      )
      
      var bottomSafeArea: CGFloat = 0
      if #available(iOS 11.0, *) {
        bottomSafeArea = self.alertWindow?.safeAreaInsets.bottom ?? 0
      }
      let menusSize = menus.count * 56 + 18 + 6
      let titleSize = title != nil ? 56 : 0
        let size = CGFloat(CGFloat(menusSize + titleSize) + bottomSafeArea)
      sheetController = SheetViewController(
        controller: controller,
        sizes: [.fixed(size)]
      )
      sheetController?.topCornersRadius = 20
      sheetController?.overlayColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
      sheetController?.adjustForBottomSafeArea = false
      sheetController?.blurBottomSafeArea = false
      sheetController?.extendBackgroundBehindHandle = true
      self.alertWindow?.rootViewController?.present(sheetController!, animated: false)
      previousBottomSheet = sheetController
      sheetController?.didDismiss = { [weak self] _ in
        debugPrint("didDismiss")
        controller.removeFromParent()
        previousBottomSheet = nil
        self?.alertWindow = nil
        self?.strongSelf = nil
      }
    }
    
    if previousBottomSheet == nil { completion() }
    else {
      previousBottomSheet?.dismiss(animated: true, completion: completion)
    }
  }
  
  deinit {
    debugPrint("deinit presenter")
  }
}
