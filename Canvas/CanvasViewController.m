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
//color setting for canvas
@property (nonatomic) float red;
@property (nonatomic) float green;
@property (nonatomic) float blue;
@property (nonatomic) float transparency;

@end

@implementation CanvasViewController

@synthesize canvasArray = _canvasArray;
//color setting for canvas
@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;
@synthesize transparency = _transparency;

- (NSArray*)canvasArray
{
    if (_canvasArray == nil) {
        _canvasArray = [[NSArray alloc]init];
        for (int i = 0; i < 10; i++) {
            Canvas *newCanvas = [[Canvas alloc]initWithFrame:self.view.bounds];
            newCanvas.tag = i + 1;
            _canvasArray = [_canvasArray arrayByAddingObject:newCanvas];
        }
    }
    return _canvasArray;
}

- (void)refreshSettings
{
    //refresh color data
    self.red = 1;
    self.green = 1;
    self.blue = 1;
    self.transparency = 1;
    //test
    [[self.canvasArray objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
    [[self.canvasArray objectAtIndex:2] setBackgroundColor:[UIColor redColor]];
    [[self.canvasArray objectAtIndex:3] setBackgroundColor:[UIColor blackColor]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end

