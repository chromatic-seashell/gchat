//
//  GDWUIHelper.m
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWUIHelper.h"
#import "GDWContactGroup.h"
#import "MJExtension.h"

@implementation GDWUIHelper
+ (NSMutableArray *)getFriensListItemsGroup
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *dicts = @[@{@"title" : NSLocalizedString(@"title.apply", @"Application and notification"), @"icon" : @"plugins_FriendNotify"},
                       @{@"title" : NSLocalizedString(@"title.group", @"Group"), @"icon" : @"add_friend_icon_addgroup"},
                       @{@"title" : NSLocalizedString(@"title.chatroomlist",@"chatroom list"), @"icon" : @"Contact_icon_ContactTag"},
                       @{@"title" : NSLocalizedString(@"title.robotlist",@"robot list"), @"icon" : @"add_friend_icon_offical"}];
    array = [GDWContactGroup objectArrayWithKeyValuesArray:dicts];
    return array;
}
@end
