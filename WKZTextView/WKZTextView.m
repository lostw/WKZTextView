//
//  ZTextView.m
//  Hejiajinrong
//
//  Created by william on 15/5/30.
//  Copyright (c) 2015年 Myth. All rights reserved.
//

#import "WKZTextView.h"
#import <QuartzCore/CALayer.h>

@interface WKZTextView()
@property (strong, nonatomic) CATextLayer *placeholderLayer;
@end

@implementation WKZTextView
@synthesize placeholderColor = _placeholderColor;
@synthesize placeholderFont = _placeholderFont;
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
    self.placeholderLayer.frame = CGRectMake(self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.top, self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2, self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom);
    [super layoutSubviews];
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
    [self wrapperPlaceholder];
}

- (void)wrapperPlaceholder
{
    if (self.placeholder.length) {
    self.placeholderLayer.string = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName: self.placeholderFont, NSForegroundColorAttributeName: self.placeholderColor}];
    }
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self wrapperPlaceholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    [self wrapperPlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self wrapperPlaceholder];

}

- (UIColor *)placeholderColor
{
    if (_placeholderColor) {
        return _placeholderColor;
    }
    
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
}

- (UIFont *)placeholderFont
{
    if (!_placeholderFont) {
        if (self.font) {
            return self.font;
        }
        
        return [UIFont systemFontOfSize:17];    //default textview font
    }
    
    return _placeholderFont;
}

- (CATextLayer *)placeholderLayer
{
    if (!_placeholderLayer) {
        _placeholderLayer = [CATextLayer layer];
//        _placeholderLayer.font = (__bridge CFTypeRef)self.placeholderFont;
//        _placeholderLayer.fontSize = self.placeholderFont.pointSize;
//        _placeholderLayer.foregroundColor = self.placeholderColor.CGColor;
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
