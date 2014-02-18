//
//  M80AttributedLabelURL.m
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import "M80AttributedLabelURL.h"

static NSString *urlExpression = @"((([A-Za-z]{3,9}:(?:\\/\\/)?)(?:[\\-;:&=\\+\\$,\\w]+@)?[A-Za-z0-9\\.\\-]+|(?:www\\.|[\\-;:&=\\+\\$,\\w]+@)[A-Za-z0-9\\.\\-]+)((:[0-9]+)?)((?:\\/[\\+~%\\/\\.\\w\\-]*)?\\??(?:[\\-\\+=&;%@\\.\\w]*)#?(?:[\\.\\!\\/\\\\\\w]*))?)";

@implementation M80AttributedLabelURL


+ (M80AttributedLabelURL *)urlWithLinkData: (id)linkData
                                     range: (NSRange)range
                                     color: (UIColor *)color
{
    M80AttributedLabelURL *url  = [[M80AttributedLabelURL alloc]init];
    url.linkData                = linkData;
    url.range                   = range;
    url.color                   = color;
    return url;
    
}


+ (NSArray *)detectLinks: (NSString *)plainText
{
    NSMutableArray *links = nil;
    if ([plainText length])
    {
        links = [NSMutableArray array];
        NSRegularExpression *urlRegex = [NSRegularExpression regularExpressionWithPattern:urlExpression
                                                                                  options:NSRegularExpressionCaseInsensitive
                                                                                    error:nil];
        [urlRegex enumerateMatchesInString:plainText
                                   options:0
                                     range:NSMakeRange(0, [plainText length])
                                usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                    NSRange range = result.range;
                                    NSString *text = [plainText substringWithRange:range];
                                    M80AttributedLabelURL *link = [M80AttributedLabelURL urlWithLinkData:text
                                                                                                   range:range
                                                                                                   color:nil];
                                    [links addObject:link];
                             }];
    }
    return links;
}

@end
