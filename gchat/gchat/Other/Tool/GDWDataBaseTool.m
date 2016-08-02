//
//  GDWDataBaseTool.m
//  gchat
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWDataBaseTool.h"

@implementation GDWDataBaseTool
// 沙盒相关
+ (void)saveToUserDefaults:(id)object key:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:object forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (id)getUserDefaultsWithKey:(NSString *)key
{
    id returnObj = nil;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        returnObj = [standardUserDefaults objectForKey: key];
    }
    return returnObj;
}

@end
