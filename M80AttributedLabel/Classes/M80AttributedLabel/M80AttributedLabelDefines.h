//
//  M80AttributedLabelDefines.h
//  M80AttributedLabel
//
//  Created by amao on 13-8-31.
//  Copyright (c) 2013年 Netease. All rights reserved.
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
- (void)attributedLabel: (M80AttributedLabel *)label
          clickedOnLink: (id)linkData;

@end

#endif
