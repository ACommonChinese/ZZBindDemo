//
//  Computer.m
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "Computer.h"

@implementation Computer

- (NSString *)description {
    return [NSString stringWithFormat:@"name: %@\nweight: %f\n%@\n", self.name, self.weight, self.keyboard];
}

@end
