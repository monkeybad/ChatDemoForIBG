//
//  GroupTalkChatHtmlInputBoxViewController.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-23.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTalkChatHtmlInputBoxViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,retain) IBOutlet UITextField* textField;
@property (nonatomic,retain) IBOutlet UIButton* btnSend;
@property (nonatomic,retain) IBOutlet UIButton* btnImage;
@property (nonatomic,retain) IBOutlet UIButton* btnVoice;


- (IBAction)onPressedSend:(id)sender;
- (IBAction)onPressedImage:(id)sender;
- (IBAction)onPressedVoice:(id)sender;

@end
