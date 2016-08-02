//
//  GDWDataBaseTool.h
//  gchat
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWDataBaseTool : NSObject
// 沙盒相关
+ (void)saveToUserDefaults:(id)object key:(NSString *)key;
+ (id)getUserDefaultsWithKey:(NSString *)key;
@end
