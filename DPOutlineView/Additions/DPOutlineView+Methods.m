//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "DPOutlineView+Methods.h"

@implementation DPOutlineView (Methods)

- (void) expandAllItems {
    for (int j = 0; j < [self sectionCount]; j++) {
        [self expandItem: [self sectionAtIndex: j]];
    }
}



@end