//
//  M80AttributedLabelConfig.m
//  M80AttributedLabel
//
//  Created by amao on 2019/2/14.
//

#import "M80AttributedLabelConfig.h"

@implementation M80AttributedLabelConfig
+ (instancetype)shared
{
    static M80AttributedLabelConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [M80AttributedLabelConfig new];
    });
    return instance;
}
@end
