//
//  M80AttributedLabelURL.h
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 www.xiangwangfeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M80AttributedLabelDefines.h"


@interface M80AttributedLabelURL : NSObject
@property (nonatomic,strong)    id      linkData;
@property (nonatomic,assign)    NSRange range;
@property (nonatomic,strong)    UIColor *color;

+ (M80AttributedLabelURL *)urlWithLinkData:(id)linkData
                                     range:(NSRange)range
                                     color:(UIColor *)color;


+ (NSArray *)detectLinks:(NSString *)plainText;

+ (void)setCustomDetectMethod:(M80CustomDetectLinkBlock)block;
@end


