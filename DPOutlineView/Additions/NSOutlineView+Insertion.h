//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOutlineView (Insertion)

- (void) insertItemAtIndex: (NSInteger) index1 inParent: (id) parent withAnimation: (NSTableViewAnimationOptions) animationOptions;
- (void) removeItemAtIndex: (NSInteger) index1 inParent: (id) parent;
- (void) removeItemAtIndex: (NSInteger) index1 inParent: (id) parent withAnimation: (NSTableViewAnimationOptions) animationOptions;
@end