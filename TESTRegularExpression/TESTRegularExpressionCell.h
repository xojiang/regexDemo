//
//  TESTRegularExpressionCell.h
//  TESTRegularExpression
//
//  Created by renren on 16/4/20.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat cellHeight;

typedef void(^TESTRegularExpressionCellBlock)(NSInteger row);

@interface TESTRegularExpressionCell : UITableViewCell

@property (nonatomic, copy) TESTRegularExpressionCellBlock block;

- (void)setUpOption:(BOOL)optionOn row:(NSInteger)row;

@end
