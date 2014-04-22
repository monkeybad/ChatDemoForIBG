//
//  GroupTalkChatViewController.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-14.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import "OTRChatViewController.h"

@interface GroupTalkChatViewController : UIViewController
{
    BOOL _isGroupChat;
}

- (void)enterRoomWithJID:(NSString*)roomJID;
- (void)leaveRoom;

@property (nonatomic,strong) IBOutlet UITextView* textView;
@property (nonatomic,strong) IBOutlet UITextField* textField;
@property (nonatomic,strong) IBOutlet UILabel* titleLabel;

- (IBAction)onPressedBack:(id)sender;
- (IBAction)onPressedSend:(id)sender;

@end
