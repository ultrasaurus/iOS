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
@property (assign, nonatomic) float storiesScale;
@property (assign, nonatomic) CGPoint feedsViewCenter;
@property (assign, nonatomic) CGPoint panStart;
@property (assign, nonatomic) CGPoint panOffset;
@property (assign, nonatomic) CGPoint storiesContentOffsetStart;
@property (strong, nonatomic) UIPanGestureRecognizer *panStories;
@property (strong, nonatomic) UIPanGestureRecognizer *panFeedsView;
@property (strong, nonatomic) UIView *story1;

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
  UIImageView *navImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navImage"]];
  [self.navView addSubview:navImageView];
  self.navView.alpha = 0;
  
  self.feedsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//  self.feedsView.backgroundColor = [UIColor darkGrayColor];
  self.feedsView.clipsToBounds = YES;
  [self.view addSubview:self.feedsView];

  self.tabImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  self.tabImageView.backgroundColor = [UIColor blackColor];
  [self.feedsView addSubview:self.tabImageView];
  UIImageView *tabImageBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBackground1"]];
  tabImageBackground.frame = self.tabImageView.frame;
  [self.tabImageView addSubview:tabImageBackground];
  self.tabImageView.layer.cornerRadius = 4;
  self.tabImageView.clipsToBounds = YES;
  
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
  self.storiesScrollView.clipsToBounds = NO;
  [self.storiesScrollView setContentSize:CGSizeMake(1136, 248)];
  [self.feedsView addSubview:self.storiesScrollView];

  self.story1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 248)];
//  self.story1.backgroundColor = [UIColor colorWithHue:.90 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:self.story1];
  self.story1.layer.shadowOffset = CGSizeMake(0, 0);
  self.story1.layer.shadowOpacity = .5;
  self.story1.layer.shadowRadius = 2;

  UIImageView *story1Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story1"]];
  story1Image.frame = self.story1.frame;
  [self.story1 addSubview:story1Image];
  story1Image.layer.cornerRadius = 2;
  story1Image.clipsToBounds = YES;
//  UIView *profPic1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
//  profPic1.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.7];
//  [self.story1 addSubview:profPic1];
  
  UIView *story2 = [[UIView alloc] initWithFrame:CGRectMake(142, 0, 140, 248)];
//  story2.backgroundColor = [UIColor colorWithHue:.85 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story2];
  story2.layer.shadowOffset = self.story1.layer.shadowOffset;
  story2.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story2.layer.shadowRadius = self.story1.layer.shadowRadius;

  UIImageView *story2Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story2"]];
  story2Image.frame = self.story1.frame;
  [story2 addSubview:story2Image];
  story2Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story2Image.clipsToBounds = YES;

  
  UIView *story3 = [[UIView alloc] initWithFrame:CGRectMake(284, 0, 140, 248)];
//  story3.backgroundColor = [UIColor colorWithHue:.80 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story3];
  story3.layer.shadowOffset = self.story1.layer.shadowOffset;
  story3.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story3.layer.shadowRadius = self.story1.layer.shadowRadius;
  
  UIImageView *story3Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story3"]];
  story3Image.frame = self.story1.frame;
  [story3 addSubview:story3Image];
  story3Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story3Image.clipsToBounds = YES;
  
  UIView *story4 = [[UIView alloc] initWithFrame:CGRectMake(426, 0, 140, 248)];
//  story4.backgroundColor = [UIColor colorWithHue:.75 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story4];
  story4.layer.shadowOffset = self.story1.layer.shadowOffset;
  story4.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story4.layer.shadowRadius = self.story1.layer.shadowRadius;

  UIImageView *story4Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story4"]];
  story4Image.frame = self.story1.frame;
  [story4 addSubview:story4Image];
  story4Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story4Image.clipsToBounds = YES;

  UIView *story5 = [[UIView alloc] initWithFrame:CGRectMake(568, 0, 140, 248)];
//  story5.backgroundColor = [UIColor colorWithHue:.70 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story5];
  story5.layer.shadowOffset = self.story1.layer.shadowOffset;
  story5.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story5.layer.shadowRadius = self.story1.layer.shadowRadius;
  
  UIImageView *story5Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story5"]];
  story5Image.frame = self.story1.frame;
  [story5 addSubview:story5Image];
  story5Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story5Image.clipsToBounds = YES;

  UIView *story6 = [[UIView alloc] initWithFrame:CGRectMake(710, 0, 140, 248)];
//  story6.backgroundColor = [UIColor colorWithHue:.65 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story6];
  story6.layer.shadowOffset = self.story1.layer.shadowOffset;
  story6.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story6.layer.shadowRadius = self.story1.layer.shadowRadius;

  UIImageView *story6Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story1"]];
  story6Image.frame = self.story1.frame;
  [story6 addSubview:story6Image];
  story6Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story6Image.clipsToBounds = YES;

  UIView *story7 = [[UIView alloc] initWithFrame:CGRectMake(852, 0, 140, 248)];
//  story7.backgroundColor = [UIColor colorWithHue:.60 saturation:.90 brightness:.50 alpha:1];
  [self.storiesScrollView addSubview:story7];
  story7.layer.shadowOffset = self.story1.layer.shadowOffset;
  story7.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story7.layer.shadowRadius = self.story1.layer.shadowRadius;

  UIImageView *story7Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story2"]];
  story7Image.frame = self.story1.frame;
  [story7 addSubview:story7Image];
  story7Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story7Image.clipsToBounds = YES;


  UIView *story8 = [[UIView alloc] initWithFrame:CGRectMake(994, 0, 140, 248)];
//  story8.backgroundColor = [UIColor colorWithHue:.55 saturation:.90 brightness:.50 aslpha:1];
  story8.layer.shadowOffset = self.story1.layer.shadowOffset;
  story8.layer.shadowOpacity = self.story1.layer.shadowOpacity;
  story8.layer.shadowRadius = self.story1.layer.shadowRadius;

  [self.storiesScrollView addSubview:story8];
  UIImageView *story8Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"story3"]];
  story8Image.frame = self.story1.frame;
  [story8 addSubview:story8Image];
  story8Image.layer.cornerRadius = story1Image.layer.cornerRadius;
  story8Image.clipsToBounds = YES;


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
    panDistance.y = panLocation.y - self.panStart.y;
    
    if (self.feedsView.center.y < 284) {
//      float dampeningMultiplier = ((self.feedsView.center.y - 284) * .4) / (-284) + .1;
      float dampeningMultiplier = .2;
      panDistance.y = panDistance.y * dampeningMultiplier;
    }
    newCenter.y = self.feedsViewCenter.y + panDistance.y;
    newCenter.x = 160;
    
  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;
    
    if (self.feedsView.center.y < 284) {
//      float dampeningMultiplier = ((self.feedsView.center.y - 284) * .4) / (-284) + .1;
      float dampeningMultiplier = .2;
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
  float navViewScale = .96 + (1 - .96) * ((newCenter.y - self.view.center.y) / self.view.frame.size.height);
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
    self.feedsView.center = newCenter;
    self.navView.alpha = (newCenter.y - self.view.center.y + 200) / self.view.frame.size.height;
    self.navView.transform = CGAffineTransformMakeScale(navViewScale, navViewScale);
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
  CGPoint newScrollOffset;
  float newScale;
  CGRect newFrame;

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
    newFrame = self.storiesScrollView.frame;
    self.storiesContentOffsetStart = CGPointMake((panLocation.x - self.storiesScrollView.contentOffset.x)/self.storiesScrollView.contentSize.width, self.storiesScrollView.contentOffset.y);
    NSLog(@"My self.storiesContentOffsetStart: %f", self.storiesContentOffsetStart.x);
    NSLog(@"My panLocation.x: %f", panLocation.x);
    NSLog(@"My self.storiesScrollView.contentSize.width: %f", self.storiesScrollView.contentSize.width);
    self.panStart = [panGestureRecognizer locationInView:self.view];
    self.panOffset = CGPointMake(self.panStart.x, self.panStart.y - self.storiesScrollView.frame.origin.y);
    panDistance.y = panLocation.y - self.panStart.y;
    newScale = (panLocation.y - self.panOffset.y - 320)/(0-320) * (maxScale-minScale) + minScale;
    if (velocity.y == 0.0) {
      self.storiesScrolling = TRUE;
    }else{
      self.storiesScrolling = FALSE;
    }
    /////////////////////
    if (newScale < .5){ newScale = .5; }
    newFrame.origin.x = 0;
    newFrame.origin.y = self.view.frame.size.height - (248 * newScale);
    newFrame.size.width = self.view.frame.size.width;
    newFrame.size.height = 248 * newScale;
    newScrollOffset = CGPointMake(self.storiesContentOffsetStart.x * self.storiesScrollView.contentSize.width - panLocation.x, self.storiesContentOffsetStart.y);
    
    if (self.storiesScrolling == FALSE) {
      self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale, newScale);
      self.storiesScrollView.frame = newFrame;
      // add or subtract the number of pixels offset by the growth since the last change
//      self.storiesScrollView.contentOffset = newScrollOffset;
    }

  }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
    panDistance.y = panLocation.y - self.panStart.y;

    newScale = (panLocation.y - self.panOffset.y - 320)/(0-320) * (maxScale-minScale) + minScale;
    /////////////////////
    if (newScale < .5){ newScale = .5; }
    newFrame.origin.x = 0;
    newFrame.origin.y = self.view.frame.size.height - (248 * newScale);
    newFrame.size.width = self.view.frame.size.width;
    newFrame.size.height = 248 * newScale;
    newScrollOffset = CGPointMake(self.storiesContentOffsetStart.x * self.storiesScrollView.contentSize.width - panLocation.x, self.storiesContentOffsetStart.y);
    float tabViewScale = .96 + (1 - .96) * ((newFrame.origin.y) / 320);
    if (self.storiesScrolling == FALSE) {
      self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale, newScale);
      self.storiesScrollView.frame = newFrame;
      self.tabImageView.alpha = newFrame.origin.y / 320;
      self.tabImageView.transform = CGAffineTransformMakeScale(tabViewScale, tabViewScale);

      // add or subtract the number of pixels offset by the growth since the last change
//      self.storiesScrollView.contentOffset = newScrollOffset;
    }

  }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
    panDistance.y = panLocation.y - self.panStart.y;
//    self.storiesContentOffset = self.story1.frame.size.width - 140;
    newScale = (panLocation.y - self.panOffset.y - 320)/(0-320) * (maxScale-minScale) + minScale;
    if (newScale < ((maxScale - minScale) / 2) + minScale) {
      newScale = minScale;
    }else{
      newScale = maxScale;
    }
    /////////////////////
    if (newScale < .5){ newScale = .5; }
    newFrame.origin.x = 0;
    newFrame.origin.y = self.view.frame.size.height - (248 * newScale);
    newFrame.size.width = self.view.frame.size.width;
    newFrame.size.height = 248 * newScale;
    newScrollOffset = CGPointMake(self.storiesContentOffsetStart.x * self.storiesScrollView.contentSize.width - panLocation.x, self.storiesContentOffsetStart.y);
    float tabViewScale = .96 + (1 - .96) * ((newFrame.origin.y) / 320);

    if (self.storiesScrolling == FALSE) {
      [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:0 animations:^{
          self.storiesScrollView.transform = CGAffineTransformMakeScale(newScale, newScale);
          // add or subtract the number of pixels offset by the growth since the last change
          // self.storiesScrollView.contentOffset = newScrollOffset;
        self.storiesScrollView.frame = newFrame;
        self.tabImageView.alpha = newFrame.origin.y / 350;
        self.tabImageView.transform = CGAffineTransformMakeScale(tabViewScale, tabViewScale);

      } completion:^(BOOL finished) {}];
    }
  }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  if (gestureRecognizer == self.panStories && otherGestureRecognizer != self.panFeedsView) {
    return YES;
  }
  return NO;
}



@end
