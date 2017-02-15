//
//  Computer.h
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Keyboard.h"

@interface Computer : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) float weight;
@property (nonatomic) Keyboard *keyboard;

@end
