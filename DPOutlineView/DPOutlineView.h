//
// Created by Dani Postigo on 1/9/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPOutlineViewCore.h"


@class DPOutlineViewSection;

@interface DPOutlineView : DPOutlineViewCore <NSOutlineViewDelegate, NSOutlineViewDataSource> {
    BOOL fitsScrollViewToHeight;
    BOOL isExpanding;
    BOOL isAnimatingBackground;

}

@property(nonatomic) BOOL fitsScrollViewToHeight;
@property(nonatomic) BOOL isExpanding;
@property(nonatomic) BOOL isAnimatingBackground;

- (void) prepareDatasource;

- (CGFloat) outlineHeight;

@end