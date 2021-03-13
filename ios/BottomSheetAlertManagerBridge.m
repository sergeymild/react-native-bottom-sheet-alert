//
//  BottomSheetAlertManagerBridge.m
//  testBottom
//
//  Created by Sergei Golishnikov on 13/03/2021.
//

#import "React/RCTBridgeModule.h"


@interface RCT_EXTERN_MODULE(BottomSheetAlert, NSObject)
RCT_EXTERN_METHOD(show:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback)
@end
