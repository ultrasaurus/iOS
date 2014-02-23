//
//  NotificationsViewController.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationCell.h"
#import "Notification.h"

@interface NotificationsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NotificationsViewController

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
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:@"NotificationCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Tableview Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
//  static NSString *cellIdentifier = @"NotificationCell";
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  NotificationCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
  
//  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

  notificationCell.notificationText.text = [NSString stringWithFormat:@"This is row %d", indexPath.row];

  return notificationCell;
}

@end
