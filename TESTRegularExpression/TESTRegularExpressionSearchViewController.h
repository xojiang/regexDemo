//
//  TESERegularExpressionSearchViewController.h
//  TESTRegularExpression
//
//  Created by xojiang on 16/4/17.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TESTRegularExpressionDelegate <NSObject>

@optional

- (void)selectRegularExpression:(NSString *)regularExpression;

@end

@interface TESTRegularExpressionSearchViewController : UIViewController

@property (nonatomic, weak) id<TESTRegularExpressionDelegate> delegate;

@end
