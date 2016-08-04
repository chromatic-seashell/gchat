//
//  GDWChatHelper.m
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWChatHelper.h"



static GDWChatHelper *helper = nil;

@implementation GDWChatHelper

+ (instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[GDWChatHelper alloc] init];
    });
    return helper;
}

- (void)dealloc
{
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
#if DEMO_CALL == 1
    [[EMClient sharedClient].callManager removeDelegate:self];
#endif
}



@end
