//
//  ZZBindBaseModel.h
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZBindBaseModel : NSObject

@property (nonatomic) UIView *view;
@property (nonatomic) NSString *viewProperty;
@property (nonatomic) NSObject *model;
@property (nonatomic) NSString *modelProperty;
@end
