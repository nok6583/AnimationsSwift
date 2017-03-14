//
//  RDPolyCircle.h
//  CircleToSquareAnimation
//
//  Created by Eric G. DelMar on 2/10/15.
//  Copyright (c) 2015 Eric G. DelMar. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface RDPolyCircle : CAShapeLayer

@property (nonatomic) BOOL isPointUp;
@property (nonatomic) BOOL isExpandedPolygon;


// creates a shape layer with the supplied frame and number of sides (when in the polygon form)
// if isPointUp is YES, the polygon created upon expantion will have one of its vertices pointing up, otherwise a side is up
// if isInitiallyCircle is YES, the layer starts as a circle, otherwise it starts as the polygon.
-(instancetype)initWithFrame:(CGRect) frame numberOfSides:(NSInteger) sides isPointUp:(BOOL) isUp isInitiallyCircle:(BOOL) isCircle;

// animates the expansion of the circle to the polygon or vice versa if the shape starts out as a polygon
-(void)toggleShape;

// Animates the flattening (the arcs flatten to straight lines) of the circle to the inscribed polygon
-(void)flatten;

// reverses the animation to the previous state
-(void)restore;

@end
