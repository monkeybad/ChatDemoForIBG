//
//  GroupTalkListViewController.m
//  Off the Record
//
//  Created by Lee Justin on 14-4-12.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import "GroupTalkListViewController.h"
#import "XMPPFramework.h"
#import "OTRXMPPManager.h"
#import "OTRProtocolManager.h"
#import "MBProgressHUD.h"
#import "GroupTalkChatViewController.h"
#import "CommonUtils.h"

typedef enum tagEnumInputViewType {
    kInputViewTypeJoin = 0,
    kInputViewTypeCreate,
    kInputViewTypeCount,
} EInputViewType;

@interface GroupTalkListViewController ()
{
    EInputViewType _inputType;
    MBProgressHUD *HUD;
}

@property (nonatomic,strong) NSMutableArray* roomJIDArray;
@property (nonatomic,strong) NSMutableDictionary* roomJIDForKeyAndNameForValueDict;

@end

@implementation GroupTalkListViewController

@synthesize tableView;
@synthesize textField;
@synthesize inputView;


@synthesize roomJIDArray;
@synthesize roomJIDForKeyAndNameForValueDict;

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
    [self showHUD];
    [[[OTRProtocolManager sharedInstance] getXMPPManager] requestGroupList:^(BOOL isSucceed, NSDictionary* roomJIDKeyAndNameValueDict) {
        [self hideHUD];
        if (isSucceed)
        {
            roomJIDArray = [NSMutableArray arrayWithArray:[roomJIDKeyAndNameValueDict allKeys]];
            roomJIDForKeyAndNameForValueDict = [NSMutableDictionary dictionaryWithDictionary:roomJIDKeyAndNameValueDict];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showHUD
{
    [self.view endEditing:YES];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    //HUD.delegate = self;
    HUD.labelText = @"正在拉取列表";
    [HUD show:YES];
}

-(void)hideHUD
{
    if (HUD)
    {
        [HUD hide:YES];
    }
}

#pragma mark -

- (IBAction)onPressedBack:(id)sender
{
    //UINavigationController* nav = self.navigationController;
    //[nav popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPressedCreate:(id)sender
{
    [CommonUtils uploadImage:[UIImage imageNamed:@"chatsecure_icon"] withURL:@"http://127.0.0.1:8080/upload" andCallback:^(BOOL isSucceed, id responseObj) {
        if (isSucceed)
        {
            NSLog(@"Image File Submit Succeed");
        }
        else
        {
            NSLog(@"Image File Submit Failed");
        }
        
    }];
    _inputType = kInputViewTypeCreate;
    self.inputView.hidden = NO;
    self.inputView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^(){
        self.inputView.alpha = 1.0f;
    } completion:^(BOOL finished){
    }];
}

- (IBAction)onPressedJoin:(id)sender
{
    _inputType = kInputViewTypeJoin;
    self.inputView.hidden = NO;
    self.inputView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^(){
        self.inputView.alpha = 1.0f;
    } completion:^(BOOL finished){
    }];
}

- (IBAction)onPressedDone:(id)sender
{
    [self.textField resignFirstResponder];
    switch (_inputType)
    {
        case kInputViewTypeJoin:
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^(){
        self.inputView.alpha = 0.0f;
    } completion:^(BOOL finished){
        self.inputView.hidden = YES;
        self.inputView.alpha = 1.0f;
    }];
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [roomJIDArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GroupTalkListCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupTalkListCell"];
    }
    cell.textLabel.text = [roomJIDForKeyAndNameForValueDict objectForKey:roomJIDArray[indexPath.row]];
    
    return cell;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* roomJID = self.roomJIDArray[indexPath.row];
    GroupTalkChatViewController* chatCtrl = [[GroupTalkChatViewController alloc] initWithNibName:@"GroupTalkChatViewController" bundle:nil];
    [chatCtrl enterRoomWithJID:roomJID];
    [self presentViewController:chatCtrl animated:YES completion:nil];
    chatCtrl.titleLabel.text = self.roomJIDForKeyAndNameForValueDict[roomJID];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self onPressedDone:nil];
    return YES;
}


@end
