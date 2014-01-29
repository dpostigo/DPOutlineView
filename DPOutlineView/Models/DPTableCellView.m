//
// Created by Dani Postigo on 1/11/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "DPTableCellView.h"

@implementation DPTableCellView

@synthesize detailTextLabel;
@synthesize textLabel;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {

        self.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return self;
}


@end