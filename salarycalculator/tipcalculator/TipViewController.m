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
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property(nonatomic, retain) UIColor *barTintColor;
@property (weak, nonatomic) IBOutlet UISlider *taxesPercent;
@property (weak, nonatomic) IBOutlet UILabel *dailyLabel;
@property (weak, nonatomic) IBOutlet UITextField *monthlyExpensesInput;
@property (weak, nonatomic) IBOutlet UILabel *netMonthLabel;
@property (weak, nonatomic) IBOutlet UITextField *DailyExpensesInput;


- (IBAction)onTap:(id)sender;
- (IBAction)onEditTab:(id)sender;
- (IBAction)taxesChanged:(id)sender;
- (IBAction)monthlyChanged:(id)sender;
- (IBAction)dailyChanged:(id)sender;


- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Celery";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)onTap:(id)sender {
  if ([self.billTextField.text floatValue] != 0){
    [self.view endEditing:YES];
    [self updateValues];
  }
}

- (IBAction)onEditTab:(id)sender {
  [self updateValues];
}

- (IBAction)taxesChanged:(id)sender {
  [self updateValues];
}

- (IBAction)monthlyChanged:(id)sender {
  [self updateValues];
}

- (IBAction)dailyChanged:(id)sender {
  [self updateValues];
}

- (void)toggleResults
{
  float tipControlDestY = _tipControlOriginalCenter.y + 138;
  float resultsControlDestY = _resultsControlCenter.y + 138;
  CGRect billTextFieldDest = _billTextFieldOriginalFrame;
  billTextFieldDest.origin.y = _billTextFieldOriginalFrame.origin.y + 88;
  float i = 0;

  if ([self.billTextField.text floatValue] > 0){
    tipControlDestY = _tipControlOriginalCenter.y;
    resultsControlDestY = _resultsControlCenter.y;
    billTextFieldDest.origin.y = _billTextFieldOriginalFrame.origin.y;
    i = 1;
  }
  [UIView animateWithDuration:0.3 animations:^{
    self.tipControl.center = CGPointMake(self.tipControl.center.x, tipControlDestY);
    self.resultsView.center = CGPointMake(self.resultsView.center.x, resultsControlDestY);
    self.billTextField.frame = billTextFieldDest;
  } completion:^(BOOL finished){
  }];

  [UIView animateWithDuration:0.45 animations:^{
//    self.resultsView.center = CGPointMake(self.resultsView.center.x, self.resultsView.center.y+138);
    self.tipControl.alpha = (int)i;
    self.resultsView.alpha = (int)i;
  } completion:^(BOOL finished){
  }];
  
}

- (void)updateValues {
  float billAmount = [self.billTextField.text floatValue];
  float monthlyExpenses = [self.monthlyExpensesInput.text floatValue];
  float dailyExpenses = [self.DailyExpensesInput.text floatValue];
  NSArray *payPeriods = @[@(26), @(24)];
  
  float totalAmount = billAmount / [payPeriods[self.tipControl.selectedSegmentIndex] floatValue] * (1 - self.taxesPercent.value);
  float monthlyAmount = (billAmount / 12) * (1 - self.taxesPercent.value) - monthlyExpenses - (dailyExpenses * 365 / 12);
  float dailyAMount = (billAmount / 365) * (1 - self.taxesPercent.value) - ((monthlyExpenses * 12) / 365) - dailyExpenses;
  
  [self toggleResults];
  
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
  self.netMonthLabel.text = [NSString stringWithFormat:@"$%0.2f", monthlyAmount];
  self.dailyLabel.text = [NSString stringWithFormat:@"$%0.2f", dailyAMount];
}


- (void)setupViews
{
  self.billTextField.alpha = 0;
  self.resultsView.alpha = 0;
  self.tipControl.alpha = 0;

  CGRect billTextFieldDest = _billTextFieldOriginalFrame;
  billTextFieldDest.origin.y = _billTextFieldOriginalFrame.origin.y + 88;
  [UIView animateWithDuration:0.2 animations:^{
//    self.inputView.alpha = 1;
  } completion:^(BOOL finished){
      self.tipControl.center = CGPointMake(self.tipControl.center.x, _tipControlOriginalCenter.y + 138);
      self.resultsView.center = CGPointMake(self.resultsView.center.x, _resultsControlCenter.y + 138);
    self.billTextField.alpha = 1;
    self.billTextField.frame = billTextFieldDest;
  }];

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  _tipControlOriginalCenter = CGPointMake(self.tipControl.center.x, self.tipControl.center.y);
  _resultsControlCenter = CGPointMake(self.resultsView.center.x, self.resultsView.center.y);
    _billTextFieldOriginalFrame = self.billTextField.frame;
  [self.billTextField becomeFirstResponder];
  [self setupViews];
  [self updateValues];
  
}


@end
