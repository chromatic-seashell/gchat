//
//  GDWContactGroup.h
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWContactGroup : NSObject
/*
 *  组头部标题
 */
@property (nonatomic, strong) NSString *headerTitle;

/*
 *  组尾部说明
 */
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@end
