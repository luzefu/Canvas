//
//  CanvasViewController.m
//  Canvas
//
//  Created by 陆 泽夫 on 12-4-12.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import "CanvasViewController.h"
@interface CanvasViewController ()

@property (nonatomic,strong) NSArray* canvasArray;
@property (nonatomic,strong) Canvas* currentCanvas;
@property (nonatomic,strong) CanvasSetting* canvasSetting;
@property (nonatomic) BOOL canvasSettingAppeared;
//color setting for canvas
@property (nonatomic,strong) UIColor* colorForCanvas;
//important pointers
@property (nonatomic) float currentCanvasIndex;

@end


@implementation CanvasViewController

@synthesize canvasArray = _canvasArray;
@synthesize currentCanvas = _currentCanvas;
@synthesize canvasSetting = _canvasSetting;
@synthesize canvasSettingAppeared = _canvasSettingAppeared;
//color setting for canvas
@synthesize colorForCanvas = _colorForCanvas;
//important pointers
@synthesize currentCanvasIndex = _currentCanvasIndex;

- (NSArray*)canvasArray
{
    if (_canvasArray == nil) {
        _canvasArray = [[NSArray alloc]init];
        for (int i = 0; i < 10; i++) {
            Canvas *newCanvas = [[Canvas alloc]initWithFrame:self.view.bounds];
            newCanvas.backgroundColor = [UIColor whiteColor];
            newCanvas.tag = i + 1;
            _canvasArray = [_canvasArray arrayByAddingObject:newCanvas];
        }
    }
    return _canvasArray;
}

- (Canvas*)currentCanvas
{
    if (_currentCanvas == nil) {
        _currentCanvas = [[Canvas alloc]initWithFrame:self.view.bounds];
    }
    _currentCanvas = [self.canvasArray objectAtIndex:self.currentCanvasIndex];
    _currentCanvas.colorForStroke = self.colorForCanvas;
    _currentCanvas.delegate = self;
    return _currentCanvas;
}

- (CanvasSetting*)canvasSetting
{
    if (_canvasSetting == nil) {
        _canvasSetting = [[CanvasSetting alloc]initWithFrame:CGRectMake(64, 0, 896, 128)];
        CGColorRef color = [self.colorForCanvas CGColor];
        int numComponents = CGColorGetNumberOfComponents(color);
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color);
            _canvasSetting.redController.value = components[0];
            _canvasSetting.greenController.value = components[1];
            _canvasSetting.blueController.value = components[2];
            _canvasSetting.alphaController.value = components[3];
        }
    }
    return _canvasSetting;
}

- (UIColor*)colorForCanvas
{
    if (_colorForCanvas == nil) {
        _colorForCanvas = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }
    return _colorForCanvas;
}


/*-------------------METHODS---------------------*/
//canvassetting delegate
- (void)achieveNewColor
{
    self.colorForCanvas = self.canvasSetting.changedColor;
    if (self.currentCanvasIndex < self.canvasArray.count - 1) {
        self.currentCanvasIndex -= 1;
    }else{
        self.currentCanvasIndex += self.canvasArray.count - 1;
    }
    
    self.currentCanvas.colorForStroke = self.colorForCanvas;
    
    if (self.currentCanvasIndex < self.canvasArray.count - 1) {
        self.currentCanvasIndex += 1;
    }else{
        self.currentCanvasIndex -= self.canvasArray.count - 1;
    }
}

//canvas delegate
- (void)letSettingAppear
{
    if (self.canvasSettingAppeared == NO) {
        [self.view addSubview:self.canvasSetting];
        self.canvasSettingAppeared = YES;
    }
}
- (void)letSettingDisappear
{
    if (self.canvasSettingAppeared == YES) {
        [self.canvasSetting removeFromSuperview];
        self.canvasSettingAppeared = NO;
    }
}

- (void)createLeftThumbnailWith:(Canvas*)canvas
{
    UIImageView* newImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height / 4, self.view.bounds.size.width / 4, self.view.bounds.size.height / 2)];
    newImageView.backgroundColor = [UIColor whiteColor];
    newImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.currentCanvas.unchangableImage.image.CGImage, CGRectMake(0,0,0.5*self.currentCanvas.unchangableImage.image.size.width,self.currentCanvas.unchangableImage.image.size.height))];
    [self.view addSubview:newImageView];
}

- (void)createRightThumbnailWith:(Canvas*)canvas
{
    UIImageView* newImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 4 * 3, self.view.bounds.size.height / 4, self.view.bounds.size.width / 4, self.view.bounds.size.height / 2)];
    newImageView.backgroundColor = [UIColor whiteColor];
    newImageView.image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.currentCanvas.unchangableImage.image.CGImage, CGRectMake(0.5*self.currentCanvas.unchangableImage.image.size.width,0,0.5*self.currentCanvas.unchangableImage.image.size.width,self.currentCanvas.unchangableImage.image.size.height))];
    [self.view addSubview:newImageView];
}

- (IBAction)testButtonPressed {
    if (self.currentCanvasIndex > 0) {
        NSMutableArray* buffer = [[NSMutableArray alloc]initWithArray:self.canvasArray];
        [buffer replaceObjectAtIndex:self.currentCanvasIndex - 1 withObject:self.currentCanvas];
        self.canvasArray = buffer.copy;
    }else{
        NSMutableArray* buffer = [[NSMutableArray alloc]initWithArray:self.canvasArray];
        [buffer replaceObjectAtIndex:self.currentCanvasIndex + self.canvasArray.count - 1 withObject:self.currentCanvas];
        self.canvasArray = buffer.copy;
    }
    
    [self.view addSubview:self.currentCanvas];
    self.currentCanvas.frame = CGRectMake(self.view.bounds.size.width / 8, self.view.bounds.size.height / 8, self.view.bounds.size.width / 8 * 6, self.view.bounds.size.height / 8 * 6);
    self.currentCanvas.colorForStroke = self.colorForCanvas;
    
    //[self createLeftThumbnailWith:self.currentCanvas];
    //[self createRightThumbnailWith:self.currentCanvas];
    
    if (self.currentCanvasIndex < self.canvasArray.count - 1) {
        self.currentCanvasIndex += 1;
    }else{
        self.currentCanvasIndex -= self.canvasArray.count - 1;
    }
}

- (void)viewDidLoad
{
    self.canvasSetting.canvasSettingDelegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end

