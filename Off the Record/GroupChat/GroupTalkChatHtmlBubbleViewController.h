//
//  GroupTalkChatHtmlBubbleViewController.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-23.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTalkChatHtmlBubbleViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) IBOutlet UILabel* infoLabel;
@property (nonatomic,retain) IBOutlet UIWebView* webView;

@end
