//
//  GroupTalkChatViewController.m
//  Off the Record
//
//  Created by Lee Justin on 14-4-14.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import "GroupTalkChatViewController.h"
#import "OTRProtocolManager.h"

@interface GroupTalkChatViewController ()

@property (nonatomic,strong) NSString* currentRoomJID;

@end

@implementation GroupTalkChatViewController

@synthesize currentRoomJID;

@synthesize textView;
@synthesize textField;
@synthesize titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)enterRoomWithJID:(NSString*)roomJID
{
    _isGroupChat = YES;
    self.currentRoomJID = roomJID;
    [[[OTRProtocolManager sharedInstance] getXMPPManager] enterRoomWithOnReceivedRoomMsgFor:roomJID callBack:^(NSString *roomMsg, NSString *memeberJID, NSString *memberNick) {
        NSString* text = self.textView.text;
        text = [text stringByAppendingFormat:@"[%@]说:%@\n",memberNick,roomMsg];
        self.textView.text = text;
        [self.textView layoutSubviews];
        CGRect rectEnd = self.textView.frame;
        rectEnd.origin = CGPointMake(0,self.textView.contentSize.height - rectEnd.size.height);
        rectEnd.origin.y = CGRectGetMaxY(rectEnd);
        rectEnd.origin.y += 30;
        [self.textView setContentOffset:rectEnd.origin animated:YES];
    }];
}

- (void)leaveRoom
{
    [[[OTRProtocolManager sharedInstance] getXMPPManager] leaveRoomFor:self.currentRoomJID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPressedBack:(id)sender
{
    [self.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPressedSend:(id)sender
{
    NSString* msg = self.textField.text;
    if ([msg length] > 0)
    {
        //[[[OTRProtocolManager sharedInstance] getXMPPManager] sendRoomMsg:msg withRoomJID:self.currentRoomJID];
        [[[OTRProtocolManager sharedInstance] getXMPPManager] sendRoomMsg:msg withHtml:@"<html xmlns=\"http://jabber.org/protocol/xhtml-im\">\n<body xmlns=\"http://www.w3.org/1999/xhtml\">\n<img src=\"http://www.webrtc-experiment.com/images/fork-left.png\"></img>\n</body>\n</html>" withRoomJID:self.currentRoomJID];
    }
}

@end
