//
//  StudentModel.h
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *score;

- (void)printInfo;
@end
