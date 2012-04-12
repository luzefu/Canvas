//
//  Canvas.h
//  Drawer
//
//  Created by 陆 泽夫 on 12-4-4.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Canvas : UIView

- (void)pan:(UIPanGestureRecognizer *)gesture;

@property (nonatomic,strong) UIColor* colorForStroke;
@property (nonatomic) CGFloat radiusForStroke;

@property (nonatomic,strong) UIImageView* unchangableImage;

@end
