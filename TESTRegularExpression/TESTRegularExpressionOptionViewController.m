//
//  TESTRegularExpressionOptionViewController.m
//  TESTRegularExpression
//
//  Created by renren on 16/4/20.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import "TESTRegularExpressionOptionViewController.h"
#import "TESTRegularExpressionCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface TESTRegularExpressionOptionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * optionArr;

@end

@implementation TESTRegularExpressionOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view.
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"TESTIdentifier";
    NSInteger row = indexPath.row;
    NSRegularExpressionOptions option = ((NSNumber *)(self.optionArr[row])).integerValue;
    TESTRegularExpressionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TESTRegularExpressionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.block = ^(NSInteger selectedRow) {
            NSRegularExpressionOptions selectedOption = ((NSNumber *)(self.optionArr[selectedRow])).integerValue;
            NSRegularExpressionOptions changedOption = 0;
            if (weakSelf.currentOption & selectedOption) {
                changedOption = weakSelf.currentOption - selectedOption;
            }
            else {
                changedOption = weakSelf.currentOption | selectedOption;
            }
            weakSelf.currentOption = changedOption;
            if (weakSelf.block) {
                weakSelf.block(changedOption);
            }
        };
    }
    [cell setUpOption:(self.currentOption & option) row:row];
    return cell;
}

- (NSMutableArray *)optionArr {
    if (_optionArr == nil) {
        _optionArr = [NSMutableArray array];
        
        [_optionArr addObject:@(NSRegularExpressionCaseInsensitive)];
        [_optionArr addObject:@(NSRegularExpressionAllowCommentsAndWhitespace)];
        [_optionArr addObject:@(NSRegularExpressionIgnoreMetacharacters)];
        [_optionArr addObject:@(NSRegularExpressionDotMatchesLineSeparators)];
        [_optionArr addObject:@(NSRegularExpressionAnchorsMatchLines)];
        [_optionArr addObject:@(NSRegularExpressionUseUnixLineSeparators)];
        [_optionArr addObject:@(NSRegularExpressionUseUnicodeWordBoundaries)];
    }
    return _optionArr;
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
