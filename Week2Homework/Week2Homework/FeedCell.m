//
//  FeedCell.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/25/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "FeedCell.h"

@interface FeedCell ()

@property (strong, nonatomic) UIControl *UFILikeControl;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@property (strong, nonatomic) UIView *UFIContainer;
@property (strong, nonatomic) UIImage *UFILikeGlyph;
@property (strong, nonatomic) UIImage *UFILikeGlyphActive;
@property (strong, nonatomic) UIView *UFILikeGlyphView;
@property (strong, nonatomic) UIView *UFILikeGlyphActiveView;
@property (strong, nonatomic) UIControl *UFICommentControl;
@property (strong, nonatomic) UILabel *UFILikeLabel;
@property (strong, nonatomic) UILabel *UFILikeActiveLabel;


@end

@implementation FeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

      int grid = 4;
      int padding = grid * 4;
      int gutter = grid * 2;

      self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, 32, 32)];
      self.profilePic.backgroundColor = [UIColor lightGrayColor];
      self.profilePic.contentMode = UIViewContentModeScaleAspectFill;
      self.profilePic.clipsToBounds = YES;
      [self addSubview:self.profilePic];

      self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.profilePic.frame.size.width + padding + gutter, padding, self.frame.size.width - self.profilePic.frame.size.width - gutter - padding * 2, 18)];
      self.userName.font = [UIFont systemFontOfSize:14];
      self.userName.lineBreakMode = NSLineBreakByWordWrapping;
      self.userName.numberOfLines = 0;
      [self addSubview:self.userName];
      
      self.timeStamp = [[UILabel alloc] initWithFrame:CGRectMake(self.profilePic.frame.size.width + padding + gutter, self.userName.frame.size.height + padding, self.frame.size.width - self.profilePic.frame.size.width - gutter - padding * 2, 16)];
      self.timeStamp.font = [UIFont systemFontOfSize:12];
      self.timeStamp.textColor = [UIColor lightGrayColor];
      self.timeStamp.lineBreakMode = NSLineBreakByWordWrapping;
      self.timeStamp.numberOfLines = 0;
      [self addSubview:self.timeStamp];
      
      
      self.storyText = [[UILabel alloc] initWithFrame:CGRectMake(padding, self.profilePic.frame.size.height + padding + gutter, self.frame.size.width - padding * 2, 200)];
      self.storyText.font = [UIFont systemFontOfSize:14];
      self.storyText.textColor = [UIColor darkGrayColor];
      self.storyText.lineBreakMode = NSLineBreakByWordWrapping;
      self.storyText.numberOfLines = 0;
      [self.storyText sizeToFit];

      [self addSubview:self.storyText];
      
      
      //UFI
      //CONTAINER
      self.UFIContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.storyText.frame.origin.y + self.storyText.frame.size.height, self.frame.size.width, 36)];
//      self.UFIContainer.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
//      self.UFIContainer.layer.shadowColor = [UIColor blackColor].CGColor;
//      self.UFIContainer.layer.shadowOffset = CGSizeMake(0, -.5);
//      self.UFIContainer.layer.shadowOpacity = .05;
//      self.UFIContainer.layer.shadowRadius = 0;
      [self addSubview:self.UFIContainer];
      
      //UFI LIKE CONTAINER
      self.UFILikeControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 64, self.UFIContainer.frame.size.height)];
      self.UFILikeControl.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0];
      [self.UFIContainer addSubview:self.UFILikeControl];
      [self.UFILikeControl addTarget:self action:@selector(UFILikeTouchDown:) forControlEvents:UIControlEventTouchDown];
      [self.UFILikeControl addTarget:self action:@selector(UFILikeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
      
      //UFI LIKE LABEL
      self.UFILikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, self.UFILikeControl.frame.size.width - 28, self.UFILikeControl.frame.size.height)];
      self.UFILikeLabel.font = [UIFont systemFontOfSize:12];
      self.UFILikeLabel.textColor = [UIColor darkGrayColor];
      self.UFILikeLabel.lineBreakMode = NSLineBreakByWordWrapping;
      self.UFILikeLabel.numberOfLines = 0;
      //  self.UFILikeLabel.textAlignment = NSTextAlignmentCenter;
      self.UFILikeLabel.userInteractionEnabled = NO;
      self.UFILikeLabel.text = @"Like";
      [self.UFILikeControl addSubview:self.UFILikeLabel];
      
      //UFI LIKE ACTIVE LABEL
      self.UFILikeActiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, self.UFILikeControl.frame.size.width - 28, self.UFILikeControl.frame.size.height)];
      self.UFILikeActiveLabel.font = [UIFont systemFontOfSize:12];
      self.UFILikeActiveLabel.textColor = [UIColor colorWithRed:86/255.0f green:148/255.0f blue:253/255.0f alpha:1];
      self.UFILikeActiveLabel.lineBreakMode = NSLineBreakByWordWrapping;
      self.UFILikeActiveLabel.numberOfLines = 0;
      //  UFILikeLabel.textAlignment = NSTextAlignmentCenter;
      self.UFILikeActiveLabel.userInteractionEnabled = NO;
      self.UFILikeActiveLabel.text = @"Like";
      self.UFILikeActiveLabel.alpha = 0;
      [self.UFILikeControl addSubview:self.UFILikeActiveLabel];
      
      //UFI LIKE GLYPH
      self.UFILikeGlyph = [UIImage imageNamed:@"like_dark-grey_m.png"];
      self.UFILikeGlyphView = [[UIImageView alloc] initWithImage:self.UFILikeGlyph];
      [self.UFILikeGlyphView setFrame:CGRectMake(16, 10, 14, 14)];
      [self.UFILikeControl addSubview:self.UFILikeGlyphView];
      
      //UFI LIKE GLYPH ACTIVE STATE
      self.UFILikeGlyphActive = [UIImage imageNamed:@"like_blue_m.png"];
      self.UFILikeGlyphActiveView = [[UIImageView alloc] initWithImage:self.UFILikeGlyphActive];
      [self.UFILikeGlyphActiveView setFrame:CGRectMake(16, 9, 14, 14)];
      self.UFILikeGlyphActiveView.alpha = 0;
      [self.UFILikeControl addSubview:self.UFILikeGlyphActiveView];

      //UFI COMMENT CONTAINER
      self.UFICommentControl = [[UIControl alloc] initWithFrame:CGRectMake(self.UFILikeControl.frame.size.width, 0, self.UFIContainer.frame.size.width / 3, self.UFIContainer.frame.size.height)];
      self.UFICommentControl.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0];
      [self.UFIContainer addSubview:self.UFICommentControl];
      
      //UFI COMMENT LABEL
      UILabel *UFICommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, self.UFICommentControl.frame.size.width - 28, self.UFICommentControl.frame.size.height)];
      UFICommentLabel.font = [UIFont systemFontOfSize:12];
      UFICommentLabel.textColor = [UIColor darkGrayColor];
      UFICommentLabel.lineBreakMode = NSLineBreakByWordWrapping;
      UFICommentLabel.numberOfLines = 0;
      //  UFICommentLabel.textAlignment = NSTextAlignmentCenter;
      UFICommentLabel.userInteractionEnabled = NO;
      UFICommentLabel.text = @"Comment";
      [self.UFICommentControl addSubview:UFICommentLabel];
      
      //UFI COMMENT GLYPH
      UIImage *UFICommentGlyph = [UIImage imageNamed:@"comment_dark-grey_m.png"];
      UIImageView *UFICommentGlyphView = [[UIImageView alloc] initWithImage:UFICommentGlyph];
      [UFICommentGlyphView setFrame:CGRectMake(16, 10, 14, 14)];
      [self.UFICommentControl addSubview:UFICommentGlyphView];
      
      [self.UFICommentControl addTarget:self action:@selector(UFICommentTouchDown:) forControlEvents:UIControlEventTouchDown];
      [self.UFICommentControl addTarget:self action:@selector(UFICommentTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
      

      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- Private UFI Methodes


- (void)UFILikeTouchDown:(id)sender {
  //    self.UFILikeControl.alpha = .5;
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.35 initialSpringVelocity:60 options:0 animations:^{
    self.UFILikeControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, .85, .85);
  }completion:^(BOOL finished) {
  }];
}

- (void)UFILikeTouchUpInside:(id)sender {
  //  self.UFILikeControl.alpha = 1;
  //  self.UFILikeGlyph = [UIImage imageNamed:@"like_blue_m.png"];
  [UIControl animateWithDuration:.25 delay:0 options:0 animations:^{
    self.UFILikeGlyphView.alpha = self.UFILikeGlyphView.alpha == 0 ? 1 : 0;
    self.UFILikeGlyphActiveView.alpha = self.UFILikeGlyphActiveView.alpha == 1 ? 0 : 1;
    self.UFILikeLabel.alpha = self.UFILikeLabel.alpha == 0 ? 1 : 0;
    self.UFILikeActiveLabel.alpha = self.UFILikeActiveLabel.alpha == 0 ? 1 : 0;
    
  } completion:^(BOOL finished) {
  }];
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:100 options:0 animations:^{
    self.UFILikeControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
  }completion:^(BOOL finished) {
  }];
}


- (void)UFICommentTouchDown:(id)sender {
  //  self.UFICommentControl.opacity = .5;
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.35 initialSpringVelocity:60 options:0 animations:^{
    self.UFICommentControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, .85, .85);
  }completion:^(BOOL finished) {
  }];
}

- (void)UFICommentTouchUpInside:(id)sender {
  //  self.UFILikeControl.alpha = 1;
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:100 options:0 animations:^{
    self.UFICommentControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
  }completion:^(BOOL finished) {
  }];
}



@end
