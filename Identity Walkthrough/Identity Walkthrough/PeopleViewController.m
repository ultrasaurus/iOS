//
//  PeopleViewController.m
//  Identity Walkthrough
//
//  Created by Aaron Carambula on 2/13/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "PeopleViewController.h"
#import "ProfileViewController.h"

@interface PeopleViewController ()
@property (weak, nonatomic) IBOutlet UIView *PeopleLineSadie;
- (IBAction)PeopleLineSadieTap:(UITapGestureRecognizer *)sender;

@end

@implementation PeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"People";

    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PeopleLineSadieTap:(UITapGestureRecognizer *)sender {
  NSLog(@"goto sadie");
  ProfileViewController *ProfileVC = [[ProfileViewController alloc] init];
  [self.navigationController pushViewController:ProfileVC animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

@end
