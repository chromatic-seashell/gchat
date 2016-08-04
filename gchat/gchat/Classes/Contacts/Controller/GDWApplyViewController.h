//
//  GDWApplyViewController.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ApplyStyleFriend            = 0,
    ApplyStyleGroupInvitation,
    ApplyStyleJoinGroup,
}ApplyStyle;


@interface GDWApplyViewController : UITableViewController

{
    NSArray *_dataSource;
}

@property (strong, nonatomic, readonly) NSArray *dataSource;

+ (instancetype)shareController;

- (void)addNewApply:(NSDictionary *)dictionary;

- (void)loadDataSourceFromLocalDB;

- (void)clear;


@end
