//
//  Canvas.h
//  Drawer
//
//  Created by 陆 泽夫 on 12-4-4.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol canvasDelegate

- (void)letSettingAppear;
- (void)letSettingDisappear;

@end

@interface Canvas : UIView 
//canvas delegate
@property (nonatomic,weak) IBOutlet id <canvasDelegate> delegate;
//variables
@property (nonatomic,strong) UIColor* colorForStroke;
@property (nonatomic) CGFloat maxRadiusForStroke;
@property (nonatomic) CGFloat minRadiusForStroke;
@property (nonatomic) BOOL autoRadiusChangingIsOff;
@property (nonatomic) BOOL radiusIncreaseWhenSpeedDecrease;
//image
@property (nonatomic,strong) UIImageView* unchangableImage;

@end
