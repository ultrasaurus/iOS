//
//  ProfileViewController.m
//  Identity Walkthrough
//
//  Created by Aaron Carambula on 2/13/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "ProfileViewController.h"
#import "AboutViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *PhotoSwipe;
@property (weak, nonatomic) IBOutlet UIScrollView *ProfileContent;
- (IBAction)AboutTileTap:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Context;

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Profile";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//  UIScrollView *tempScrollView=(UIScrollView *)self.view;
  self.ProfileContent.contentSize = CGSizeMake(self.PhotoSwipe.frame.size.width, 10000);
//  self.ProfileContent.pagingEnabled=YES;
  
  
  self.PhotoSwipe.translatesAutoresizingMaskIntoConstraints = NO;

  self.PhotoSwipe.contentSize = CGSizeMake(self.PhotoSwipe.frame.size.width * 12,
    self.PhotoSwipe.frame.size.height);
  self.PhotoSwipe.pagingEnabled=YES;
  self.PhotoSwipe.backgroundColor = [UIColor blackColor];
  // Generate content for our scroll view using the frame height and width as the reference point
  
  int i = 0;
  while (i<=11) {
    
    UIView *views = [[UIView alloc]
                     initWithFrame:CGRectMake(((self.PhotoSwipe.frame.size.width)*i)+2, 0,
                                              (self.PhotoSwipe.frame.size.width)-4, self.PhotoSwipe.frame.size.height-2)];
    views.backgroundColor=[UIColor blueColor];
    [views setTag:i];
    [self.PhotoSwipe addSubview:views];
    
    
    i++;
  }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AboutTileTap:(UITapGestureRecognizer *)sender {
  NSLog(@"About Tap");
  AboutViewController *AboutVC = [[AboutViewController alloc] init];
  [self.navigationController pushViewController:AboutVC animated:YES];
}
@end
