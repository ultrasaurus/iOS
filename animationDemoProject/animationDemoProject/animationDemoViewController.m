//
//  animationDemoViewController.m
//  animationDemoProject
//
//  Created by Aaron Carambula on 2/25/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "animationDemoViewController.h"

@interface animationDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *myBox;
@property (assign, nonatomic) CGAffineTransform myBoxRotateStart;
- (IBAction)onGoPress:(id)sender;

- (void)onBoxRotation:(UIRotationGestureRecognizer *) boxRotation;

@end

@implementation animationDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  UITapGestureRecognizer *boxTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGoPress:)];
  boxTapGestureRecognizer.numberOfTapsRequired = 2;
  [self.myBox addGestureRecognizer:boxTapGestureRecognizer];
  
  UIRotationGestureRecognizer *boxRotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onBoxRotation:)];
  [self.myBox addGestureRecognizer:boxRotation];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGoPress:(id)sender {

  CGRect newFrame = self.myBox.frame;
  newFrame.origin = CGPointMake(newFrame.origin.x + 100, newFrame.origin.y);
  if (self.myBox.frame.origin.x > 200){
    newFrame.origin = CGPointMake(newFrame.origin.x - 300, newFrame.origin.y);
  }

  [UIView animateWithDuration:.25 animations:^{
    self.myBox.backgroundColor = [UIColor blueColor];
    self.myBox.frame = newFrame;

  }];
  
  [UIView animateWithDuration:5 animations:^{
//    self.myBox.alpha = 0;
  }];
  
}
- (void)onBoxRotation:(UIRotationGestureRecognizer *) boxRotation{
  NSLog(@"Rotation: %f", boxRotation.rotation);
  
  if (boxRotation.state == UIGestureRecognizerStateBegan){
    NSLog(@"Began");
    self.myBoxRotateStart = self.myBox.transform;
  }else if (boxRotation.state == UIGestureRecognizerStateChanged){
    self.myBox.transform = CGAffineTransformRotate(self.myBoxRotateStart, boxRotation.rotation);
  }

}

@end
