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
@property (nonatomic,strong) IBOutlet id <canvasDelegate> delegate;
//gesture recognization
@property (nonatomic,strong) UIPanGestureRecognizer* gestureRecognizer;
- (void)pan:(UIPanGestureRecognizer *)gesture;
//variables
@property (nonatomic,strong) UIColor* colorForStroke;
@property (nonatomic) CGFloat radiusForStroke;
//image
@property (nonatomic,strong) UIImageView* unchangableImage;

@end
