//
//  StudentModel.m
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

- (void)printInfo {
    NSLog(@"username: %@\npassword: %@\nscore: %@", self.username, self.password, self.score);
}

@end
