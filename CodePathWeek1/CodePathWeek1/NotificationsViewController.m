//
//  NotificationsViewController.m
//  CodePathWeek2
//
//  Created by Aaron Carambula on 2/19/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "NotificationsViewController.h"
#import "notificationTableViewCell.h"
#import "Notification.h"
//#import "UIImageView+AFNetworking.h"

@interface NotificationsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *notifsTable;
@property (strong, nonatomic) NSArray *notificationData;

@end

@implementation NotificationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"Notifications";
      self.notificationData = [Notification fakeNotifications];
      
//      self.notificationData = @[
//        @{@"notifText" : @"Aaron"},
//        @{@"notifText" : @"Claire"}];
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.notifsTable.rowHeight = 120;
  self.notifsTable.delegate = self;
  self.notifsTable.dataSource = self;
  
//  UITableViewCell *notifsTableViewCell = [[UITableViewCell alloc] init];
  
  // Register Class for Cell Reuse Identifier
  [self.notifsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"notificationTableViewCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.notificationData.count;
//  NSLog(@"%lu", (unsigned long)self.notificationData.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  notificationTableViewCell *notifCell = [tableView dequeueReusableCellWithIdentifier:@"notificationTableViewCell"];

  NSDictionary *notif = self.notificationData[indexPath.row];
  NSString *name = notif[@"notifText"];
  notifCell.notificationText.text = [NSString stringWithFormat:@"%@", name];
  
  return notifCell;
}

@end
