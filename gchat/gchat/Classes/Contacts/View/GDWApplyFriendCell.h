//
//  GDWApplyFriendCell.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDWApplyUserModel;

@protocol GDWApplyFriendCellDelegate <NSObject>

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath;
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GDWApplyFriendCell : UITableViewCell

@property (nonatomic) id<GDWApplyFriendCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (nonatomic, strong) GDWApplyUserModel *status;

@end
