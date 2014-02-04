//
// Created by Dani Postigo on 1/11/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "DPOutlineView.h"
#import "DPTableCellView.h"
#import "NSTableCellView+DPKit.h"

@implementation DPTableCellView

@synthesize detailTextLabel;
@synthesize textLabel;

@synthesize button;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return self;
}


- (void) setButton: (NSButton *) button1 {
    button = button1;
    if (button) {
        button.target = self;
        button.action = @selector(buttonClicked:);
    }
}

- (void) buttonClicked: (id) sender {

    if ([self.outlineView isKindOfClass: [DPOutlineView class]]) {
        DPOutlineView *outline = (DPOutlineView *) self.outlineView;
        [outline buttonClicked: sender inItem: self];
    }

}


@end