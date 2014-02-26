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
@property (strong, nonatomic) UIImageView *tabImageView;
@property (strong, nonatomic) UILabel *feedHeaderLabel;
@property (assign, nonatomic) CGPoint feedsViewCenter;
@property (assign, nonatomic) CGPoint panStart;

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
  [self.view addSubview:self.navView];
  
  self.feedsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.feedsView.backgroundColor = [UIColor darkGrayColor];
  [self.view addSubview:self.feedsView];

  self.tabImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.tabImageView.backgroundColor = [UIColor lightGrayColor];
  [self.feedsView addSubview:self.tabImageView];

  self.feedHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, 200, 32)];
  self.feedHeaderLabel.text = @"Facebook";
  self.feedHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
  self.feedHeaderLabel.textColor = [UIColor whiteColor];
  self.feedHeaderLabel.shadowColor = [UIColor blackColor];
  self.feedHeaderLabel.shadowOffset = CGSizeMake(0, 1);

  //  self.feedHeaderLabel.backgroundColor = [UIColor ];
  [self.tabImageView addSubview:self.feedHeaderLabel];
  
  self.storiesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 320, self.view.frame.size.width, 248)];
  self.storiesScrollView.backgroundColor = [UIColor grayColor];
  [self.storiesScrollView setContentSize:CGSizeMake(1000, 248)];
  [self.feedsView addSubview:self.storiesScrollView];

  UIView *story1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 148, 248)];
  story1.backgroundColor = [UIColor blueColor];
  [self.storiesScrollView addSubview:story1];

  UIView *story2 = [[UIView alloc] initWithFrame:CGRectMake(152, 0, 148, 248)];
  story2.backgroundColor = [UIColor blueColor];
  [self.storiesScrollView addSubview:story2];

  UIView *story3 = [[UIView alloc] initWithFrame:CGRectMake(304, 0, 148, 248)];
  story3.backgroundColor = [UIColor blueColor];
  [self.storiesScrollView addSubview:story3];
  
  UIView *story4 = [[UIView alloc] initWithFrame:CGRectMake(452, 0, 148, 248)];
  story4.backgroundColor = [UIColor blueColor];
  [self.storiesScrollView addSubview:story4];
  
  UIPanGestureRecognizer *panFeedsView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanFeed:)];
  [self.feedsView addGestureRecognizer:panFeedsView];

  UIPanGestureRecognizer *panStories = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanStories:)];
  [self.storiesScrollView addGestureRecognizer:panStories];
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

- (void)onPanFeed:(UIPanGestureRecognizer *)panGestureRecognizer{
  CGPoint panLocation = [panGestureRecognizer locationInView:self.view];
  CGPoint panDistance;
  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
  CGPoint newCenter;


  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    self.panStart = [panGestureRecognizer locationInView:self.view];
    self.feedsViewCenter = self.feedsView.center;
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    
    if (self.feedsView.center.y < 284) {
      panDistance.y = panDistance.y * .2;
    }

    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
    NSLog(@"StateChanged: %f", newCenter.y);
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
    
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
    if (abs(panDistance.y) > 20){
      if (velocity.y > 0){
        newCenter.y = 808;
      }else{
        newCenter.y = 284;
      }
    }else{
      if (newCenter.y < 568) {
        newCenter.y = 284;
      }else{
        newCenter.y = 808;
      }
    }
  }
  NSLog(@"My velocity is: %f", velocity.y);
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    self.feedsView.center = newCenter;
  } completion:^(BOOL finished) {
    
  }];
}

- (void)onPanStories:(UIPanGestureRecognizer *)panGestureRecognizer{
  CGPoint panLocation = [panGestureRecognizer locationInView:self.view];
  CGPoint panDistance;
  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
  float newScale;
  CGPoint newCenter;
  
  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    self.panStart = [panGestureRecognizer locationInView:self.view];
    panDistance.y = panLocation.y - self.panStart.y;
    //http://stackoverflow.com/questions/345187/math-mapping-numbers
    newScale = (panDistance.y - 0)/(-568-0) * (2.3-1) + 1;
    newCenter.y = 568 - self.storiesScrollView.frame.size.height / 2;
    newCenter.x = self.storiesScrollView.center.x;
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-568-0) * (2.3-.5) + .5;
    newCenter.y = 568 - self.storiesScrollView.frame.size.height / 2;
    newCenter.x = self.storiesScrollView.center.x;
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panDistance.y - 0)/(-568-0) * (2.3-1) + 1;
    newCenter.y = 568 - self.storiesScrollView.frame.size.height / 2;
    newCenter.x = self.storiesScrollView.center.x;
    if (newScale < 1.35) {
      newScale = 1;
    }else{
      newScale = 2.5;
    }
  }
  NSLog(@"My velocity is: %f", velocity.y);
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale * 1.5, newScale * 1.5);
    self.storiesScrollView.center = newCenter;
  } completion:^(BOOL finished) {
    
  }];
  NSLog(@"My y is: %f and my height is: %f", self.storiesScrollView.frame.origin.y, self.storiesScrollView.frame.size.height);
  self.storiesScrollView.center = newCenter;
}

@end
