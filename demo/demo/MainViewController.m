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

- (IBAction)onButton:(id)sender;
- (void)sayHello;
- (void)sayMyName: (NSString *)name;
- (void)sayMyFirstName:(NSString *)firstName lastName:(NSString *)lastName;

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

- (void)sayHello{
  NSLog(@"HellO!");
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
  NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated{
  NSLog(@"view did appear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (IBAction)onButton:(id)sender {
  [self sayHello];
  [self sayMyName:@"Aaron"];
  [self sayMyFirstName:@"James" lastName:@"Bond"];
}

- (void)sayMyName: (NSString *)name {
  NSLog(@"hey, %@", name);
}

- (void)sayMyFirstName:(NSString *)firstName lastName:(NSString *)lastName {
  NSLog(@"My name is %@, %@ %@", lastName, firstName, lastName);
}
@end
