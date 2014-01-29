//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <DPOutlineView/DPTableCellView.h>
#import "DPOutlineViewItem.h"
#import "DPOutlineViewSection.h"

@implementation DPOutlineViewItem {
    NSString *title;
    NSString *subtitle;
    NSImage *image;
    NSString *identifier;
}

@synthesize title;
@synthesize subtitle;
@synthesize image;
@synthesize identifier;
@synthesize section;

- (instancetype) initWithTitle: (NSString *) aTitle {
    return [self initWithTitle: aTitle image: nil];
}


- (instancetype) initWithTitle: (NSString *) aTitle subtitle: (NSString *) aSubtitle image: (NSImage *) anImage {
    return [self initWithTitle: aTitle subtitle: aSubtitle image: anImage identifier: nil];
}

- (instancetype) initWithTitle: (NSString *) aTitle image: (NSImage *) anImage {
    return [self initWithTitle: aTitle subtitle: nil image: anImage identifier: nil];
}

- (instancetype) initWithTitle: (NSString *) aTitle identifier: (NSString *) anIdentifier {
    return [self initWithTitle: aTitle subtitle: nil image: nil identifier: anIdentifier];
}

- (instancetype) initWithTitle: (NSString *) aTitle subtitle: (NSString *) aSubtitle image: (NSImage *) anImage identifier: (NSString *) anIdentifier {
    self = [super init];
    if (self) {
        title = aTitle;
        subtitle = aSubtitle;
        image = anImage;
        identifier = anIdentifier;
    }

    return self;
}

- (instancetype) initWithTitle: (NSString *) aTitle image: (NSImage *) anImage identifier: (NSString *) anIdentifier {
    return [self initWithTitle: aTitle subtitle: nil image: anImage identifier: anIdentifier];
}

- (NSUInteger) itemIndex {
    return self.section ? [self.section indexOfItem: self] : -1;
}


- (void) removeFromSection {
    if (self.section) {
        [self.section removeItem: self];
    }
}
@end
