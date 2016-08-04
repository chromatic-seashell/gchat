//
//  GDWChatRefreshHeader.m
//  gchat
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWChatRefreshHeader.h"

@interface GDWChatRefreshHeader ()
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end


@implementation GDWChatRefreshHeader

- (void)prepare
{
    [super prepare];
    
    self.mj_h = 50;
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


@end
