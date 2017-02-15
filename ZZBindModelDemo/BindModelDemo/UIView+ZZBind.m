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
        id value = [bindModel.view valueForKeyPath:bindModel.viewProperty];
        if (value) {
            [bindModel.model zz_confirmMiddleObjectNonEmpty:bindModel.modelProperty];
            [bindModel.model setValue:value forKeyPath:bindModel.modelProperty];
        }
    }
    if ([self conformsToProtocol:@protocol(ZZBindDelegate)] && [self respondsToSelector:@selector(zz_afterBind)]) {
        [self performSelector:@selector(zz_afterBind)];
    }
}

// 确保中间对象不为空 computer.keyboard.name，为name赋值，当确保computer.keyboard这些中间对象都不为空
- (void)zz_confirmMiddleObjectNonEmpty:(NSString *)keyPath {
    NSLog(@"keyPath: %@", keyPath);
    NSMutableArray<NSString *> *components = [NSMutableArray arrayWithArray:[keyPath componentsSeparatedByString:@"."]];
    if (components.count <= 1) {
        return;
    }
    [components removeLastObject];
    [self zz_middleObjectCheck:components];
}

// http://blog.csdn.net/icmmed/article/details/17298961
- (void)zz_middleObjectCheck:(NSMutableArray *)components {
    if (components.count <= 0) {
        return;
    }
    NSString *key = [components firstObject];
    NSObject *object = [self valueForKey:key];
    if (object == nil) { // 如果中间对象为空，创建它
        objc_property_t property = class_getProperty([self class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
        NSString *attribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        // NSLog(@"%@", attribute);  // T@"Computer",&,N,V_compute
        NSString * typeAttribute = [[attribute componentsSeparatedByString:@","] objectAtIndex:0];
        if ([typeAttribute hasPrefix:@"T@"]) {
            NSString *typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
            Class typeClass = NSClassFromString(typeClassName);
            object = [[typeClass alloc] init];
            [self setValue:object forKey:key];
        }
    }
    [components removeObjectAtIndex:0];
    [object zz_middleObjectCheck:components];
}

@end
