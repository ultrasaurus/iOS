//
//  MainViewController.m
//  Week 3 Homework
//
//  Created by Aaron Carambula on 2/25/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) UIView *feedsView;
@property (strong, nonatomic) UIScrollView *storiesScrollView;
@property (strong, nonatomic) UIView *tabImageView;
@property (strong, nonatomic) UILabel *feedHeaderLabel;
@property (assign, nonatomic) BOOL storiesScrolling;
@property (assign, nonatomic) CGPoint feedsViewCenter;
@property (assign, nonatomic) CGPoint panStart;
@property (strong, nonatomic) UIPanGestureRecognizer *panStories;
@property (strong, nonatomic) UIPanGestureRecognizer *panFeedsView;

- (void)onPanFeed:(UIPanGestureRecognizer *)panGestureRecognizer;
- (void)onPanStories:(UIPanGestureRecognizer *)panGestureRecognizer;

@end

@implementation MainViewController

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
  [[UIApplication sharedApplication] setStatusBarHidden:YES
                                          withAnimation:UIStatusBarAnimationFade];

  self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.navView.backgroundColor = [UIColor darkGrayColor];
  [self.view addSubview:self.navView];
  
  self.feedsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//  self.feedsView.backgroundColor = [UIColor darkGrayColor];
  self.feedsView.clipsToBounds = YES;
  [self.view addSubview:self.feedsView];

  self.tabImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.tabImageView.backgroundColor = [UIColor blueColor];
  [self.feedsView addSubview:self.tabImageView];

  self.feedHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, 200, 30)];
  self.feedHeaderLabel.text = @"Facebook";
  self.feedHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
  self.feedHeaderLabel.textColor = [UIColor whiteColor];
  self.feedHeaderLabel.shadowColor = [UIColor blackColor];
  self.feedHeaderLabel.shadowOffset = CGSizeMake(0, 1);

  //  self.feedHeaderLabel.backgroundColor = [UIColor ];
  [self.tabImageView addSubview:self.feedHeaderLabel];
  
  self.storiesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 320, self.view.frame.size.width, 248)];
//  self.storiesScrollView.backgroundColor = [UIColor grayColor];
  [self.storiesScrollView setContentSize:CGSizeMake(4000, 248)];
  [self.feedsView addSubview:self.storiesScrollView];

  UIView *story1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 148, 248)];
  story1.backgroundColor = [UIColor whiteColor];
  [self.storiesScrollView addSubview:story1];

  UIView *story2 = [[UIView alloc] initWithFrame:CGRectMake(152, 0, 148, 248)];
  story2.backgroundColor = [UIColor whiteColor];
  [self.storiesScrollView addSubview:story2];

  UIView *story3 = [[UIView alloc] initWithFrame:CGRectMake(304, 0, 148, 248)];
  story3.backgroundColor = [UIColor whiteColor];
  [self.storiesScrollView addSubview:story3];
  
  UIView *story4 = [[UIView alloc] initWithFrame:CGRectMake(452, 0, 148, 248)];
  story4.backgroundColor = [UIColor whiteColor];
  [self.storiesScrollView addSubview:story4];
  
  // Drag the main feed container up and down
  self.panFeedsView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanFeed:)];
//  [self.feedsView addGestureRecognizer:self.panFeedsView];
  [self.tabImageView addGestureRecognizer:self.panFeedsView];

  // Drag scale the stories scroll view
  self.panStories = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanStories:)];
  [self.storiesScrollView addGestureRecognizer:self.panStories];
  self.panStories.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

#pragma mark- Gesture Methods

// Drag the main feed container up and down
- (void)onPanFeed:(UIPanGestureRecognizer *)panGestureRecognizer{
  CGPoint panLocation = [panGestureRecognizer locationInView:self.view];
  CGPoint panDistance;
  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
  CGPoint newCenter;


  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    self.panStart = [panGestureRecognizer locationInView:self.view];
    self.feedsViewCenter = self.feedsView.center;
  //  newCenter.y = self.feedsViewCenter.y + panDistance.y;
  //  newCenter.x = 160;
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    
    if (self.feedsView.center.y < 284) {
      float dampeningMultiplier = ((self.feedsView.center.y - 284) * .4) / (-284) + .1;
//      NSLog(@"MY DAMPENING MULTIPLIER : %f", dampeningMultiplier);
      panDistance.y = panDistance.y * dampeningMultiplier;
    }
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
//    NSLog(@"StateChanged: %f", newCenter.y);
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
    
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
    if (abs(panDistance.y) > 20){
      if (velocity.y > 0){
        newCenter.y = 808;
      }else{
        newCenter.y = self.view.frame.size.height/2;
      }
    }else{
      if (newCenter.y < self.view.frame.size.height) {
        newCenter.y = self.view.frame.size.height/2;
      }else{
        newCenter.y = 808;
      }
    }
  }
//  NSLog(@"My velocity is: %f", velocity.y);
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    self.feedsView.center = newCenter;
  } completion:^(BOOL finished) {
    
  }];
}

// Scale 
- (void)onPanStories:(UIPanGestureRecognizer *)panGestureRecognizer{
  CGPoint panLocation = [panGestureRecognizer locationInView:self.view];
  CGPoint panDistance;
  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
  float newScale;
  CGPoint newCenter;
  CGRect newFrame;

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    newFrame = self.storiesScrollView.frame;
    self.panStart = [panGestureRecognizer locationInView:self.view];
    panDistance.y = panLocation.y - self.panStart.y;
    //http://stackoverflow.com/questions/345187/math-mapping-numbers
    newScale = (panDistance.y - 0)/(-self.view.frame.size.height-0) * (2.3-1) + 1;
//    newCenter.y = self.view.frame.size.height - self.storiesScrollView.frame.size.height / 2;
//    newCenter.x = self.storiesScrollView.center.x;
    NSLog(@"On begin the velocity is %f", velocity.x);
    if (velocity.x != 0.0) {
      self.storiesScrolling = TRUE;
    }else{ self.storiesScrolling = FALSE; }
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-self.view.frame.size.height-0) * (2.3-.5) + .5;
    newCenter.y = self.view.frame.size.height - self.storiesScrollView.frame.size.height / 2;
    newCenter.x = self.storiesScrollView.center.x;
    NSLog(@"MY WIDTH: %f", self.storiesScrollView.frame.size.width);
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-self.view.frame.size.height-0) * (2.3-1) + 1;
    newCenter.y = self.view.frame.size.height - self.storiesScrollView.frame.size.height / 2;
    newCenter.x = self.storiesScrollView.center.x;
    if (newScale < 1.35) {
      newScale = 1;
    }else{
      newScale = 2.5;
    }
  }
//  NSLog(@"My velocity is: %f", velocity.y);
  newFrame.origin.x = 0;
  newFrame.origin.y = self.view.frame.size.height - (248 * newScale);
  newFrame.size.width = self.view.frame.size.width;
  newFrame.size.height = 248 * newScale;
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    if (self.storiesScrolling == FALSE) {
      self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale, newScale);
//      self.storiesScrollView.center = newCenter;
      self.storiesScrollView.frame = newFrame;
    }
  } completion:^(BOOL finished) {
    
  }];
//  NSLog(@"My y is: %f and my height is: %f", self.storiesScrollView.frame.origin.y, self.storiesScrollView.frame.size.height);
//  self.storiesScrollView.center = newCenter;
}

//implement this method - slideViewGestureRecognizer is the one for sliding the headline up and down.

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  if (gestureRecognizer == self.panStories && otherGestureRecognizer != self.panFeedsView) {
    return YES;
  }
  return NO;
}


@end
