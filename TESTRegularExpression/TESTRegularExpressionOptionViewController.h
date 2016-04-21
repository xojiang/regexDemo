//
//  TESTRegularExpressionOptionViewController.h
//  TESTRegularExpression
//
//  Created by renren on 16/4/20.
//  Copyright © 2016年 TEST. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TESTRegularExpressionOptionBlock)(NSRegularExpressionOptions currentOption);

@interface TESTRegularExpressionOptionViewController : UIViewController

@property (nonatomic, assign) NSRegularExpressionOptions currentOption;
@property (nonatomic, copy) TESTRegularExpressionOptionBlock block;

@end
