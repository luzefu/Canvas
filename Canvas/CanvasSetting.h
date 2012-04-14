//
//  CanvasSetting.h
//  Canvas
//
//  Created by 陆 泽夫 on 12-4-13.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol canvasSettingDelegate

- (void)achieveNewColor;

@end

@interface CanvasSetting : UIView

//degelate
@property (nonatomic,weak) IBOutlet id <canvasSettingDelegate> canvasSettingDelegate;
//Sliders
@property (nonatomic,strong) UISlider *redController;
@property (nonatomic,strong) UISlider *greenController;
@property (nonatomic,strong) UISlider *blueController;
@property (nonatomic,strong) UISlider *alphaController;
//Color Value
@property (nonatomic,strong) UIColor *changedColor;

@end
