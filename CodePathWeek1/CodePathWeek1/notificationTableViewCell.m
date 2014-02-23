//
//  notificationTableViewCell.m
//  CodePathWeek2
//
//  Created by Aaron Carambula on 2/20/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "notificationTableViewCell.h"


@interface notificationTableViewCell ()


@end

@implementation notificationTableViewCell

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
//      self.notificationText.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//      self.notificationText.leading = 2;

      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
