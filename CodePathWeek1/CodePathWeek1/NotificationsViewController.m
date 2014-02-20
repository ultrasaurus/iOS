//
//  NotificationsViewController.m
//  CodePathWeek2
//
//  Created by Aaron Carambula on 2/19/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *notifsTable;
@property (strong, nonatomic) NSArray *notificationData;

@end

@implementation NotificationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
      self.notificationData = @[
        @{@"username" : @"Aaron"},
        @{@"username" : @"Claire"}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.notifsTable.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.notificationData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  NSDictionary *notif = self.notificationData[indexPath.row];
  NSString *name = notif[@"username"];
  cell.textLabel.text = [NSString stringWithFormat:@"Hello %@", name];
  
  return cell;
}

@end
