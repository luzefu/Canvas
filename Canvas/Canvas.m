//
//  Canvas.m
//  Drawer
//
//  Created by 陆 泽夫 on 12-4-4.
//  Copyright (c) 2012年 SES. All rights reserved.
//

#import "Canvas.h"

@interface Canvas ()

@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) CGPoint previousPointOne;
@property (nonatomic) CGPoint previousPointTwo;
@property (nonatomic) CGPoint cdp1;
@property (nonatomic) CGPoint cdp2;
@property (nonatomic) CGPoint p1p1;
@property (nonatomic) CGPoint p1p2;
@property (nonatomic) CGPoint p2p1;
@property (nonatomic) CGPoint p2p2;

@property (nonatomic) CGFloat veloVector;
@property (nonatomic) BOOL isVectorXNegative;

@property (nonatomic) BOOL isViewTouched;

@end

@implementation Canvas
//gesture recognization
@synthesize gestureRecognizer = _gestureRecognizer;
@synthesize isViewTouched = _isViewTouched;
//need to be discuessed
@synthesize unchangableImage = _unchangableImage;
//points
@synthesize currentPoint = _currentPoint;
@synthesize previousPointOne = _previousPointOne;
@synthesize previousPointTwo = _previousPointTwo;
@synthesize cdp1 = _cdp1;
@synthesize cdp2 = _cdp2;
@synthesize p1p1 = _p1p1;
@synthesize p1p2 = _p1p2;
@synthesize p2p1 = _p2p1;
@synthesize p2p2 = _p2p2;
//speed vectors
@synthesize veloVector = _veloVector;
@synthesize isVectorXNegative = _isVectorXNegative;
//variables
@synthesize colorForStroke = _colorForStroke;
@synthesize radiusForStroke = _radiusForStroke;

- (UIPanGestureRecognizer*)gestureRecognizer
{
    if (_gestureRecognizer == nil) {
        _gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    }
    return _gestureRecognizer;
}

- (UIImageView*)unchangableImage
{
    if (_unchangableImage == nil) {
        _unchangableImage = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _unchangableImage;
}

- (UIColor *)colorForStroke
{
    if (_colorForStroke == nil) {
        _colorForStroke = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:1];
    }
    return _colorForStroke;
}

- (CGFloat)radiusForStroke
{
    if (_radiusForStroke == 0) {
        _radiusForStroke = 2;
    }
    return _radiusForStroke;
}

- (void) setup{
    self.contentMode = UIViewContentModeRedraw;
    [self addGestureRecognizer:self.gestureRecognizer];
}

- (void) awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(CGPoint) midPointWithPoint1:(CGPoint) p1 Point2:(CGPoint) p2{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (CGPoint)getDerivePointOneWithPoint:(CGPoint)pt
{
    if (self.veloVector > 0) {
        if (self.isVectorXNegative == NO) {
            CGPoint derivedpt = CGPointMake(pt.x + self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y - self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }else{
            CGPoint derivedpt = CGPointMake(pt.x - self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y + self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }
    }
    if (self.veloVector < 0) {
        if (self.isVectorXNegative == YES) {
            CGPoint derivedpt = CGPointMake(pt.x + self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y - self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }else{
            CGPoint derivedpt = CGPointMake(pt.x - self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y + self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }
    }
    if (self.veloVector == 0) {
        if (self.isVectorXNegative == NO) {
            return CGPointMake(pt.x, pt.y - self.radiusForStroke / 2);
        }else{
            return CGPointMake(pt.x, pt.y + self.radiusForStroke / 2);
        }
    }
}

- (CGPoint)getDerivePointTwoWithPoint:(CGPoint)pt
{
    if (self.veloVector > 0) {
        if (self.isVectorXNegative == NO) {
            CGPoint derivedpt = CGPointMake(pt.x - self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y + self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }else{
            CGPoint derivedpt = CGPointMake(pt.x + self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y - self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }
    }
    if (self.veloVector < 0) {
        if (self.isVectorXNegative == YES) {
            CGPoint derivedpt = CGPointMake(pt.x - self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y + self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }else{
            CGPoint derivedpt = CGPointMake(pt.x + self.radiusForStroke / (2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))), pt.y - self.radiusForStroke / (self.veloVector * 2 * sqrt(1 + 1 / (self.veloVector * self.veloVector))));
            return derivedpt;
        }
    }
    if (self.veloVector == 0) {
        if (self.isVectorXNegative == NO) {
            return CGPointMake(pt.x, pt.y + self.radiusForStroke / 2);
        }else{
            return CGPointMake(pt.x, pt.y - self.radiusForStroke / 2);
        }
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.numberOfTouches == 1) {
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            self.previousPointTwo = self.previousPointOne = self.currentPoint = [gesture locationInView:self];
            self.p2p1 = self.p1p1 = self.cdp1 = [self getDerivePointOneWithPoint:self.currentPoint];
            self.p2p2 = self.p1p2 = self.cdp2 = [self getDerivePointTwoWithPoint:self.currentPoint];
            
            self.isViewTouched = NO;
        }
        if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {
            
            CGPoint velocity = [gesture velocityInView:self];
            self.veloVector = velocity.y/velocity.x;
            if (velocity.x >= 0) {
                self.isVectorXNegative = NO;
            }else
                self.isVectorXNegative = YES;
            CGFloat v = sqrt(velocity.x*velocity.x + velocity.y * velocity.y);
            
#define MIN_RADIUS 3
#define MAX_RADIUS 10
#define TRIGGER_SPEED 500
#define LIMIT_SPEED 3300
            
            if (v <= TRIGGER_SPEED) {
                self.radiusForStroke = MIN_RADIUS;
            }else if(v >= LIMIT_SPEED){
                self.radiusForStroke = MAX_RADIUS;
            }else{
                self.radiusForStroke = (v - TRIGGER_SPEED)/LIMIT_SPEED * (MAX_RADIUS - MIN_RADIUS) + MIN_RADIUS;
            }
            
            CGPoint location = [gesture locationInView:self];
            
            self.previousPointTwo = self.previousPointOne;
            self.previousPointOne = self.currentPoint;
            self.currentPoint = CGPointMake(location.x, location.y);
            
            self.p2p1 = self.p1p1;
            self.p1p1 = self.cdp1;
            self.cdp1 = [self getDerivePointOneWithPoint:self.currentPoint];
            self.p2p2 = self.p1p2;
            self.p1p2 = self.cdp2;
            self.cdp2 = [self getDerivePointTwoWithPoint:self.currentPoint];
            
            self.isViewTouched = YES;
            
            [self setNeedsDisplay];
        }
    }
}

- (CGMutablePathRef)createNewPathwithPreviousPointOne:(CGPoint)pt1 PreviousPointTwo:(CGPoint)pt2 CurrentPoint:(CGPoint)cpt
{
    CGMutablePathRef newPath = CGPathCreateMutable();
    
    CGPoint mid1 = [self midPointWithPoint1:pt1 Point2:pt2];  
    CGPoint mid2 = [self midPointWithPoint1:cpt Point2:pt1];
    
    CGPathMoveToPoint(newPath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(newPath, NULL, pt1.x, pt1.y, mid2.x, mid2.y);
    return newPath;
}

- (void)drawRect:(CGRect)rect
{
    [self addSubview:self.unchangableImage];
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    [self.unchangableImage.image drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    /*---------SETTING UP ----------*/
    //CGContextSetLineWidth(context, self.radiusForStroke);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetFlatness(context, 0.7);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [self.colorForStroke setStroke];
    [self.colorForStroke setFill];
    
    /*---------START TO DRAW ----------*/
    if (self.isViewTouched == YES) {
        
        //DrawTheRect
        CGMutablePathRef rectPath = CGPathCreateMutable();
        CGPathMoveToPoint(rectPath, NULL, [self midPointWithPoint1:self.cdp1 Point2:self.p1p1].x, [self midPointWithPoint1:self.cdp1 Point2:self.p1p1].y);
        CGPathAddLineToPoint(rectPath, NULL, [self midPointWithPoint1:self.p1p1 Point2:self.p2p1].x, [self midPointWithPoint1:self.p1p1 Point2:self.p2p1].y);
        CGPathAddLineToPoint(rectPath, NULL, [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].x, [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].y);
        CGPathAddLineToPoint(rectPath, NULL, [self midPointWithPoint1:self.p1p2 Point2:self.cdp2].x, [self midPointWithPoint1:self.p1p2 Point2:self.cdp2].y);
        [self.colorForStroke setFill];
        //[[UIColor redColor] setStroke];
        CGContextAddPath(context, rectPath);
        CGContextFillPath(context);
        
        
        //Draw end & begin curves
        CGMutablePathRef curvePath = CGPathCreateMutable();
        
        CGPathAddArc(curvePath, NULL, ([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].x + [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].x) / 2, ([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].y + [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].y) / 2,  sqrt(([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].x - [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].x)* ([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].x - [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].x)+([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].y - [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].y)*([self midPointWithPoint1:self.cdp1 Point2:self.p1p1].y - [self midPointWithPoint1:self.cdp2 Point2:self.p1p2].y)) / 2, 0, 2*M_PI, NO);
        
        CGPathAddArc(curvePath, NULL, ([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].x + [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].x) / 2, ([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].y + [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].y) / 2, sqrt(([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].x - [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].x)* ([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].x - [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].x)+([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].y - [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].y)*([self midPointWithPoint1:self.p1p1 Point2:self.p2p1].y - [self midPointWithPoint1:self.p1p2 Point2:self.p2p2].y)) / 2, 0, 2*M_PI, NO);
        
        CGContextAddPath(context, curvePath);
        //CGContextFillPath(context);
        
        //Draw bezier path
        CGMutablePathRef newPath = CGPathCreateMutable();
        CGPathAddPath(newPath, NULL, [self createNewPathwithPreviousPointOne:self.p1p2 PreviousPointTwo:self.cdp2 CurrentPoint:self.p2p2]);
        CGPathAddPath(newPath, NULL, [self createNewPathwithPreviousPointOne:self.p1p1 PreviousPointTwo:self.p2p1 CurrentPoint:self.cdp1]);
        CGContextAddPath(context, newPath);
        [[UIColor blueColor]setStroke];
        CGContextFillPath(context);
    }
    
    self.unchangableImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}


@end

