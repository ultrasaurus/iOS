//
//  SectionsViewController.m
//  Week 3 Homework
//
//  Created by Aaron Carambula on 3/5/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "SectionsViewController.h"
#import "MainViewController.h"

@interface SectionsViewController ()
@property (strong, nonatomic) UIView *sectionFacebookContainer;
@property (strong, nonatomic) UIView *sectionFacebook;
@property (strong, nonatomic) UIView *sectionNewsContainer;
@property (strong, nonatomic) UIView *sectionNews;
@property (strong, nonatomic) UIView *sectionOpenSlot;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UIAttachmentBehavior *cardSwing;
@property (strong, nonatomic) UIGestureRecognizer *dragCard;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapCard;
@property (strong, nonatomic) UISnapBehavior *snap;
@property (assign, nonatomic) CGPoint dragOffset;
@property (assign, nonatomic) const int kThreshold;

- (void)onDoneButton:(id)selector;
- (void)onDragCard:(UIPanGestureRecognizer *)drag;
- (void)onDoubleTapCard:(UITapGestureRecognizer *)tap;
- (void)makeRoom;
- (void)unMakeRoom;

@end

@implementation SectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.kThreshold = 350;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  UIImageView *navImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CoverPhoto"]];
  navImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
  navImageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:navImageView];

  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButton:)];
  self.navigationItem.rightBarButtonItem = doneButton;
  self.view.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.5];

  self.animator = [[UIDynamicAnimator alloc] init];
  self.gravity = [[UIGravityBehavior alloc] init];

  ////////////
  // SECTIONS
  // SECTION OPEN SLOT
  self.sectionOpenSlot = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 70, 80, 140, 248)];
  self.sectionOpenSlot.layer.borderColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.75].CGColor;
  self.sectionOpenSlot.layer.borderWidth = 1.0f;
  self.sectionOpenSlot.layer.cornerRadius = 2;
  UILabel *sectionOpenSlotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sectionOpenSlot.frame.size.height / 2 - 18, self.sectionOpenSlot.frame.size.width, 18)];
  sectionOpenSlotLabel.text = @"Drag Here";
  sectionOpenSlotLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.9];
  sectionOpenSlotLabel.font = [UIFont fontWithName:@"helvetica-light" size:14.0];
  sectionOpenSlotLabel.textAlignment = NSTextAlignmentCenter;
  [self.sectionOpenSlot addSubview:sectionOpenSlotLabel];
  [self.view addSubview:self.sectionOpenSlot];
  self.sectionOpenSlot.alpha = 0;
  

  // SECTION FACEBOOK
  self.sectionFacebookContainer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 70, 80, 140, 248)];
  self.sectionFacebook = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 248)];
  self.sectionFacebook.backgroundColor = [UIColor whiteColor];
  self.sectionFacebook.layer.shadowOffset = CGSizeMake(0, 0);
  self.sectionFacebook.layer.shadowOpacity = .5;
  self.sectionFacebook.layer.shadowRadius = 2;
  self.sectionFacebook.layer.cornerRadius = 2;
  self.sectionFacebook.clipsToBounds = YES;
  [self.view addSubview:self.sectionFacebookContainer];
  [self.sectionFacebookContainer addSubview:self.sectionFacebook];
  
  UIImageView *sectionFacebookImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBackground1"]];
  CGRect sectionTabFrame = CGRectMake(self.sectionFacebook.frame.origin.x, self.sectionFacebook.frame.origin.y, self.sectionFacebook.frame.size.width, self.sectionFacebook.frame.size.width);
  sectionFacebookImage.frame = sectionTabFrame;
  sectionFacebookImage.contentMode = UIViewContentModeTop;
  sectionFacebookImage.clipsToBounds = YES;
  [self.sectionFacebook addSubview:sectionFacebookImage];
  UILabel *sectionFacebookTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.sectionFacebook.frame.size.width, 20)];
  sectionFacebookTitle.text = @"Facebook";
  sectionFacebookTitle.textColor = [UIColor whiteColor];
  sectionFacebookTitle.font = [UIFont fontWithName:@"helvetica-bold" size:20.0];
  sectionFacebookTitle.layer.shadowOffset = CGSizeMake(0, 1);
  sectionFacebookTitle.layer.shadowOpacity = .35;
  sectionFacebookTitle.layer.shadowRadius = .5;
  [self.sectionFacebook addSubview:sectionFacebookTitle];
  
  self.sectionFacebook.transform = CGAffineTransformMakeRotation(-M_PI/180);
  [UIView animateWithDuration:.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat animations:^{
    self.sectionFacebook.transform = CGAffineTransformMakeRotation(M_PI/180);
  } completion:^(BOOL finished) {
  }];

  // SECTION NEWS
  self.sectionNewsContainer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 70, 400, 140, 248)];
  self.sectionNewsContainer.clipsToBounds = NO;
  self.sectionNews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 248)];
  self.sectionNews.backgroundColor = [UIColor whiteColor];
  self.sectionNews.layer.shadowOffset = CGSizeMake(0, 0);
  self.sectionNews.layer.shadowOpacity = .5;
  self.sectionNews.layer.shadowRadius = 2;
  self.sectionNews.layer.cornerRadius = 2;
  [self.view addSubview:self.sectionNewsContainer];
  [self.sectionNewsContainer addSubview:self.sectionNews];
  
  UIImageView *sectionNewsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newsTabBackground1"]];
  sectionNewsImage.frame = sectionTabFrame;
  sectionNewsImage.contentMode = UIViewContentModeTop;
  sectionNewsImage.clipsToBounds = YES;
  [self.sectionNews addSubview:sectionNewsImage];
  UILabel *sectionNewsTitle = [[UILabel alloc] initWithFrame:sectionFacebookTitle.frame];
  sectionNewsTitle.text = @"News";
  sectionNewsTitle.textColor = [UIColor whiteColor];
  sectionNewsTitle.font = [UIFont fontWithName:@"helvetica-bold" size:20.0];
  sectionNewsTitle.layer.shadowOffset = CGSizeMake(0, 1);
  sectionNewsTitle.layer.shadowOpacity = .35;
  sectionNewsTitle.layer.shadowRadius = .5;
  [self.sectionNews addSubview:sectionNewsTitle];
  

  
  // GESTURE RECOGNIZERS
  self.dragCard = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDragCard:)];
  [self.sectionNewsContainer addGestureRecognizer:self.dragCard];
  self.dragCard.delegate = self;
  
  self.doubleTapCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTapCard:)];
  self.doubleTapCard.numberOfTapsRequired = 2;
  [self.sectionNewsContainer addGestureRecognizer:self.doubleTapCard];
  self.doubleTapCard.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

#pragma mark - Private Gesture Methods

- (void)onDoneButton:(id)selector{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onDragCard:(UIPanGestureRecognizer *)drag{
  UIView *view = drag.view;
  UIView *firstChild = view.subviews[0];
  CGPoint point = [drag locationInView:self.view];
  
  if (drag.state == UIGestureRecognizerStateBegan){
    if(view.center.y > self.kThreshold){
      [self makeRoom];
    }
    [self.animator removeBehavior:self.snap];
    self.dragOffset = [drag locationInView:view];

    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:40 options:UIViewAnimationOptionOverrideInheritedOptions|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
      firstChild.transform = CGAffineTransformMakeScale(1.1, 1.1);
      self.sectionOpenSlot.alpha = 1;
    } completion:nil];
    CGPoint centerPoint = CGPointMake(point.x - self.dragOffset.x + view.frame.size.width/2, point.y - self.dragOffset.y + view.frame.size.height/2);
    view.center = centerPoint;
  }
  if (drag.state == UIGestureRecognizerStateChanged){
    CGPoint centerPoint = CGPointMake(point.x - self.dragOffset.x + view.frame.size.width/2, point.y - self.dragOffset.y + view.frame.size.height/2);
    view.center = centerPoint;
  }
  if (drag.state == UIGestureRecognizerStateEnded){

    CGPoint centerPoint = CGPointMake(point.x - self.dragOffset.x + view.frame.size.width/2, point.y - self.dragOffset.y + view.frame.size.height/2);
    view.center = centerPoint;

    CGPoint destPoint = centerPoint.y < self.kThreshold ? CGPointMake(160, 204) : CGPointMake(160, 524);
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.sectionNewsContainer snapToPoint:destPoint];
    snap.damping = 1;
    [self.animator addBehavior:snap];
    self.snap = snap;
    if(view.center.y > self.kThreshold){
      [self unMakeRoom];
    }
    [UIView animateWithDuration:.75 delay:0 usingSpringWithDamping:12 initialSpringVelocity:20 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionOverrideInheritedOptions animations:^{
      firstChild.transform = CGAffineTransformMakeScale(1, 1);
      self.sectionOpenSlot.alpha = 0;
    } completion:^(BOOL finished) {
      if(view.center.y < self.kThreshold){
        [UIView animateWithDuration:.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
          firstChild.transform = CGAffineTransformMakeRotation(-M_PI/180);
        } completion:^(BOOL finished) {
          [UIView animateWithDuration:.75 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat animations:^{
            firstChild.transform = CGAffineTransformMakeRotation(M_PI/180);
          } completion:^(BOOL finished) {}];
        }];
      }
    }];

  }
}

- (void)onDoubleTapCard:(UITapGestureRecognizer *)tap{
  UIView *view = tap.view;
  [self.animator removeBehavior:self.snap];
  CGPoint destPoint = CGPointMake(160, 204);
  if (view.center.y > self.kThreshold){
    [self makeRoom];
  }else{
    [self unMakeRoom];
    destPoint = CGPointMake(160, 524);
  }
  UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.sectionNewsContainer snapToPoint:destPoint];
  snap.damping = 1;
  [self.animator addBehavior:snap];
  self.snap = snap;
}

- (void)makeRoom{
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:12 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
    self.sectionFacebookContainer.center = CGPointMake(self.sectionFacebookContainer.center.x - self.sectionFacebookContainer.frame.size.width - 12, self.sectionFacebookContainer.center.y);
  } completion:nil];
}
- (void)unMakeRoom{
  [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:12 initialSpringVelocity:12 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
    self.sectionFacebookContainer.center = CGPointMake(self.sectionFacebookContainer.center.x + self.sectionFacebookContainer.frame.size.width + 12, self.sectionFacebookContainer.center.y);
  } completion:nil];
}

@end
