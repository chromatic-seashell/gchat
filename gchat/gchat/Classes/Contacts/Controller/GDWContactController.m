//
//  GDWContactController.m
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWContactController.h"
#import "EMClient.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [self setupNavItem];
    
    [self setTableView];
}
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
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
