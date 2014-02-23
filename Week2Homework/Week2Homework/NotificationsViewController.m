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
#import "UIImageView+AFNetworking.h"

@interface NotificationsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSArray *notifications;

@end

@implementation NotificationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Notifications";
      self.notifications = [Notification fakeNotifications];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
  
  [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:@"NotificationCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Tableview Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  NotificationCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
  
//  notificationCell.notificationText.text = [NSString stringWithFormat:@"This is row %d", indexPath.row];
  Notification *notification = self.notifications[indexPath.row];
  notificationCell.notificationText.attributedText = notification.notifText;
  [notificationCell.notificationText sizeToFit];
  notificationCell.timeStamp.text = notification.timeStamp;
  
  [notificationCell.profilePic setImageWithURL:notification.userProfilePicURL];
  
[notificationCell.notificationIcon setImage:notification.notifIconImage];
  
  return notificationCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  //  self.expanded = !self.expanded;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.row == 0) {
    return 86;
  }else{
    return 86;
  }
}

@end
