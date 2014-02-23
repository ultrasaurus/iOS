//
//  NotificationCell.h
//  Week2Homework
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell

@property (strong, nonatomic) UILabel *notificationText;
@property (strong, nonatomic) UILabel *timeStamp;
@property (strong, nonatomic) UIImageView *notificationIcon;
@property (strong, nonatomic) UIImageView *profilePic;


@end
