//
//  GDWContactController.h
//  gchat
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDWContactController : UITableViewController

+ (instancetype)shareController;

//好友请求变化时，更新好友请求未处理的个数
//- (void)reloadApplyView;

//群组变化时，更新群组页面
//- (void)reloadGroupView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
//- (void)addFriendAction;


@end
