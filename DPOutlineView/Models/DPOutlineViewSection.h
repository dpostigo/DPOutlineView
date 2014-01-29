//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPOutlineViewItem;


@interface DPOutlineViewSection : NSObject

@property(nonatomic, copy) NSString *title;

- (instancetype) initWithTitle: (NSString *) aTitle items: (NSMutableArray *) anItems;
- (instancetype) initWithTitle: (NSString *) aTitle;
- (NSUInteger) itemCount;
- (DPOutlineViewItem *) itemAtIndex: (NSUInteger) index1;

- (NSUInteger) indexOfItem: (DPOutlineViewItem *) item;
- (void) addItem: (DPOutlineViewItem *) item;

- (void) insertItem: (DPOutlineViewItem *) item atIndex: (NSUInteger) index1;
- (void) removeItem: (DPOutlineViewItem *) item;
@end