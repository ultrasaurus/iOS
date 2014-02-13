//
//  MainViewController.m
//  demo
//
//  Created by Aaron Carambula on 2/11/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *storyCard;
@property (weak, nonatomic) IBOutlet UIImageView *picBox;

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
  
  NSLog(@"view did load");
  
    // Do any additional setup after loading the view from its nib.
  self.storyCard.layer.cornerRadius = 4;
  self.storyCard.layer.shadowColor = [UIColor blackColor].CGColor;
  self.storyCard.layer.shadowOffset = CGSizeMake(0, 2);
  self.storyCard.layer.shadowOpacity = .1;
  self.storyCard.layer.shadowRadius = 1;
  
  self.picBox.layer.shadowOffset = CGSizeMake(0, 2);
  self.picBox.layer.shadowOpacity = .1;
  self.picBox.layer.shadowRadius = 1;
  
  CGRect usernameFrame = CGRectMake(12, 12, 200, 24);
  UILabel *userName = [[UILabel alloc] initWithFrame:usernameFrame];
  userName.text = @"Aaron Carámbula";
//  UIView *userNameBox = [[UIView alloc] initWithFrame:usernameFrame];
//  userNameBox.backgroundColor = [UIColor blackColor];
//  [self.storyCard addSubview:userNameBox];
    [self.storyCard addSubview:userName];
  CGRect subtextFrame = CGRectMake(userName.frame.origin.x, userName.frame.origin.y + userName.frame.size.height + 10, userName.frame.size.width, 18);
  UILabel *subText = [[UILabel alloc] initWithFrame:subtextFrame];
  subText.text = @"February 10, 2014";
  [self.storyCard addSubview:subText];

}

- (void)viewWillAppear:(BOOL)animated{
  
}

- (void)viewDidAppear:(BOOL)animated{
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
