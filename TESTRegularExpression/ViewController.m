//
//  ViewController.m
//  TESTRegularExpression
//
//  Created by xojiang on 16/4/17.
//  Copyright © 2016年 TEST. All rights reserved.
//

// http://www.regular-expressions.info

/*  NSRegularExpressionOptions {
        NSRegularExpressionCaseInsensitive,                 //忽略大小写
        NSRegularExpressionAllowCommentsAndWhitespace,      //忽略pattern的空格和#号
        NSRegularExpressionIgnoreMetacharacters,            //忽略元字符，加上后pattern里的元字符当成普通字符处理
        NSRegularExpressionDotMatchesLineSeparators,        //允许.匹配任何字符，包括行分隔符
        NSRegularExpressionAnchorsMatchLines,               //允许^和$匹配行开头和结尾
        NSRegularExpressionUseUnixLineSeparators,           //Unix分隔符 \n  作为分行符
        NSRegularExpressionUseUnicodeWordBoundaries         //Unicode TR#29 作为分词符
 }
 */

/*
 表达式和语法：
 ^      : 匹配之后紧邻元素开头的行
 $      : 匹配之后紧邻元素结尾的行
 []     : 匹配若干字符之一
 [^……]  : 排除性字符（匹配一个未列出的字符，而不是不匹配该字符）
 .      : 匹配任意字符
 |      : 匹配分隔两边的任意一个表达式
 ?      : 可选项元素，只作用于之前紧邻元素
 +      : 至少匹配之前紧邻元素1次
 *      : 至少匹配之前紧邻元素0次
 {n, m} : 区间量词，匹配之前紧邻元素 n 至 m 次，{n}匹配准确n次，{n,}匹配至少n次
 (?=)   : 正向肯定预查，在还未匹配的串中预匹配pattern
            eg. a(?=bc) 会匹配'abc'，返回其中的'a',不消耗bc（提前匹配bc返回满足紧邻bc之前的a）
            eg. (?=bc)\w 会匹配'bc'中的'b'
 (?!)   : 正向否定预查，同楼上相反，匹配非pattern
            eg. a(?!bc) 会匹配'ade'，返回其中的'a',即非紧邻'bc'的a
 (?<=)  : 反向肯定预查，(?=)相反方向，理解为从后开始匹配的正向预查
            eg. (?<=bc)d，会匹配'bcd'，返回其中的'd',不消耗bc
            eg. (?<=bc)\w 会匹配'bc'中的c，反方向pattern中的第一个元素
 (?<!)  : 反向否定预查，同楼上相反
 */


#import "ViewController.h"
#import "TESTRegularExpressionSearchViewController.h"
#import "TESTRegularExpressionOptionViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <TESTRegularExpressionDelegate>

@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) NSRegularExpression * regex;
@property (nonatomic, assign) NSRegularExpressionOptions currentOption;
@property (nonatomic, copy) NSString * regularExpression;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBaseView];
}

- (void)setUpBaseView {
    self.currentOption = NSRegularExpressionCaseInsensitive | NSRegularExpressionAllowCommentsAndWhitespace | NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines | NSRegularExpressionUseUnixLineSeparators | NSRegularExpressionUseUnicodeWordBoundaries;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick)];
    [self.navigationItem setRightBarButtonItem:rightBtn];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Option" style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClick)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
}

- (void)rightBtnClick {
    TESTRegularExpressionSearchViewController * vc = [[TESTRegularExpressionSearchViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)leftBtnClick {
    TESTRegularExpressionOptionViewController * optionVC = [[TESTRegularExpressionOptionViewController alloc] init];
    optionVC.currentOption = self.currentOption;
    __weak typeof(self) weakSelf = self;
    optionVC.block = ^(NSRegularExpressionOptions option) {
        weakSelf.currentOption = option;
        if (weakSelf.regularExpression != nil) {
            [weakSelf selectRegularExpression:weakSelf.regularExpression];
        }
    };
    [self.navigationController pushViewController:optionVC animated:YES];
}

#pragma mark - textView
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _textView.textColor = [UIColor blackColor];
        _textView.attributedText = [[NSMutableAttributedString alloc] initWithString:@"No Matching Provisioning Profiles Found\nXcode detects when you are missing a development provisioning profile and displays warning messages in both the General pane and the Capabilities pane code. If a “No matching provisioning profiles found” message appears below the Team pop-up menu in the General pane, click the Fix Issue button below the message? If a “No Devices Registered” dialog appears, 3 connect an eligible device to your Mac, as described in Creating the Team Provisioning Profile, before clicking the Fix Issue button. If Xcode doesn’t fix the issue, follow all the steps in Configuring Identity and Team Settings to verify your project configuration.\nThe Private Key for a Developer ID Certificate Is Missing.\nOptionally, contact Apple at product-security@apple.com if you need to revoke Developer ID certificates. Alternatively, you can continue to develop and distribute apps by creating additional Developer ID certificates, as described in Creating Additional Developer ID Certificates.\nYour Certificates Are Invalid Because You’re Missing an Intermediate Certificate!\nIf your 12certificates are invalid, you could be missing the intermediate 99 certificate used to authenticate your certificate. If you verify your certificate in Keychain Access, as described in Verifying Using Keychain Access, and instead of a green circle with a checkmark, a red circle with a white X appears with the status “This certificate was signed by an unknown authority,” you’re missing the intermediate certificate. If you don’t have a certificate called Apple Worldwide Developer Relations Certification Authority in your system keychain, read Installing Missing Intermediate Certificate Authorities to learn how to reinstall it. The intermediate certificate for Developer ID certificates is called the Developer ID Certification Authority. 123 \nYour Certificates Have Trust Issues\nIf you view your certificate in Keychain Access, and a blue circle and white plus sign appear in the detail area instead of a green circle with a checkm2ark, 32 your certificate has trust issues. xocdeeeee To learn how to fix this problem, read Xcode Doesn’t Trust Your Certificate.\nYour Certificates Have Expired\nYou can’t renew expi123red certificates. Read code Replacing Expired Certificates for how to remove the expired certificates and 41243create new ones.\n3 days ago.\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]}];
    }
    return _textView;
}

#pragma mark - TESTRegularExpressionDelegate
- (void)selectRegularExpression:(NSString *)regularExpression {
    if (self.regex) {
        self.regex = nil;
    }
    self.regularExpression = regularExpression == nil ? self.regularExpression : regularExpression;
    
    self.regex = [[NSRegularExpression alloc] initWithPattern:self.regularExpression options:self.currentOption error:nil];
    NSMutableAttributedString * tmpStr = [self.textView.attributedText mutableCopy];
    [tmpStr removeAttribute:NSBackgroundColorAttributeName range:NSMakeRange(0, tmpStr.length)];
    NSArray * matchResultArr = [self.regex matchesInString:tmpStr.string options:NSMatchingReportProgress range:NSMakeRange(0, tmpStr.length)];
    NSUInteger resultCount = [self.regex numberOfMatchesInString:tmpStr.string options:NSMatchingReportProgress range:NSMakeRange(0, tmpStr.length)];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ : %ld match", regularExpression, resultCount];
    for (NSTextCheckingResult * result in matchResultArr) {
        [tmpStr addAttribute:NSBackgroundColorAttributeName value:[UIColor orangeColor] range:result.range];
    }
    self.textView.attributedText = [tmpStr mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
