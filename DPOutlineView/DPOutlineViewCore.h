//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPOutlineViewDelegate.h"

@class DPOutlineViewSection;

@interface DPOutlineViewCore : NSOutlineView <NSOutlineViewDataSource, NSOutlineViewDelegate> {

    BOOL isAwake;
    BOOL allowsSelection;
    BOOL autoExpands;
    BOOL dragsItems;
    BOOL dragsSections;
    NSObject *cellStorage;
    CGFloat expandedHeight;
    id <DPOutlineViewDelegate> outlineDelegate;
    CGFloat unexpandedHeight;

    __strong Class rowViewClass;

    NSArray *draggingItems;
}

@property(nonatomic, strong) id <DPOutlineViewDelegate> outlineDelegate;
@property(nonatomic) BOOL autoExpands;
@property(nonatomic) BOOL allowsSelection;
@property(nonatomic) CGFloat expandedHeight;
@property(nonatomic) CGFloat unexpandedHeight;
@property(nonatomic, strong) NSMutableArray *sections;


@property(nonatomic, strong) NSObject *cellStorage;
@property(nonatomic, strong) Class rowViewClass;


@property(nonatomic) BOOL dragsItems;
@property(nonatomic) BOOL dragsSections;
@property(nonatomic, strong) NSArray *draggingItems;
@property(nonatomic) BOOL isAwake;
- (void) clearSections;
- (NSUInteger) sectionCount;

- (void) addSection: (DPOutlineViewSection *) section;
- (DPOutlineViewSection *) sectionAtIndex: (NSUInteger) index1;


@end