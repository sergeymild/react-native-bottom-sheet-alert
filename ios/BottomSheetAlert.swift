//
//  BottomSheetView.swift
//  testBottom
//
//  Created by Sergei Golishnikov on 13/03/2021.
//

import Foundation
import React


@objc(BottomSheetAlert)
class BottomSheetAlert: NSObject, RCTBridgeModule {
  static func moduleName() -> String! {
    return "BottomSheetAlert"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  func show(_ options: NSDictionary, callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      BottomSheetAlertPresenter().present(options: options, callback: callback)
    }
  }
}
