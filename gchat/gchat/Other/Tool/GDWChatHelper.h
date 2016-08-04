//
//  GDWChatHelper.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMSDKFull.h"
#import "EMClient.h"
#import "EMClientDelegate.h"

@interface GDWChatHelper : NSObject <EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate,EMCallManagerDelegate>

+ (instancetype)shareHelper;


@end
