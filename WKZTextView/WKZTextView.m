//
//  WKZTextView.m
//  Hejiajinrong
//
//  Created by lostw on 15/5/30.
//  Copyright (c) 2015年 Myth. All rights reserved.
//

#import "WKZTextView.h"
#import <QuartzCore/CALayer.h>

@interface WKZTextView()
@property (strong, nonatomic) CATextLayer *placeholderLayer;
@end

@implementation WKZTextView
@synthesize placeholderColor = _placeholderColor;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextChange:) name:UITextViewTextDidChangeNotification object:self];

    [self.layer insertSublayer:self.placeholderLayer atIndex:0];

}


- (void)layoutSubviews
{
    self.placeholderLayer.frame = CGRectMake(4, 8, self.bounds.size.width - 8, self.bounds.size.height - 16);
}

- (void)onTextChange:(NSNotification*) notification {
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    self.placeholderLayer.hidden = (self.text.length > 0);
//    [CATransaction commit];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLayer.string = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLayer.foregroundColor = placeholderColor.CGColor;
}

- (UIColor *)placeholderColor
{
    if (_placeholderColor) {
        return _placeholderColor;
    }
    
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
}

- (CATextLayer *)placeholderLayer
{
    if (!_placeholderLayer) {
        _placeholderLayer = [CATextLayer layer];
        _placeholderLayer.font = (__bridge CFTypeRef)([UIFont systemFontOfSize:12]);
        _placeholderLayer.fontSize = 14;
        _placeholderLayer.truncationMode = @"end";
        _placeholderLayer.wrapped = YES;
        _placeholderLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    
    return _placeholderLayer;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
