//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "DPOutlineViewSection.h"
#import "DPOutlineViewItem.h"

@interface DPOutlineViewSection ()

@property(nonatomic, strong) NSMutableArray *items;

@end


@implementation DPOutlineViewSection {
    NSString *title;
    NSMutableArray *items;
}

@synthesize title;
@synthesize items;

- (instancetype) initWithTitle: (NSString *) aTitle items: (NSMutableArray *) anItems {
    self = [super init];
    if (self) {
        title = aTitle;
        items = [NSMutableArray arrayWithArray: anItems];
    }

    return self;
}


- (instancetype) initWithTitle: (NSString *) aTitle {
    return [self initWithTitle: aTitle items: nil];
}

- (NSUInteger) itemCount {
    return [self.items count];
}

- (DPOutlineViewItem *) itemAtIndex: (NSUInteger) index {
    return [self.items objectAtIndex: index];
}

- (NSUInteger) indexOfItem: (DPOutlineViewItem *) item {
    return [self.items indexOfObject: item];
}

- (void) addItem: (DPOutlineViewItem *) item {
    item.section = self;
    [self.items addObject: item];
}


- (void) insertItem: (DPOutlineViewItem *) item atIndex: (NSUInteger) index {
    item.section = self;
    [self.items insertObject: item atIndex: index];
}

- (void) removeItem: (DPOutlineViewItem *) item {
    item.section = nil;
    if ([self.items containsObject: item]) {
        [self.items removeObject: item];
    }
}

@end
