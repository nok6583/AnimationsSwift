//
//  ViewController.m
//  CircleToSquareAnimation
//
//  Created by Eric G. DelMar on 2/10/15.
//  Copyright (c) 2015 Eric G. DelMar. All rights reserved.
//

#import "ViewController.h"
#import "RDPolyCircle.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *circleView; // a plain UIView 150 x 150 centered in the superview
@property (strong,nonatomic) RDPolyCircle *shapeLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // currently isPointUp and numberOfSides are not implemented (the shape created has numberOfSides=4 and isPointUp=NO)
    // isInitiallyCircle is implemented
    self.shapeLayer = [[RDPolyCircle alloc] initWithFrame:self.circleView.bounds numberOfSides: 4 isPointUp:NO isInitiallyCircle:YES];
    [self.circleView.layer addSublayer:self.shapeLayer];
}


- (IBAction)toggleShape:(UIButton *)sender {
    [self.shapeLayer toggleShape];
}

@end
