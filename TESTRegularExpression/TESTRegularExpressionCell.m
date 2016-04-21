//
//  TESTRegularExpressionCell.m
//  TESTRegularExpression
//
//  Created by renren on 16/4/20.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import "TESTRegularExpressionCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

const CGFloat cellHeight = 50.f;

@interface TESTRegularExpressionCell ()

@property (nonatomic, strong) UILabel * optionLabel;
@property (nonatomic, strong) UISwitch * optionSwitch;
@property (nonatomic, assign) NSInteger row;

@end

@implementation TESTRegularExpressionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.optionLabel = [[UILabel alloc] init];
    self.optionLabel.font = [UIFont systemFontOfSize:15.f weight:UIFontWeightLight];
    self.optionLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.optionLabel];
    
    self.optionSwitch = [[UISwitch alloc] init];
    self.optionSwitch.center = CGPointMake(SCREEN_WIDTH - 60.f, cellHeight / 2.f);
    [self.optionSwitch addTarget:self action:@selector(changeOption) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.optionSwitch];
}

- (void)setUpOption:(BOOL)optionOn row:(NSInteger)row {
    _row = row;
    NSString * optionName = nil;
    switch (row) {
        case 0:
            optionName = @"CaseInsensitive";
            break;
        case 1:
            optionName = @"AllowCommentsAndWhitespace";
            break;
        case 2:
            optionName = @"IgnoreMetacharacters";
            break;
        case 3:
            optionName = @"DotMatchesLineSeparators";
            break;
        case 4:
            optionName = @"AnchorsMatchLines";
            break;
        case 5:
            optionName = @"UseUnixLineSeparators";
            break;
        case 6:
            optionName = @"UseUnicodeWordBoundaries";
            break;
        default:
            break;
    }
    self.optionLabel.text = optionName;
    [self.optionLabel sizeToFit];
    self.optionLabel.center = CGPointMake(self.optionLabel.frame.size.width / 2.f + 20.f, cellHeight / 2.f);
    self.optionSwitch.on = optionOn;
}

- (void)changeOption {
    if (self.block) {
        self.block(_row);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
