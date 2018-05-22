//
//  UITableViewCell+Activity.m
//  TabCellWithActivity
//
//  Created by Mac on 2018/5/22.
//  Copyright © 2018年 saint. All rights reserved.
//

#import "UITableViewCell+Activity.h"
#import <objc/runtime.h>

static  NSString * activityKey   = @"activityKey";

static  NSString * accessViewKey = @"accessViewKey";

@interface UITableViewCell ()

@property (nonatomic, strong) UIView * accessView;

@end

@implementation UITableViewCell (Activity)

#pragma mark - runtime

-(void)setActivity:(UIActivityIndicatorView *)activity {
    objc_setAssociatedObject(self, &activityKey, activity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIActivityIndicatorView *)activity {
    return objc_getAssociatedObject(self, &activityKey);
}

-(void)setAccessView:(UIView *)accessView {
    objc_setAssociatedObject(self, &accessViewKey, accessView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)accessView {
    return objc_getAssociatedObject(self, &accessViewKey);
}

-(void)SX_startAnimating {
    self.accessView = self.accessoryView;
    if (!self.activity) {
        self.activity = ({
            UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activity setFrame:CGRectMake(0, 0, 30, 30)];
            activity;
        });
        self.accessoryView = self.activity;
    }
    [self.activity startAnimating];
}

-(void)SX_stopAnimating {
    self.accessoryView = self.accessView;
    [self.activity stopAnimating];
    self.activity = nil;
}

-(BOOL)SX_isAnimating {
    return [self.activity isAnimating];
}


@end
