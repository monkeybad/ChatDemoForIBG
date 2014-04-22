//
//  GroupTalkListViewController.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-12.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTalkListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITableView* tableView;

@property (nonatomic,strong) IBOutlet UITextField* textField;
@property (nonatomic,strong) IBOutlet UIView* inputView;

- (IBAction)onPressedBack:(id)sender;
- (IBAction)onPressedCreate:(id)sender;
- (IBAction)onPressedJoin:(id)sender;
- (IBAction)onPressedDone:(id)sender;

@end
