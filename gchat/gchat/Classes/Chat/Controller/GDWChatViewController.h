//
//  GDWChatViewController.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDKFull.h"
#import "EaseMessageViewController.h"

@interface GDWChatViewController : EaseMessageViewController <EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

@end
