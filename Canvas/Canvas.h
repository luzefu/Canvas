//
//  Canvas.h
//  Drawer
//
//  Created by 陆 泽夫 on 12-4-4.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Canvas : UIView
//gesture recognization
@property (nonatomic,strong) UIPanGestureRecognizer* gestureRecognizer;
- (void)pan:(UIPanGestureRecognizer *)gesture;
//variables
@property (nonatomic,strong) UIColor* colorForStroke;
@property (nonatomic) CGFloat radiusForStroke;
//need to be discuessed
@property (nonatomic,strong) UIImageView* unchangableImage;

@end
