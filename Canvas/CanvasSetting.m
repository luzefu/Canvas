//
//  CanvasSetting.m
//  Canvas
//
//  Created by 陆 泽夫 on 12-4-13.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import "CanvasSetting.h"

@interface CanvasSetting()
//Labels
@property (nonatomic,strong) UILabel *redLabel;
@property (nonatomic,strong) UILabel *greenLabel;
@property (nonatomic,strong) UILabel *blueLabel;
@property (nonatomic,strong) UILabel *alphaLabel;

@end

@implementation CanvasSetting
//degelate
@synthesize canvasSettingDelegate = _canvasSettingDelegate;
//Sliders
@synthesize redController = _redController;
@synthesize greenController = _greenController;
@synthesize blueController = _blueController;
@synthesize alphaController = _alphaController;
//Labels
@synthesize redLabel = _redLabel;
@synthesize greenLabel = _greenLabel;
@synthesize blueLabel = _blueLabel;
@synthesize alphaLabel = _alphaLabel;
//Color Value
@synthesize changedColor = _changedColor;

//colorControllers setup
- (UISlider*)redController
{
    if (_redController == nil) {
        _redController = [[UISlider alloc]init];
        _redController.maximumValue = 1;
        _redController.minimumValue = 0;
        _redController.value = 0;
        [_redController addTarget:self action:@selector(refreshLabels:) forControlEvents:UIControlEventValueChanged];
        [_redController addTarget:self.canvasSettingDelegate action:@selector(achieveNewColor) forControlEvents:UIControlEventValueChanged];
    }
    return _redController;
}

- (UISlider*)blueController
{
    if (_blueController == nil) {
        _blueController = [[UISlider alloc]init];
        _blueController.maximumValue = 1;
        _blueController.minimumValue = 0;
        _blueController.value = 0;
        [_blueController addTarget:self action:@selector(refreshLabels:) forControlEvents:UIControlEventValueChanged];
        [_blueController addTarget:self.canvasSettingDelegate action:@selector(achieveNewColor) forControlEvents:UIControlEventValueChanged];
    }
    return _blueController;
}

- (UISlider*)greenController
{
    if (_greenController == nil) {
        _greenController = [[UISlider alloc]init];
        _greenController.maximumValue = 1;
        _greenController.minimumValue = 0;
        _greenController.value = 0;
        [_greenController addTarget:self action:@selector(refreshLabels:) forControlEvents:UIControlEventValueChanged];
        [_greenController addTarget:self.canvasSettingDelegate action:@selector(achieveNewColor) forControlEvents:UIControlEventValueChanged];
    }
    return _greenController;
}

- (UISlider*)alphaController
{
    if (_alphaController == nil) {
        _alphaController = [[UISlider alloc]init];
        _alphaController.maximumValue = 1;
        _alphaController.minimumValue = 0;
        _alphaController.value = 1;
        [_alphaController addTarget:self action:@selector(refreshLabels:) forControlEvents:UIControlEventValueChanged];
        [_alphaController addTarget:self.canvasSettingDelegate action:@selector(achieveNewColor) forControlEvents:UIControlEventValueChanged];
    }
    return _alphaController;
}

//colorLabel setup
- (UILabel*)redLabel
{
    if (_redLabel == nil) {
        _redLabel = [[UILabel alloc]init];
        _redLabel.textColor = [UIColor whiteColor];
        _redLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    _redLabel.text = [NSString stringWithFormat:@"%3.0f",self.redController.value * 255];
    return _redLabel;
}

- (UILabel*)blueLabel
{
    if (_blueLabel == nil) {
        _blueLabel = [[UILabel alloc]init];
        _blueLabel.textColor = [UIColor whiteColor];
        _blueLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    _blueLabel.text = [NSString stringWithFormat:@"%3.0f",self.blueController.value * 255];
    return _blueLabel;
}

- (UILabel*)greenLabel
{
    if (_greenLabel == nil) {
        _greenLabel = [[UILabel alloc]init];
        _greenLabel.textColor = [UIColor whiteColor];
        _greenLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    _greenLabel.text = [NSString stringWithFormat:@"%3.0f",self.greenController.value * 255];
    return _greenLabel;
}

- (UILabel*)alphaLabel
{
    if (_alphaLabel == nil) {
        _alphaLabel = [[UILabel alloc]init];
        _alphaLabel.textColor = [UIColor whiteColor];
        _alphaLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    _alphaLabel.text = [NSString stringWithFormat:@"%3.0f",self.alphaController.value * 255];
    return _alphaLabel;
}
//Color value setup
- (UIColor*)changedColor
{
    if (_changedColor == nil) {
        _changedColor = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:1];
    }
    _changedColor = [UIColor colorWithRed:self.redController.value green:self.greenController.value blue:self.blueController.value alpha:self.alphaController.value];
    return _changedColor;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //initialization
        [self setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"canvasSettingBackground.png"]]];
        //controllers
        self.redController.frame = CGRectMake(65, 19, 200, 80/3);
        self.greenController.frame = CGRectMake(65, 24 + 80/3, 200, 80/3);
        self.blueController.frame = CGRectMake(65, 29 + 160/3, 200, 80/3);
        //labels
        self.redLabel.frame = CGRectMake(270, 19, 50, 80/3);
        self.greenLabel.frame = CGRectMake(270, 24 + 80/3, 50, 80/3);
        self.blueLabel.frame = CGRectMake(270, 29 + 160/3, 50, 80/3);
        
        UILabel* red;
        UILabel* blue;
        UILabel* green;
        red = [[UILabel alloc]initWithFrame:CGRectMake(20, 19, 40, 80/3)];
        green = [[UILabel alloc]initWithFrame:CGRectMake(20, 24 + 80/3, 40, 80/3)];
        blue = [[UILabel alloc]initWithFrame:CGRectMake(20, 29 + 160/3, 40, 80/3)];
        red.backgroundColor = blue.backgroundColor = green.backgroundColor = self.redLabel.backgroundColor;
        red.textColor = blue.textColor = green.textColor = self.redLabel.textColor;
        red.text = @" R";
        green.text = @" G";
        blue.text = @" B";
        
        //add subviews
        [self addSubview:self.redController];
        [self addSubview:self.greenController];
        [self addSubview:self.blueController];
        [self addSubview:self.redLabel];
        [self addSubview:self.greenLabel];
        [self addSubview:self.blueLabel];
        [self addSubview:red];
        [self addSubview:green];
        [self addSubview:blue];
    }
    return self;
}

- (void)refreshLabels:(UISlider*)slider
{
    self.redLabel.text = [NSString stringWithFormat:@"%3.0f",self.redController.value * 255];
    self.blueLabel.text = [NSString stringWithFormat:@"%3.0f",self.blueController.value * 255];
    self.greenLabel.text = [NSString stringWithFormat:@"%3.0f",self.greenController.value * 255];
    self.alphaLabel.text = [NSString stringWithFormat:@"%3.0f",self.alphaController.value * 255];
}

@end
