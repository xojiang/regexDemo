//
//  TESERegularExpressionSearchViewController.m
//  TESTRegularExpression
//
//  Created by xojiang on 16/4/17.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import "TESTRegularExpressionSearchViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface TESTRegularExpressionSearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * regularExpressionArr;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation TESTRegularExpressionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view.
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20.f) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.regularExpressionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSString * regularExpression = (NSString *)self.regularExpressionArr[row];
    static NSString * const identifier = @"TESTIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = regularExpression;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSString * regularExpression = (NSString *)self.regularExpressionArr[row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectRegularExpression:)]) {
        [self.delegate selectRegularExpression:regularExpression];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)regularExpressionArr {
    if (_regularExpressionArr == nil) {
        _regularExpressionArr = @[@"^O",
                                  @"\\.$",
                                  @"[0-9]",
                                  @"[a-z]",
                                  @"^[a-z]",
                                  @"^[0-9]",
                                  @"[^\\s]",
                                  @".",
                                  @"^.",
                                  @".$",
                                  @"Doesn’t",
                                  @"doesn’t",
                                  @"(D|d)oesn’t",
                                  @"x?code",
                                  @"[1-9]+",
                                  @"p+",
                                  @"ap*",
                                  @"ap+",
                                  @"ap{1}",
                                  @"ap{1,}",
                                  @"e{2,4}",
                                  @"[a-df-z](?:ee)",
                                  @"\\w(?=ee)",
                                  @"\\w(?!ee)",
                                  @"(?<=ee)\\w",
                                  @"(?<!ee)\\w"];
    }
    return _regularExpressionArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
