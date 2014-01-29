//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "NSOutlineView+Insertion.h"

@implementation NSOutlineView (Insertion)

- (id) firstItem {
    return [self itemAtRow: 0];
}

- (void) insertItemAtIndex: (NSInteger) index inParent: (id) parent withAnimation: (NSTableViewAnimationOptions) animationOptions {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex: index];
    [self insertItemsAtIndexes: indexSet inParent: parent withAnimation: animationOptions];
}


- (void) removeItemAtIndex: (NSInteger) index inParent: (id) parent {
    [self removeItemAtIndex: index inParent: parent withAnimation: NSTableViewAnimationEffectGap];
}

- (void) removeItemAtIndex: (NSInteger) index inParent: (id) parent withAnimation: (NSTableViewAnimationOptions) animationOptions {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex: index];
    [self removeItemsAtIndexes: indexSet inParent: parent withAnimation: animationOptions];
}


@end