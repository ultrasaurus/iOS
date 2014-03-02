//
//  MainViewController.m
//  ExoBrainClone
//
//  Created by Aaron Carambula on 2/27/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

- (void)viewDidTap:(UITapGestureRecognizer *)tapGesture;
- (void)nodeDidLP:(UILongPressGestureRecognizer *)longPress;

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
  UIGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
  [self.view addGestureRecognizer:viewTapGR];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Private GR Methods

- (void)viewDidTap:(UITapGestureRecognizer *)tapGesture{

  CGPoint tapCenter = [tapGesture locationInView:self.view];
  NSLog(@"didtapyo %f", tapCenter.y);
  UIView *nodePrototype = [[UIView alloc] initWithFrame:CGRectMake(tapCenter.x - 40, tapCenter.y - 15, 80, 30)];

  nodePrototype.backgroundColor = [UIColor blueColor];
  
  [self.view addSubview:nodePrototype];
  
  UIGestureRecognizer *nodeLPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(nodeDidLP:)];
  [nodePrototype addGestureRecognizer:nodeLPGR];
}

- (void)nodeDidLP:(UILongPressGestureRecognizer *)longPress{
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

@end
