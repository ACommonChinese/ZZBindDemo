//
//  UIView+ZZBind.m
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "UIView+ZZBind.h"
#import "ZZBindBaseModel.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic) NSMutableArray *bindBaseModelArray;
@end

@implementation NSObject (ZZBind)

- (void)zz_prepareBindView:(UIView *)view viewProperty:(id)viewProperty model:(id)model modelProperty:(NSString *)modelProperty {
    ZZBindBaseModel *bindModel = [[ZZBindBaseModel alloc] init];
    bindModel.view             = view;
    bindModel.viewProperty     = viewProperty;
    bindModel.model            = model;
    bindModel.modelProperty    = modelProperty;
    [self.bindBaseModelArray addObject:bindModel];
}

- (NSMutableArray *)bindBaseModelArray {
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (array == nil) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)zz_bind {
    if ([self conformsToProtocol:@protocol(ZZBindDelegate)] && [self respondsToSelector:@selector(zz_willBind)]) {
        [self performSelector:@selector(zz_willBind)];
    }
    for (ZZBindBaseModel *bindModel in self.bindBaseModelArray) {
        id value = [bindModel.view valueForKey:bindModel.viewProperty];
        if (value) {
            [bindModel.model setValue:value forKey:bindModel.modelProperty];
        }
    }
    if ([self conformsToProtocol:@protocol(ZZBindDelegate)] && [self respondsToSelector:@selector(zz_afterBind)]) {
        [self performSelector:@selector(zz_afterBind)];
    }
}

@end
