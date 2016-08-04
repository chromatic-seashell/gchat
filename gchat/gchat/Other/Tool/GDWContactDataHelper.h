//
//  GDWContactDataHelper.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWContactDataHelper : NSObject
/**
 *  格式化好友列表
 */
+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array;
+ (NSMutableArray *) getFriendListSectionBy:(NSMutableArray *)array;
@end
