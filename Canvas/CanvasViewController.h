//
//  CanvasViewController.h
//  Canvas
//
//  Created by 陆 泽夫 on 12-4-12.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"
#import "CanvasSetting.h"

@interface CanvasViewController : UIViewController <canvasSettingDelegate, canvasDelegate>

- (IBAction)testButtonPressed;

@end
