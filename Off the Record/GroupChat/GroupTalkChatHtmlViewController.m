//
//  GroupTalkChatHtmlViewController.m
//  Off the Record
//
//  Created by Lee Justin on 14-4-23.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import "GroupTalkChatHtmlViewController.h"
#import "GroupTalkChatHtmlBubbleViewController.h"
#import "GroupTalkChatHtmlInputBoxViewController.h"

@interface GroupTalkChatHtmlViewController ()

@property (nonatomic,retain) NSMutableArray* msgNickArray;
@property (nonatomic,retain) NSMutableArray* msgHtmlArray;
@property (nonatomic,retain) NSMutableArray* bubbleCtrlArray;
@property (nonatomic,retain) GroupTalkChatHtmlInputBoxViewController* inputViewCtrl;

@end

@implementation GroupTalkChatHtmlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.msgNickArray = [NSMutableArray array];
    self.msgHtmlArray = [NSMutableArray array];
    self.bubbleCtrlArray = [NSMutableArray array];
    
    GroupTalkChatHtmlInputBoxViewController* inputViewCtrl = [[GroupTalkChatHtmlInputBoxViewController alloc] initWithNibName:@"GroupTalkChatHtmlInputBoxViewController" bundle:nil];
    [inputViewCtrl.btnImage addTarget:self action:@selector(onPressedImage:) forControlEvents:UIControlEventTouchUpInside];
    [inputViewCtrl.btnSend addTarget:self action:@selector(onPressedSend:) forControlEvents:UIControlEventTouchUpInside];
    [inputViewCtrl.btnVoice addTarget:self action:@selector(onPressedVoice:) forControlEvents:UIControlEventTouchUpInside];
    self.inputViewCtrl = inputViewCtrl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgHtmlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reusedID = @"tableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
        GroupTalkChatHtmlBubbleViewController* bubbleCtrl = [[GroupTalkChatHtmlBubbleViewController alloc] initWithNibName:@"GroupTalkChatHtmlBubbleViewController" bundle:nil];
        cell.tag = self.bubbleCtrlArray.count;
        [self.bubbleCtrlArray addObject:bubbleCtrl];
        
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:bubbleCtrl.view];
    }
    
    NSInteger index = indexPath.row;
    
    GroupTalkChatHtmlBubbleViewController* bubbleCtrl = self.bubbleCtrlArray[cell.tag];
    bubbleCtrl.infoLabel.text = [NSString stringWithFormat:@"%@ Said:",self.msgNickArray[index]];
    [bubbleCtrl.webView loadHTMLString:self.msgHtmlArray[index] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 169;
}

#pragma mark - Event

- (void)onPressedSend:(id)sender
{
    
}

- (void)onPressedImage:(id)sender
{
    
}

- (void)onPressedVoice:(id)sender
{
    
}

@end
