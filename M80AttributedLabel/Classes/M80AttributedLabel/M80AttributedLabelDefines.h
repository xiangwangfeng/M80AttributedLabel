//
//  M80AttributedLabelDefines.h
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 www.xiangwangfeng.com. All rights reserved.
//

#ifndef M80AttributedLabel_M80AttributedLabelDefines_h
#define M80AttributedLabel_M80AttributedLabelDefines_h

typedef enum
{
    M80ImageAlignmentTop,
    M80ImageAlignmentCenter,
    M80ImageAlignmentBottom
} M80ImageAlignment;

@class M80AttributedLabel;

@protocol M80AttributedLabelDelegate <NSObject>
- (void)m80AttributedLabel:(M80AttributedLabel *)label
             clickedOnLink:(id)linkData;

@end

typedef NSArray *(^M80CustomDetectLinkBlock)(NSString *text);

//如果文本长度小于这个值,直接在UI线程做Link检测,否则都dispatch到共享线程
#define M80MinAsyncDetectLinkLength 50

#define M80IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)

#endif
