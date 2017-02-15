//
//  ViewController.m
//  BindModelDemo
//
//  Created by 刘威振 on 2017/2/15.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ZZBind.h"
#import "StudentModel.h"

@interface ViewController () <ZZBindDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *scoreField;
@property (weak, nonatomic) IBOutlet UITextField *keyboardNameField;

@property (nonatomic) StudentModel *student;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.student = [[StudentModel alloc] init];
    [self zz_prepareBindView:self.usernameField viewProperty:@"text" model:self.student modelProperty:@"username"];
    [self zz_prepareBindView:self.passwordField viewProperty:@"text" model:self.student modelProperty:@"password"];
    [self zz_prepareBindView:self.scoreField viewProperty:@"text" model:self.student modelProperty:@"score"];
    // [self zz_prepareBindView:self.keyboardNameField viewProperty:@"text" model:self.student.computer.keyboard modelProperty:@"name"];
    [self zz_prepareBindView:self.keyboardNameField viewProperty:@"text" model:self.student modelProperty:@"computer.keyboard.name"];
}

- (IBAction)submit:(id)sender {
    [self zz_bind];
    [self.student printInfo];
}

- (void)zz_willBind {
    NSLog(@"WillBind");
}

- (void)zz_afterBind {
    NSLog(@"After Bind");
}

@end
