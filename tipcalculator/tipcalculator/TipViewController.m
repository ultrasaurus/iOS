//
//  TipViewController.m
//  tipcalculator
//
//  Created by Aaron Carambula on 2/7/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *splitTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitFourLabel;
@property (weak, nonatomic) IBOutlet UIView *resultsView;

- (IBAction)onTap:(id)sender;
- (IBAction)onEditTab:(id)sender;

- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Tabbit";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self.billTextField becomeFirstResponder];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}

- (IBAction)onEditTab:(id)sender {
  [self updateValues];

}
- (void)fadeInResults
{
  [UIView beginAnimations:@"fade in" context:nil];
  [UIView setAnimationDuration:1.0];
  self.resultsView.alpha = 1.0;
  [UIView commitAnimations];
}
- (void)updateValues {
  float billAmount = [self.billTextField.text floatValue];
  NSArray *tipValues = @[@(0.18), @(0.2), @(0.22)];
  float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float totalAmount = tipAmount + billAmount;
  if (totalAmount == 0){
    NSLog(@"null dood");
    self.resultsView.alpha = 0;
  }else{
    [self fadeInResults];

  }
  self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
  
  self.splitTwoLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount / 2];
  self.splitThreeLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount / 3];
  self.splitFourLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount / 4];

}

@end
