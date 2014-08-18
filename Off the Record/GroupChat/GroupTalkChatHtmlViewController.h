//
//  GroupTalkChatHtmlViewController.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-23.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTalkChatHtmlViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) IBOutlet UITableView* tableView;
@property (nonatomic,retain) IBOutlet UILabel* titleLabel;

@end
