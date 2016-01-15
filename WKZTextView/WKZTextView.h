//
//  ZTextView.h
//  Hejiajinrong
//
//  Created by william on 15/5/30.
//  Copyright (c) 2015年 Myth. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface WKZTextView : UITextView
@property (strong, nonatomic) IBInspectable NSString *placeholder;
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;
@end
