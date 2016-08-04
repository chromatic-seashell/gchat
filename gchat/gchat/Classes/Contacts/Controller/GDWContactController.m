//
//  GDWContactController.m
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWContactController.h"
#import "EMClient.h"
#import "GDWUIHelper.h"
#import "GDWContactDataHelper.h"
#import "GDWApplyUserModel.h"

#import "GDWContactViewCell.h"
#import "GDWApplyViewController.h"
#import "GDWChatViewController.h"
#import "GDWAddFriendViewController.h"

@interface GDWContactController ()<EMContactManagerDelegate>
{
    NSIndexPath *_currentLongPressIndex;
}

// 功能列表
@property (nonatomic, strong) NSMutableArray *functionGroup;
/** 好友的数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 格式化的好友列表数据 */
@property (nonatomic, strong) NSMutableArray *data;
/** 拼音首字母列表 */
@property (nonatomic, strong) NSMutableArray *section;

@property (nonatomic) NSInteger unapplyCount;
@end

@implementation GDWContactController

static  GDWContactController*controller = nil;

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
}
#pragma mark - 懒加载
- (NSMutableArray *)functionGroup
{
    if (_functionGroup == nil){
        self.functionGroup = [NSMutableArray array];
    }
    return _functionGroup;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil){
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)data
{
    if (_data == nil){
        self.data = [NSMutableArray array];
    }
    return _data;
}

- (NSMutableArray *)section
{
    if (_section == nil){
        self.section = [NSMutableArray array];
    }
    return _section;
}
#pragma mark - 控制器的生命周期函数
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadDataSource];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [self setupNavItem];
    
    [self setTableView];
}

- (void)dealloc{

    [[EMClient  sharedClient]  removeDelegate:self];
}
#pragma mark 
- (void)setupNavItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addContactAction)];
}

- (void)setTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    //    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 50.f;
    
    //    [self.tableView setTableHeaderView:self.searchController.searchBar];
    //    [self.tableView setTableFooterView:self.footerLabel];
}
- (void)addContactAction
{
    GDWAddFriendViewController *addController  = [[GDWAddFriendViewController  alloc]  initWithStyle:UITableViewStylePlain];
    [self.navigationController  pushViewController:addController animated:YES];
}

#pragma mark 获取数据并刷新表格
- (void)reloadDataSource
{
    [self.dataSource removeAllObjects];
    [self getDataSource];
    [self showTabBarBadge];
}

- (void)getDataSource
{
    EMError *error = nil;
    NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",buddyList);
    }else {
        buddyList = [[EMClient sharedClient].contactManager getContactsFromDB];
    }
    
    [self.dataSource addObjectsFromArray:buddyList];
    
    _functionGroup = [GDWUIHelper getFriensListItemsGroup];
    _data = [GDWContactDataHelper getFriendListDataBy:self.dataSource];
    _section = [GDWContactDataHelper getFriendListSectionBy:_data];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)showTabBarBadge
{
    NSInteger totalUnreadCount = [GDWApplyUserModel findByCriteria:@" WHERE apply = 0 "].count;
    
    if (totalUnreadCount > 0) {
        self.unapplyCount = totalUnreadCount;
    }
    
    if (totalUnreadCount == 0) {
        self.tabBarItem.badgeValue = nil;
    }else {
        if (totalUnreadCount > 99) {
            self.tabBarItem.badgeValue = @"99+";
        }else {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)totalUnreadCount];
        }
    }
}


#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _functionGroup.count;
    }
    NSArray *array = [_data objectAtIndex:section - 1];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDWContactViewCell *cell = [GDWContactViewCell  cellWithTableView:tableView];
    
    if (indexPath.section == 0) {
        GDWContactGroup *model = _functionGroup[indexPath.row];
        cell.status = model;
        if (indexPath.row == 0) {
            cell.badge = self.unapplyCount;
        }
    }else {
        NSArray *array = [_data objectAtIndex:indexPath.section - 1];
        cell.buddy = [array objectAtIndex:indexPath.row];
    }
    
    return cell;
}
#pragma mark - UITableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[GDWApplyViewController shareController] animated:YES];
                [[GDWApplyViewController shareController] loadDataSourceFromLocalDB];
                break;
                
            case 1:
                //                [self.navigationController pushViewController:[[LZGroupViewController alloc] init] animated:YES];
                
                break;
        }
        
        
    }else {
        NSArray *array = [_data objectAtIndex:indexPath.section - 1];
        NSString *buddy = [array objectAtIndex:indexPath.row];
        GDWChatViewController  *chatVc = [[GDWChatViewController alloc] initWithConversationChatter:buddy conversationType:EMConversationTypeChat];
        chatVc.title = buddy;
        [self.navigationController pushViewController:chatVc animated:YES];
    }

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.section;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.section objectAtIndex:section]];
    [contentView addSubview:label];
    return contentView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *array = [_data objectAtIndex:indexPath.section - 1];
        NSString *buddy = [array objectAtIndex:indexPath.row];
        EMError *error = [[EMClient sharedClient].contactManager deleteContact:buddy];
        
        if (!error) {
            [[EMClient sharedClient].chatManager deleteConversation:buddy deleteMessages:YES];
            [self reloadDataSource];
            [tableView reloadData];
        }
        else{
            [tableView reloadData];
        }
    }
}


#pragma mark - MContactManagerDelegate
#pragma mark  被好友删除之后回调
- (void)didReceiveDeletedFromUsername:(NSString *)aUsername{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            [_dataSource removeAllObjects];
            NSLog(@"被人删除获取用户列表 -- %@",userlist);
            [_dataSource addObjectsFromArray:userlist];
            _data = [GDWContactDataHelper getFriendListDataBy:_dataSource];
            _section = [GDWContactDataHelper getFriendListSectionBy:_data];
            NSLog(@"%@",_dataSource);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"被人删除获取用户列表失败 -- %@",error);
        }
    });

}
#pragma mark  好友申请处理结果回调
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    NSLog(@"%@",aUsername);
    
    [self reloadDataSource];
    
    [self.tableView reloadData];
}


#pragma mark  请求好友遭到拒绝
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername
{
    NSLog(@"%@",aUsername);
    //    NSString *message = [NSString stringWithFormat:@"%@ 拒绝了你的好友请求",aUsername];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    //    [alert show];
}

#pragma mark 收到好友邀请
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    NSLog(@"%@",aUsername);
    
    GDWApplyUserModel *user = [[GDWApplyUserModel alloc] init];
    user.name = aUsername;
    user.apply = NO;
    [user save];
    
    [self showTabBarBadge];
}

@end
