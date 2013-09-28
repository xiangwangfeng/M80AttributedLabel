//
//  M80AttributedLabelURL.h
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M80AttributedLabelURL : NSObject
@property (nonatomic,retain)    id      linkData;
@property (nonatomic,assign)    NSRange range;
@property (nonatomic,assign)    BOOL    underLine;
@property (nonatomic,retain)    UIColor *color;

+ (M80AttributedLabelURL *)urlWithLinkData: (id)linkData
                                     range: (NSRange)range
                             showUnderLine: (BOOL)underLine
                                     color: (UIColor *)color;


+ (NSArray *)detectLinks: (NSString *)plainText;

@end


