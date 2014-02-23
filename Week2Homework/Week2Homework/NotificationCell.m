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
        // Initialization code
      self.notificationText = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
      self.notificationText.font = [UIFont systemFontOfSize:14];
      self.notificationText.textColor = [UIColor darkGrayColor];
      self.notificationText.lineBreakMode = NSLineBreakByWordWrapping;
      self.notificationText.numberOfLines = 0;
      self.notificationText.backgroundColor = [UIColor redColor];
      [self addSubview:self.notificationText];
      self.backgroundColor = [UIColor blueColor];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
