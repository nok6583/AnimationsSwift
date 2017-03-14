//
//  RDPolyCircle.m
//  CircleToSquareAnimation
//
//  Created by Eric G. DelMar on 2/10/15.
//  Copyright (c) 2015 Eric G. DelMar. All rights reserved.
//

#import "RDPolyCircle.h"

@interface RDPolyCircle ()
@property (strong,nonatomic) UIBezierPath *polyPath;
@property (strong,nonatomic) UIBezierPath *circlePath;
@end

@implementation RDPolyCircle {
    double cpDelta;
    double cosR;
}

-(instancetype)initWithFrame:(CGRect) frame numberOfSides:(NSInteger)sides isPointUp:(BOOL) isUp isInitiallyCircle:(BOOL) isCircle {
    if (self = [super init]) {
        self.frame = frame;
        _isPointUp = isUp;
        _isExpandedPolygon = !isCircle;
        
        double radius = (frame.size.width/2.0);
        cosR = sin(45 * M_PI/180.0) * radius;
        double fractionAlongTangent = 4.0*(sqrt(2)-1)/3.0;
        cpDelta = fractionAlongTangent * radius * sin(45 * M_PI/180.0);
        
        _circlePath = [self createCirclePathForFrame:frame];
        _polyPath = [self createPolygonPathForFrame:frame numberOfSides:sides];
        self.path = (isCircle)? self.circlePath.CGPath : self.polyPath.CGPath;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = [UIColor blueColor].CGColor;
        self.lineWidth = 6.0;
    }
    return self;
}


-(UIBezierPath *)createCirclePathForFrame:(CGRect) frame {
    
    CGPoint ctr = CGPointMake(frame.origin.x + frame.size.width/2.0, frame.origin.y + frame.size.height/2.0);
    
    // create a circle using 4 arcs, with the first one symmetrically spanning the y-axis
    CGPoint leftUpper = CGPointMake(ctr.x - cosR, ctr.y - cosR);
    CGPoint cp1 = CGPointMake(leftUpper.x + cpDelta, leftUpper.y - cpDelta);
    
    CGPoint rightUpper = CGPointMake(ctr.x + cosR, ctr.y - cosR);
    CGPoint cp2 = CGPointMake(rightUpper.x - cpDelta, rightUpper.y - cpDelta);
    CGPoint cp3 = CGPointMake(rightUpper.x + cpDelta, rightUpper.y + cpDelta);
    
    CGPoint rightLower = CGPointMake(ctr.x + cosR, ctr.y + cosR);
    CGPoint cp4 = CGPointMake(rightLower.x + cpDelta, rightLower.y - cpDelta);
    CGPoint cp5 = CGPointMake(rightLower.x - cpDelta, rightLower.y + cpDelta);
    
    CGPoint leftLower = CGPointMake(ctr.x - cosR, ctr.y + cosR);
    CGPoint cp6 = CGPointMake(leftLower.x + cpDelta, leftLower.y + cpDelta);
    CGPoint cp7 = CGPointMake(leftLower.x - cpDelta, leftLower.y - cpDelta);
    CGPoint cp8 = CGPointMake(leftUpper.x - cpDelta, leftUpper.y + cpDelta);
    
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle moveToPoint:leftUpper];
    [circle addCurveToPoint:rightUpper controlPoint1:cp1  controlPoint2:cp2];
    [circle addCurveToPoint:rightLower controlPoint1:cp3 controlPoint2:cp4];
    [circle addCurveToPoint:leftLower controlPoint1:cp5 controlPoint2:cp6];
    [circle addCurveToPoint:leftUpper controlPoint1:cp7 controlPoint2:cp8];
    [circle closePath];
    circle.lineCapStyle = kCGLineCapRound;
    return circle;
}


-(UIBezierPath *)createPolygonPathForFrame:(CGRect) frame numberOfSides:(NSInteger) sides {
    CGPoint leftUpper = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    CGPoint cp1 = CGPointMake(leftUpper.x + cpDelta, leftUpper.y);
    
    CGPoint rightUpper = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
    CGPoint cp2 = CGPointMake(rightUpper.x - cpDelta, rightUpper.y);
    CGPoint cp3 = CGPointMake(rightUpper.x, rightUpper.y + cpDelta);
    
    CGPoint rightLower = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
    CGPoint cp4 = CGPointMake(rightLower.x , rightLower.y - cpDelta);
    CGPoint cp5 = CGPointMake(rightLower.x - cpDelta, rightLower.y);
    
    CGPoint leftLower = CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    CGPoint cp6 = CGPointMake(leftLower.x + cpDelta, leftLower.y);
    CGPoint cp7 = CGPointMake(leftLower.x, leftLower.y - cpDelta);
    CGPoint cp8 = CGPointMake(leftUpper.x, leftUpper.y + cpDelta);
    
    UIBezierPath *square = [UIBezierPath bezierPath];
    [square moveToPoint:leftUpper];
    [square addCurveToPoint:rightUpper controlPoint1:cp1  controlPoint2:cp2];
    [square addCurveToPoint:rightLower controlPoint1:cp3 controlPoint2:cp4];
    [square addCurveToPoint:leftLower controlPoint1:cp5 controlPoint2:cp6];
    [square addCurveToPoint:leftUpper controlPoint1:cp7 controlPoint2:cp8];
    [square closePath];
    square.lineCapStyle = kCGLineCapRound;
    return square;
}




-(void)toggleShape {
    if (self.isExpandedPolygon) {
        [self restore];
    }else{
        
        CABasicAnimation *expansionAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        expansionAnimation.fromValue = (__bridge id)(self.circlePath.CGPath);
        expansionAnimation.toValue = (__bridge id)(self.polyPath.CGPath);
        expansionAnimation.duration = 0.5;
        expansionAnimation.fillMode = kCAFillModeForwards;
        expansionAnimation.removedOnCompletion = NO;
        
        [self addAnimation:expansionAnimation forKey:@"Expansion"];
        self.isExpandedPolygon = YES;
    }
}



-(void)flatten {
    
}




-(void)restore {
    CABasicAnimation *contractionAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    contractionAnimation.fromValue = (__bridge id)(self.polyPath.CGPath);
    contractionAnimation.toValue = (__bridge id)(self.circlePath.CGPath);
    contractionAnimation.duration = 0.5;
    contractionAnimation.fillMode = kCAFillModeForwards;
    contractionAnimation.removedOnCompletion = NO;
    
    [self addAnimation:contractionAnimation forKey:@"Contraction"];
    self.isExpandedPolygon = NO;
}

@end
