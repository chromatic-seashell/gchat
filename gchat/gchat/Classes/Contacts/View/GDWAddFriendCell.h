//
//  GDWAddFriendCell.h
//  gchat
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addFriendCellDelegate <NSObject>

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface GDWAddFriendCell : UITableViewCell
{
    UILongPressGestureRecognizer *_headerLongPress;
}
@property (strong, nonatomic) UILabel *addLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UIView *bottomLineView;

@property (nonatomic, weak) id<addFriendCellDelegate> delegate;

/** 传递的用户名数据 */
@property (strong, nonatomic) NSString *username;


@end
