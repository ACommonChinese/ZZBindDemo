# ZZBindDemo
绑定视图和模型，用于通过简单统一的代码让视图的值填充到模型中

####使用方法####
把`ZZBindBaseModel`和`UIView+ZZBind`两个类拖入工程：


```
- (void)viewDidLoad {
	[super viewDidLoad];

	self.student = [[StudentModel alloc] init];
	// 把self.usernameField的text属性绑定到模型self.student.username上
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

```

###需要注意点：###
1. 顶层的model应当实例化，如：`self.student = [[StudentModel alloc] init];`    
2. 可以多层次赋值，如：`[self zz_prepareBindView:self.keyboardNameField viewProperty:@"text" model:self.student modelProperty:@"computer.keyboard.name"];`, 而如果要想使用`[self zz_prepareBindView:self.keyboardNameField viewProperty:@"text" model:self.student.computer.keyboard modelProperty:@"name"];`的方式，需自己确保中间对象即student.computer.keyboard不为空

###因过于简单和没有技术含量，故不加过多说明###
