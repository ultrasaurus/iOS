//
//  MainViewController.m
//  UIDynamics Demo
//
//  Created by Aaron Carambula on 3/6/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) UIView *blueBox;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIGestureRecognizer *longPressBox;

- (void)onLP:(UILongPressGestureRecognizer *)longPress;


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
	// Do any additional setup after loading the view.
  self.blueBox = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  self.blueBox.backgroundColor = [UIColor blueColor];
  [self.view addSubview:self.blueBox];
  
  self.longPressBox = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLP:)];
  [self.blueBox addGestureRecognizer:self.longPressBox];
  
  [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionRepeat|UIViewAnimationOptionAllowUserInteraction animations:^{
    self.blueBox.transform = CGAffineTransformMakeRotation(M_PI / 90);
  } completion:^(BOOL finished) {
  }];
  
  self.animator = [[UIDynamicAnimator alloc] init];
  self.gravity = [[UIGravityBehavior alloc] init];
  [self.animator addBehavior:self.gravity];
  [self.gravity addItem:self.blueBox];
  
  self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.blueBox attachedToAnchor:CGPointMake(150, 100)];
  [self.animator addBehavior:self.attachment];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPanStories:(UIPanGestureRecognizer *)panGestureRecognizer{

- (void)onLP:(UILongPressGestureRecognizer *)longPress{
  UIView *view = longPress.view;
  CGPoint point = [longPress locationInView:self.view];
//  [self.animator updateItemUsingCurrentState:longPress.view];

  if (longPress.state == UIGestureRecognizerStateBegan){
      [self.animator removeBehavior:self.attachment];
    NSLog(@"HELLO LONGPRESS");
    CGPoint offset = [longPress locationInView:self.blueBox];
    offset = CGPointMake(offset.x - self.blueBox.frame.size.width/2, offset.y - self.blueBox.frame.size.height/2);
    self.attachment = [[UIAttachmentBehavior alloc] initWithItem:view offsetFromCenter:UIOffsetMake(offset.x, offset.y) attachedToAnchor:point];
    [self.animator addBehavior:self.attachment];
  }else if(longPress.state == UIGestureRecognizerStateChanged){
    self.attachment.anchorPoint = point;
  }else if(longPress.state == UIGestureRecognizerStateEnded){
    
  }
}
@end
