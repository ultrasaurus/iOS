//
//  MainViewController.m
//  ExoBrainClone
//
//  Created by Aaron Carambula on 2/27/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) UIView *blueBox;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UIDynamicItemBehavior *elasticity;
@property (strong, nonatomic) UIPushBehavior *pushme;
@property (assign, nonatomic) float blockerWidth;
@property (assign, nonatomic) int score;
- (void)viewDidTap:(UITapGestureRecognizer *)tapGesture;
- (void)nodeDidLP:(UILongPressGestureRecognizer *)longPress;
- (void)onTimer:(id)sender;

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

  self.blockerWidth = 80.0;
  self.score = 0;
  
//  UILabel scoreCard = [UILabel ]
  
  self.blueBox = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  self.blueBox.backgroundColor = [UIColor greenColor];
  [self.view addSubview:self.blueBox];
  
  UIGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
  [self.view addGestureRecognizer:viewTapGR];
  
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

  self.gravity = [[UIGravityBehavior alloc] init];
  self.gravity.magnitude = 0.1;
  self.gravity.gravityDirection = CGVectorMake(.2, 1);
  [self.animator addBehavior:self.gravity];
  
  self.collision = [[UICollisionBehavior alloc] init];
  self.collision.collisionDelegate = self;
  self.collision.translatesReferenceBoundsIntoBoundary = YES;
  [self.animator addBehavior:self.collision];
  
  self.elasticity = [[UIDynamicItemBehavior alloc] init];
  self.elasticity.elasticity = 1.0;
  [self.animator addBehavior:self.elasticity];
  
  self.pushme = [[UIPushBehavior alloc] initWithItems:@[] mode:UIPushBehaviorModeContinuous];
  self.pushme.pushDirection = CGVectorMake(0, -1);
  [self.animator addBehavior:self.pushme];
  
  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Private GR Methods

- (void)viewDidTap:(UITapGestureRecognizer *)tapGesture{

  CGPoint tapCenter = [tapGesture locationInView:self.view];
  UIView *nodePrototype = [[UIView alloc] initWithFrame:CGRectMake(tapCenter.x - 40, tapCenter.y - 15, self.blockerWidth, 30)];
  nodePrototype.backgroundColor = [UIColor blueColor];
  
  [self.view addSubview:nodePrototype];
//  [self.gravity addItem:nodePrototype];
  [self.collision addItem:nodePrototype];
//  self.collision.collisionMode = UICollisionBehaviorModeBoundaries;
  [self.pushme addItem:nodePrototype];
  UIGestureRecognizer *nodeLPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(nodeDidLP:)];
  [nodePrototype addGestureRecognizer:nodeLPGR];

}

- (void)nodeDidLP:(UILongPressGestureRecognizer *)longPress{
//    [self.gravity removeItem:longPress.view];
  [self.animator updateItemUsingCurrentState:longPress.view];
  CGPoint tapCenter = [longPress locationInView:self.view];

  CGPoint selfCenter = longPress.view.center;
  NSLog(@"WE BE LONGPRESS %f", selfCenter.y);
  if(longPress.state == UIGestureRecognizerStateBegan){
    longPress.view.transform = CGAffineTransformMakeScale(1.25, 1.25);
  }
  if(longPress.state == UIGestureRecognizerStateChanged){
    longPress.view.center = tapCenter;
  }
  if(longPress.state == UIGestureRecognizerStateEnded){
    longPress.view.transform = CGAffineTransformMakeScale(1, 1);
  }
  
}

- (void)onTimer:(id)sender{
  int x = arc4random() % 320;
  UIView *raindrop = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 20, 50)];
  [self.view addSubview:raindrop];

  raindrop.backgroundColor = [UIColor redColor];
  [self.gravity addItem:raindrop];
  [self.collision addItem:raindrop];
  [self.elasticity addItem:raindrop];
  UIGestureRecognizer *nodeTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(nodeDidLP:)];
  [raindrop addGestureRecognizer:nodeTap];

}

#pragma mark - UICollisionBehavior delegate methods
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
  UIView *view = (UIView *)item;
//  [self performSelector:@selector(removeItem:) withObject:view afterDelay:0.5];
  self.blockerWidth--;
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p{
  UIView *view = (UIView *)item1;
  UIView *view2 = (UIView *)item2;
  [self performSelector:@selector(removeItem:) withObject:view afterDelay:0.0];
  [self performSelector:@selector(removeItem:) withObject:view2 afterDelay:0.5];
}

- (void)removeItem:(UIView *)view {
  [UIView animateWithDuration:.5 animations:^{
    view.alpha = 0;
  } completion:^(BOOL finished) {
    [view removeFromSuperview];
    [self.collision removeItem:view];
  }];
}
@end
