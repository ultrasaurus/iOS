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

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notifications;

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

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"i_navbar_divebar.png"] style:UIBarButtonItemStylePlain target:nil action:nil];

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];

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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return YES if you want the specified item to be editable.
  return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    //add code here for when you hit delete
    [self.notifications removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

  }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Mark Read";
}

@end
