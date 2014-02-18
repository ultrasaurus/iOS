//
//  PermalinkViewController.m
//  CodePathWeek1
//
//  Created by Aaron Carambula on 2/16/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "PermalinkViewController.h"
#import "TTTAttributedLabel.h"

@interface PermalinkViewController ()

@property (strong, nonatomic) IBOutlet UIView *window;
@property (strong, nonatomic) UIScrollView *storyScroll;
@property (nonatomic) TTTAttributedLabel *attributedLabel;

@property (strong, nonatomic) UIView *commentInputContainer;
@property (strong, nonatomic) UIControl *UFILikeControl;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UIImage *UFILikeGlyph;
@property (strong, nonatomic) UIView *UFILikeGlyphView;
@property (strong, nonatomic) UIControl *UFICommentControl;


- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation PermalinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Post";
      
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
      
      self.tapRecognizer = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(respondToTapGesture:)];
      self.tapRecognizer.numberOfTapsRequired = 1;
      
      [self.view addGestureRecognizer:self.tapRecognizer];
      self.tapRecognizer.enabled = NO;
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  self.window.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(print_Message)];
  

  
  
  //////////////
  //SCROLL
  self.storyScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
  [self.window addSubview:self.storyScroll];
  
  //////////////
  //STORY
  
  //CONTAINER
  UIView *storyContainer = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 400)];
  self.storyScroll.contentSize = CGSizeMake(320, 1000);
  [self.storyScroll addSubview:storyContainer];

  //CARD
  UIView *storyCard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
  storyCard.backgroundColor = [UIColor whiteColor];
  storyCard.layer.shadowColor = [UIColor blackColor].CGColor;
  storyCard.layer.shadowOffset = CGSizeMake(0, 1);
  storyCard.layer.shadowOpacity = .05;
  storyCard.layer.shadowRadius = 0;
  [storyContainer addSubview:storyCard];

  //////////////
  //STORYHEADER
  
  //PROFILEPIC
  UIImage *profilePic = [UIImage imageNamed:@"profilePicAaron"];
  UIImageView *profilePicView = [[UIImageView alloc] initWithImage:profilePic];
  [profilePicView setFrame:CGRectMake(12, 12, 32, 32)];
//  profilePicView.appearance.rad
  [storyCard addSubview:profilePicView];
  
  //SOCIAL SENTENCE
  NSString *text = @"Aaron Carámbula is watching House of Cards.";

  TTTAttributedLabel *socialSentence = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(52, 11, 240, 200)];
  socialSentence.font = [UIFont systemFontOfSize:14];
  socialSentence.textColor = [UIColor darkGrayColor];
  socialSentence.lineBreakMode = NSLineBreakByWordWrapping;
  socialSentence.numberOfLines = 0;
  socialSentence.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
  socialSentence.leading = 2;
  
  [socialSentence setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
    NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"Aaron Carámbula" options:NSCaseInsensitiveSearch];
    NSRange entityRange = [[mutableAttributedString string] rangeOfString:@"House of Cards" options:NSCaseInsensitiveSearch];
    
    // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
    UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
    if (font) {
      [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:boldRange];
      [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:entityRange];
      //      [mutableAttributedString addAttribute:kTTTStrikeOutAttributeName value:[NSNumber numberWithBool:YES] range:strikeRange];
    }
    return mutableAttributedString;
  }];
  //  socialSentence = @"hi";
  //  [socialSentence sizeToFit];
  CGSize maximumLabelSize = CGSizeMake(240,200);
  CGSize expectedLabelSize = [text sizeWithFont:socialSentence.font
                              constrainedToSize:maximumLabelSize
                                  lineBreakMode:socialSentence.lineBreakMode];
  CGRect socialSentenceFrame = socialSentence.frame;
  socialSentenceFrame.size.height = expectedLabelSize.height + 4;
  socialSentence.frame = socialSentenceFrame;
  
  [storyCard addSubview:socialSentence];
  
  /////////////
  //STORY BODY
  NSString *story = @"Just like the first season, it took 2 episodes to get up and running. http://thegboatdotnet.files.wordpress.com/2011/12/mind-blown1.gif.";
  
  TTTAttributedLabel *storyBody = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(12, socialSentence.frame.origin.y + socialSentence.frame.size.height + 12, 296, 400)];
  storyBody.font = [UIFont systemFontOfSize:14];
  storyBody.textColor = [UIColor darkGrayColor];
  storyBody.lineBreakMode = NSLineBreakByWordWrapping;
  storyBody.numberOfLines = 0;
  storyBody.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
  storyBody.leading = 2;
//  storyBody.linkAttributes
  storyBody.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
  storyBody.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)

  [storyBody setText:story afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
    NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"Aaron Carámbula" options:NSCaseInsensitiveSearch];
    NSRange entityRange = [[mutableAttributedString string] rangeOfString:@"House of Cards" options:NSCaseInsensitiveSearch];
    
    // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
    UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
    if (font) {
      [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:boldRange];
      [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:entityRange];
      //      [mutableAttributedString addAttribute:kTTTStrikeOutAttributeName value:[NSNumber numberWithBool:YES] range:strikeRange];
    }
    return mutableAttributedString;
  }];

  CGSize maximumStorySize = CGSizeMake(296,400);
  CGSize expectedStorySize = [story sizeWithFont:storyBody.font
                              constrainedToSize:maximumStorySize
                                  lineBreakMode:storyBody.lineBreakMode];
  CGRect storyBodyFrame = storyBody.frame;
  storyBodyFrame.size.height = expectedStorySize.height + 4;
  storyBody.frame = storyBodyFrame;
  
  [storyCard addSubview:storyBody];
  
  
  //DATE
  NSString *timestampString = @"12 minutes ago • Friends";
  UILabel *timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(storyBody.frame.origin.x, storyBody.frame.origin.y + storyBody.frame.size.height + 12, storyBody.frame.size.width, 14)];
  timestampLabel.text = timestampString;
  [timestampLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
  timestampLabel.textColor = [UIColor lightGrayColor];
  [storyCard addSubview:timestampLabel];
  

  
  //ATTACHMENT
  //CONTAINER
  UIView *attachmentContainer = [[UIView alloc] initWithFrame:CGRectMake(timestampLabel.frame.origin.x, timestampLabel.frame.origin.y + timestampLabel.frame.size.height + 16, 308, 104)];
  attachmentContainer.backgroundColor = [UIColor whiteColor];
  //  attachmentContainer.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
  attachmentContainer.layer.shadowColor = [UIColor blackColor].CGColor;
  attachmentContainer.layer.shadowOffset = CGSizeMake(0, -.5);
  attachmentContainer.layer.shadowOpacity = .1;
  attachmentContainer.layer.shadowRadius = 0;
  [storyCard addSubview:attachmentContainer];

  //PIC
  UIImage *attachmentPic = [UIImage imageNamed:@"hocImage.png"];
  UIImageView *attachmentPicView = [[UIImageView alloc] initWithImage:attachmentPic];
  [attachmentPicView setFrame:CGRectMake(0, 16, 68, 96)];
  [attachmentContainer addSubview:attachmentPicView];

  //TITLE
  TTTAttributedLabel *attachmentTitle = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(attachmentPicView.frame.size.width + 8, attachmentPicView.frame.origin.y, attachmentContainer.frame.size.width - attachmentPicView.frame.size.width - 16, 16)];
  attachmentTitle.font = [UIFont boldSystemFontOfSize:14];
  attachmentTitle.textColor = [UIColor darkGrayColor];
  attachmentTitle.lineBreakMode = NSLineBreakByWordWrapping;
  attachmentTitle.numberOfLines = 0;
  attachmentTitle.text = @"House of Cards";
  [attachmentContainer addSubview:attachmentTitle];
  [storyCard addSubview:attachmentContainer];

  //TITLE
  TTTAttributedLabel *attachmentSubtext = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(attachmentTitle.frame.origin.x, attachmentTitle.frame.origin.y + attachmentTitle.frame.size.height + 4, attachmentTitle.frame.size.width, 16)];
  attachmentSubtext.font = [UIFont systemFontOfSize:12];
  attachmentSubtext.textColor = [UIColor darkGrayColor];
  attachmentSubtext.lineBreakMode = NSLineBreakByWordWrapping;
  attachmentSubtext.numberOfLines = 0;
  attachmentSubtext.text = @"TV Show • 86 Friends have watched this";
  [attachmentContainer addSubview:attachmentSubtext];
  
  
  //ACTION
  UIControl *attachmentAction = [[UIControl alloc] initWithFrame:CGRectMake(attachmentTitle.frame.origin.x, attachmentPicView.frame.origin.y + attachmentPicView.frame.size.height - 32, 132, 32)];
  //  attachmentAction.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
  attachmentAction.backgroundColor = [UIColor whiteColor];
  [attachmentAction.layer setCornerRadius:2.0f];
  attachmentAction.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
  attachmentAction.layer.borderWidth = 0.5f;
  [attachmentContainer addSubview:attachmentAction];
  
  //ACTION PLAY LABEL
  TTTAttributedLabel *actionPlayLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(24, 0, attachmentAction.frame.size.width - 28, attachmentAction.frame.size.height)];
  actionPlayLabel.font = [UIFont systemFontOfSize:12];
  actionPlayLabel.textColor = [UIColor darkGrayColor];
  actionPlayLabel.lineBreakMode = NSLineBreakByWordWrapping;
  actionPlayLabel.numberOfLines = 0;
  actionPlayLabel.textAlignment = NSTextAlignmentCenter;
  actionPlayLabel.text = @"Watch on Netflix";
  [attachmentAction addSubview:actionPlayLabel];
  
  //ACTION LEAVE GLYPH
  UIImage *actionLeaveGlyph = [UIImage imageNamed:@"leave_dark-grey_m.png"];
  UIImageView *actionLeaveGlyphView = [[UIImageView alloc] initWithImage:actionLeaveGlyph];
  [actionLeaveGlyphView setFrame:CGRectMake(8, 9, 14, 14)];
  [attachmentAction addSubview:actionLeaveGlyphView];

  //UFI
  //CONTAINER
  UIView *UFIContainer = [[UIView alloc] initWithFrame:CGRectMake(0, storyCard.frame.size.height + 1, storyCard.frame.size.width, 36)];
  UFIContainer.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
  UFIContainer.layer.shadowColor = [UIColor blackColor].CGColor;
  UFIContainer.layer.shadowOffset = CGSizeMake(0, 1);
  UFIContainer.layer.shadowOpacity = .05;
  UFIContainer.layer.shadowRadius = 0;
  [storyContainer addSubview:UFIContainer];

  //UFI LIKE CONTAINER
  self.UFILikeControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, UFIContainer.frame.size.width / 3, UFIContainer.frame.size.height)];
  self.UFILikeControl.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0];
  [UFIContainer addSubview:self.UFILikeControl];

//  UIControlEvents capture = UIControlEventTouchDown;
//  capture |= UIControlEventTouchDown;
//  capture |= UIControlEventTouchUpInside;
//  capture |= UIControlEventTouchUpOutside;
  [self.UFILikeControl addTarget:self action:@selector(UFILikeTouchDown:) forControlEvents:UIControlEventTouchDown];
  [self.UFILikeControl addTarget:self action:@selector(UFILikeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

  //UFI LIKE LABEL
  TTTAttributedLabel *UFILikeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(40, 0, self.UFILikeControl.frame.size.width - 28, self.UFILikeControl.frame.size.height)];
  UFILikeLabel.font = [UIFont systemFontOfSize:12];
  UFILikeLabel.textColor = [UIColor darkGrayColor];
  UFILikeLabel.lineBreakMode = NSLineBreakByWordWrapping;
  UFILikeLabel.numberOfLines = 0;
//  UFILikeLabel.textAlignment = NSTextAlignmentCenter;
  UFILikeLabel.userInteractionEnabled = NO;
  UFILikeLabel.text = @"Like";
  [self.UFILikeControl addSubview:UFILikeLabel];
  
  //UFI LIKE GLYPH
  self.UFILikeGlyph = [UIImage imageNamed:@"like_dark-grey_m.png"];
  self.UFILikeGlyphView = [[UIImageView alloc] initWithImage:self.UFILikeGlyph];
  [self.UFILikeGlyphView setFrame:CGRectMake(16, 9, 14, 14)];
  [self.UFILikeControl addSubview:self.UFILikeGlyphView];

  //UFI COMMENT CONTAINER
  self.UFICommentControl = [[UIControl alloc] initWithFrame:CGRectMake(self.UFILikeControl.frame.size.width, 0, UFIContainer.frame.size.width / 3, UFIContainer.frame.size.height)];
  self.UFICommentControl.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0];
  [UFIContainer addSubview:self.UFICommentControl];
  
  //UFI COMMENT LABEL
  TTTAttributedLabel *UFICommentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(40, 0, self.UFICommentControl.frame.size.width - 28, self.UFICommentControl.frame.size.height)];
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
  [UFICommentGlyphView setFrame:CGRectMake(16, 9, 14, 14)];
  [self.UFICommentControl addSubview:UFICommentGlyphView];
  
  [self.UFICommentControl addTarget:self action:@selector(UFICommentTouchDown:) forControlEvents:UIControlEventTouchDown];
  [self.UFICommentControl addTarget:self action:@selector(UFICommentTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
  
  
  //COMMENT FIELD CONTAINER
  self.commentInputContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height - 48, 320, 48)];
  self.commentInputContainer.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
  self.commentInputContainer.layer.shadowColor = [UIColor blackColor].CGColor;
  self.commentInputContainer.layer.shadowOffset = CGSizeMake(0, -.5);
  self.commentInputContainer.layer.shadowOpacity = .1;
  self.commentInputContainer.layer.shadowRadius = 0;
  [self.window addSubview:self.commentInputContainer];
  
  UITextView *commentInput = [[UITextView alloc] initWithFrame:CGRectMake(8, 8, 304, 32)];
  [commentInput.layer setCornerRadius:2.0f];
  commentInput.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
  commentInput.layer.borderWidth = 0.5f;

  [self.commentInputContainer addSubview:commentInput];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
  
}

-(void)print_Message {
  NSLog(@"Eh up, someone just pressed the button!");
}

-(void)myAction {
  NSLog(@"Eh up, someone just pressed the button!");
  
}

- (void)willShowKeyboard:(NSNotification *)notification {
  NSDictionary *userInfo = [notification userInfo];
  
  // Get the keyboard height and width from the notification
  // Size varies depending on OS, language, orientation
  CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
  
  // Get the animation duration and curve from the notification
  NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration = durationValue.doubleValue;
  NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
  UIViewAnimationCurve animationCurve = curveValue.intValue;
  
  // Move the view with the same duration and animation curve so that it will match with the keyboard animation
  [UIView animateWithDuration:animationDuration
                        delay:0.0
                      options:(animationCurve << 16)
                   animations:^{
                     self.commentInputContainer.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentInputContainer.frame.size.height, self.commentInputContainer.frame.size.width, self.commentInputContainer.frame.size.height);
                   }
                   completion:nil];
    self.tapRecognizer.enabled = YES;
}


- (void)willHideKeyboard:(NSNotification *)notification {
  NSDictionary *userInfo = [notification userInfo];
  
  // Get the animation duration and curve from the notification
  NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration = durationValue.doubleValue;
  NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
  UIViewAnimationCurve animationCurve = curveValue.intValue;
  
  // Move the view with the same duration and animation curve so that it will match with the keyboard animation
  [UIView animateWithDuration:animationDuration
                        delay:0.0
                      options:(animationCurve << 16)
                   animations:^{
                     self.commentInputContainer.frame = CGRectMake(0, self.window.frame.size.height - 48, 320, 48);
                   }
                   completion:nil];
    self.tapRecognizer.enabled = NO;
}



- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
  // Get the location of the gesture
//  CGPoint location = [recognizer locationInView:self.view];
  NSLog(@"OK OK OK OK OK OK OK ");
  [self.view endEditing:YES];

//  // Display an image view at that location
//  [self drawImageForGestureRecognizer:recognizer atPoint:location];
//  
//  // Animate the image view so that it fades out
//  [UIView animateWithDuration:0.5 animations:^{
//    self.imageView.alpha = 0.0;
//  }];
}



- (void) UFILikeTouchDown:(id)sender {
//    self.UFILikeControl.alpha = .5;
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.35 initialSpringVelocity:60 options:0 animations:^{
    self.UFILikeControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, .85, .85);
  }completion:^(BOOL finished) {
  }];
}

- (void) UFILikeTouchUpInside:(id)sender {
//  self.UFILikeControl.alpha = 1;
//  self.UFILikeGlyph = [UIImage imageNamed:@"like_blue_m.png"];
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:100 options:0 animations:^{
    self.UFILikeControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
  }completion:^(BOOL finished) {
  }];
}

- (void) UFICommentTouchDown:(id)sender {
//  self.UFICommentControl.opacity = .5;
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.35 initialSpringVelocity:60 options:0 animations:^{
    self.UFICommentControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, .85, .85);
  }completion:^(BOOL finished) {
  }];
}

- (void) UFICommentTouchUpInside:(id)sender {
  //  self.UFILikeControl.alpha = 1;
  [self.commentInputContainer becomeFirstResponder];
  [UIControl animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:100 options:0 animations:^{
    self.UFICommentControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
  }completion:^(BOOL finished) {
  }];
}


@end
