//
//  AboutViewController.m
//  Identity Walkthrough
//
//  Created by Aaron Carambula on 2/13/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *AboutContent;
@property (weak, nonatomic) IBOutlet UIButton *askButtonAddress;
- (IBAction)askButtonAddressUp:(id)sender;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"About";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.AboutContent.contentSize = CGSizeMake(320, 725);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)askButtonAddressUp:(id)sender {
  
}
@end
