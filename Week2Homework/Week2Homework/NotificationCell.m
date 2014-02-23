//
//  NotificationCell.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
      int grid = 4;
      int padding = grid * 2;
      int gutter = grid * 2;
      
      self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, 60, 60)];
      self.profilePic.backgroundColor = [UIColor lightGrayColor];
      self.profilePic.contentMode = UIViewContentModeScaleAspectFill;
      self.profilePic.clipsToBounds = YES;
      [self addSubview:self.profilePic];
      

      self.notificationText = [[UILabel alloc] initWithFrame:CGRectMake(self.profilePic.frame.size.width + padding + gutter, padding - grid, self.frame.size.width - self.profilePic.frame.size.width - padding * 2 - gutter, 30)];
      self.notificationText.font = [UIFont systemFontOfSize:12];
      self.notificationText.textColor = [UIColor darkGrayColor];
      self.notificationText.lineBreakMode = NSLineBreakByWordWrapping;
      self.notificationText.numberOfLines = 0;
//      self.notificationText.backgroundColor = [UIColor redColor];
      [self addSubview:self.notificationText];
      
      self.notificationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.profilePic.frame.size.width + gutter + padding, self.profilePic.frame.size.height + padding - 16, 16, 16)];
      self.notificationIcon.backgroundColor = [UIColor lightGrayColor];
      [self addSubview:self.notificationIcon];

      self.timeStamp = [[UILabel alloc] initWithFrame:CGRectMake(self.notificationIcon.frame.origin.x + self.notificationIcon.frame.size.width + gutter, self.notificationIcon.frame.origin.y, self.frame.size.width - (self.notificationIcon.frame.origin.x + self.notificationIcon.frame.size.width) - padding - gutter, 16)];
      self.timeStamp.font = [UIFont systemFontOfSize:12];
      self.timeStamp.textColor = [UIColor lightGrayColor];
      self.timeStamp.lineBreakMode = NSLineBreakByWordWrapping;
      self.timeStamp.numberOfLines = 0;
//      self.timeStamp.backgroundColor = [UIColor redColor];
      [self addSubview:self.timeStamp];

//      self.backgroundColor = [UIColor blueColor];
      

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
