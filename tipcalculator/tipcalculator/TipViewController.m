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
- (void)updateValues {
  float billAmount = [self.billTextField.text floatValue];
  NSArray *tipValues = @[@(0.18), @(0.2), @(0.22)];
  float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float totalAmount = tipAmount + billAmount;
  self.tipLabel.text = [NSString stringWithFormat:@"%0.2f", tipAmount];
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
