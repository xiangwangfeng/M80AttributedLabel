//
//  NSMutableAttributedString+M80.h
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 www.xiangwangfeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (M80)

- (void)m80_setTextColor:(UIColor*)color;
- (void)m80_setTextColor:(UIColor*)color range:(NSRange)range;

- (void)m80_setFont:(UIFont*)font;
- (void)m80_setFont:(UIFont*)font range:(NSRange)range;

- (void)m80_setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier;
- (void)m80_setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range;

@end
