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
  self.view.backgroundColor = [UIColor blackColor];
  
  self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.navView.backgroundColor = [UIColor greenColor];
  [self.view addSubview:self.navView];
  
  self.feedsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//  self.feedsView.backgroundColor = [UIColor darkGrayColor];
  self.feedsView.clipsToBounds = YES;
  [self.view addSubview:self.feedsView];

  self.tabImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.tabImageView.backgroundColor = [UIColor darkGrayColor];
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
  [self.storiesScrollView setContentSize:CGSizeMake(1136, 248)];
  [self.feedsView addSubview:self.storiesScrollView];

  UIView *story1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 248)];
  story1.backgroundColor = [UIColor colorWithHue:.90 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story1];
  UIView *profPic1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
  profPic1.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.7];
  [story1 addSubview:profPic1];
  
  UIView *story2 = [[UIView alloc] initWithFrame:CGRectMake(142, 0, 140, 248)];
  story2.backgroundColor = [UIColor colorWithHue:.85 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story2];
  UIView *profPic2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
  profPic2.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.7];
  [story2 addSubview:profPic2];

  UIView *story3 = [[UIView alloc] initWithFrame:CGRectMake(284, 0, 140, 248)];
  story3.backgroundColor = [UIColor colorWithHue:.80 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story3];
  UIView *profPic3 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
  profPic3.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.7];
  [story3 addSubview:profPic3];
  
  UIView *story4 = [[UIView alloc] initWithFrame:CGRectMake(426, 0, 140, 248)];
  story4.backgroundColor = [UIColor colorWithHue:.75 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story4];
  UIView *profPic4 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
  profPic4.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.7];
  [story4 addSubview:profPic4];

  UIView *story5 = [[UIView alloc] initWithFrame:CGRectMake(568, 0, 140, 248)];
  story5.backgroundColor = [UIColor colorWithHue:.70 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story5];
  
  UIView *story6 = [[UIView alloc] initWithFrame:CGRectMake(710, 0, 140, 248)];
  story6.backgroundColor = [UIColor colorWithHue:.65 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story6];
  
  UIView *story7 = [[UIView alloc] initWithFrame:CGRectMake(852, 0, 140, 248)];
  story7.backgroundColor = [UIColor colorWithHue:.60 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story7];

  UIView *story8 = [[UIView alloc] initWithFrame:CGRectMake(994, 0, 140, 248)];
  story8.backgroundColor = [UIColor colorWithHue:.55 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story8];
  
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
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    
    if (self.feedsView.center.y < 284) {
      float dampeningMultiplier = ((self.feedsView.center.y - 284) * .4) / (-284) + .1;
      panDistance.y = panDistance.y * dampeningMultiplier;
    }
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
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
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    self.feedsView.center = newCenter;
  } completion:^(BOOL finished) {
    
  }];
}

// Scale the stories
- (void)onPanStories:(UIPanGestureRecognizer *)panGestureRecognizer{
  float maxScale = 2.29;
  float minScale = 1;

  CGPoint panLocation = [panGestureRecognizer locationInView:self.view];
  CGPoint panDistance;
  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
  float newScale;
  CGRect newFrame;

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    newFrame = self.storiesScrollView.frame;
    self.panStart = [panGestureRecognizer locationInView:self.view];
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-320-0) * (maxScale-minScale) + minScale;
    if (velocity.x != 0.0) {
      self.storiesScrolling = TRUE;
    }else{
      self.storiesScrolling = FALSE;
    }

  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
//    if (velocity.y < 0){
      newScale = (panDistance.y - 0)/(-320-0) * (maxScale-minScale) + minScale;
//    }
    NSLog(@"My distance y: %f", panDistance.y);
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-320-0) * (maxScale-minScale) + minScale;
    if (newScale < (maxScale - minScale) / 2) {
      newScale = minScale;
    }else{
      newScale = maxScale;
    }
  }
  if (newScale < .5){ newScale = .5; }
  newFrame.origin.x = 0;
  newFrame.origin.y = self.view.frame.size.height - (248 * newScale);
  newFrame.size.width = self.view.frame.size.width;
  newFrame.size.height = 248 * newScale;
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    if (self.storiesScrolling == FALSE) {
      self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale, newScale);
      self.storiesScrollView.frame = newFrame;
    }
  } completion:^(BOOL finished) {
  //    NSLog(@"Story1 height is %f", story1.frame.size.height);
  }];
}

//implement this method - slideViewGestureRecognizer is the one for sliding the headline up and down.

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  if (gestureRecognizer == self.panStories && otherGestureRecognizer != self.panFeedsView) {
    return YES;
  }
  return NO;
}


@end
