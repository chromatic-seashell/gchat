//
//  GDWContactViewCell.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDWContactGroup;

@interface GDWContactViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) GDWContactGroup *status;

@property (nonatomic, strong) NSString *buddy;

@property (nonatomic) NSInteger badge;
@end
