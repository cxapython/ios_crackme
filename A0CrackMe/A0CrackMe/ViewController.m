//
//  ViewController.m
//  A0CrackMe
//
//  Created by andyhah on 2023/5/3.
//

//设备的宽高
#define SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "Md5ViewController.h"
#import "UIButton+CrackTitle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    // 颜色
    UIColor *passColor= [UIColor colorWithRed:144/255.0 green:238/255.0 blue:144/255.0 alpha:1];
    UIColor *notPassColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1];
    
    // crack 数组，遍历展示
    NSMutableArray* crackArr = [self crackArray];
    
    for (NSInteger i=0; i < crackArr.count; i++){
        NSDictionary* arrDict = crackArr[i];
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 65+i*80, SCREENWIDTH, 80)];
        btn.backgroundColor = [arrDict[@"is_pass"] isEqual:@true] ? passColor : notPassColor; // 按钮颜色
        btn.titleLabel.font = [UIFont systemFontOfSize:18.0]; // 字体大小
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal]; // 字体颜色
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 文字水平居左
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btn setTitle:arrDict[@"desc"] forState:UIControlStateNormal];
        [btn.layer setCornerRadius:12];  // 设置圆角的半径
        [btn.layer setBorderWidth:1.0]; // 设置边框的粗细

        btn.crackTit = arrDict[@"title"];  // 传入title，以便查询跳转指定view
        [btn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside]; // 跳转md5视图
        self.navigationItem.hidesBackButton=NO;

        [self.view addSubview:btn];
    };
    
    
}

- (void)jumpAction:(UIButton*)btn{
    /*
     jump new view
     */

    // title: view; map
    // 同 arr 增加键值对
    NSDictionary* vcMap = @{
        @"MD5": [[Md5ViewController alloc] init],
    };
    
    //pushViewController调用
    [self.navigationController pushViewController:vcMap[btn.crackTit] animated:YES];
}

- (NSMutableArray*)crackArray{
    /*
     return all button list
     NSUserDefaults, 有就取出，无则初始化传入
     */
    
    // 同 vcMap 数组元素
    NSMutableArray* arr = [[NSMutableArray alloc] initWithCapacity:0];

    // md5
    NSDictionary* md5Dict = @{
        @"is_pass": @false,
        @"title": @"MD5",  // 对应 vcMap的key
        @"desc": @"md5字符串检测",
    };
    [arr addObject:md5Dict];
    
    // 测试 md5
    NSDictionary* _md5Dict = @{
        @"is_pass": @true,
        @"title": @"MD5",  // 对应 vcMap的key
        @"desc": @"测试 md5字符串检测",
    };
    [arr addObject:_md5Dict];
    
    return arr;
}

@end
