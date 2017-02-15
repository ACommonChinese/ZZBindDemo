# ZZBindDemo
绑定视图和模型，用于通过简单统一的代码让视图的值填充到模型中

####使用方法####
把`ZZBindBaseModel`和`UIView+ZZBind`两个类拖入工程：


```
@interface ViewController () <ZZBindDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *scoreField;
@property (nonatomic) StudentModel *student;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.student = [[StudentModel alloc] init];
    [self zz_prepareBindView:self.usernameField viewProperty:@"text" model:self.student modelProperty:@"username"];
    [self zz_prepareBindView:self.passwordField viewProperty:@"text" model:self.student modelProperty:@"password"];
    [self zz_prepareBindView:self.scoreField viewProperty:@"text" model:self.student modelProperty:@"score"];
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
```

###因过于简单和没有技术含量，故不加说明###