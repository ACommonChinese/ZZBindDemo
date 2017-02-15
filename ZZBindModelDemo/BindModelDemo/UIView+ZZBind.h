//
//  UIView+ZZBind.h
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZBindDelegate <NSObject>

- (void)zz_willBind;
- (void)zz_afterBind;

@end

@interface NSObject (ZZBind)

- (void)zz_prepareBindView:(UIView *)view viewProperty:(id)viewProperty model:(id)model modelProperty:(NSString *)modelProperty;
- (void)zz_bind;

@end
