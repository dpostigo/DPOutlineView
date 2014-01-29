//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import "DPOutlineViewCore.h"
#import "DPOutlineViewSection.h"
#import "DPOutlineViewItem.h"
#import "NSOutlineView+Insertion.h"

@implementation DPOutlineViewCore {
    NSMutableArray *sections;
}

@synthesize autoExpands;
@synthesize outlineDelegate;
@synthesize allowsSelection;
@synthesize expandedHeight;
@synthesize unexpandedHeight;
@synthesize sections;

@synthesize cellStorage;

@synthesize rowViewClass;

@synthesize dragsItems;
@synthesize dragsSections;

@synthesize draggingItems;
@synthesize isAwake;
#define LOCAL_REORDER_PASTEBOARD_TYPE @"MyCustomOutlineViewPboardType"
//#define LOCAL_REORDER_PASTEBOARD_TYPE @"MyCustomOutlineViewPboardType"

- (void) awakeFromNib {
    [super awakeFromNib];

    isAwake = YES;
    autoExpands = YES;
    [self awakeCells];

    super.dataSource = self;
    super.delegate = self;

}


- (void) awakeCells {
    cellStorage = [[NSObject alloc] init];
    NSView *ret = nil;
    ret = [self makeViewWithIdentifier: @"HeaderCell" owner: self.cellStorage];
    ret = [self makeViewWithIdentifier: @"DataCell" owner: self.cellStorage];
}


- (void) clearSections {
    [self.sections removeAllObjects];
}

- (DPOutlineViewSection *) sectionAtIndex: (NSUInteger) index {
    DPOutlineViewSection *ret = nil;
    if ([self.sections count] > index) {
        ret = [self.sections objectAtIndex: index];
    }
    return ret;
}

- (void) addSection: (DPOutlineViewSection *) section {
    [self.sections addObject: section];
}

- (NSUInteger) sectionCount {
    return [self.sections count];
}

- (NSMutableArray *) sections {
    if (sections == nil) {
        sections = [[NSMutableArray alloc] init];
    }
    return sections;
}


#pragma mark Delegate


- (id <NSPasteboardWriting>) outlineView: (NSOutlineView *) outlineView pasteboardWriterForItem: (id) item {
    id <NSPasteboardWriting> ret = nil;
    if (self.dragsItems && [item isKindOfClass: [DPOutlineViewItem class]]) {
        ret = [item title];
    } else if (self.dragsSections && [item isKindOfClass: [DPOutlineViewSection class]]) {
        ret = [item title];
    }
    return ret;
}

- (void) outlineView: (NSOutlineView *) outlineView draggingSession: (NSDraggingSession *) session willBeginAtPoint: (NSPoint) screenPoint forItems: (NSArray *) draggedItems {
    draggingItems = draggedItems;
    [session.draggingPasteboard setData: [NSData data] forType: LOCAL_REORDER_PASTEBOARD_TYPE];
}

- (void) outlineView: (NSOutlineView *) outlineView draggingSession: (NSDraggingSession *) session endedAtPoint: (NSPoint) screenPoint operation: (NSDragOperation) operation {

}

- (void) outlineView: (NSOutlineView *) outlineView updateDraggingItemsForDrag: (id <NSDraggingInfo>) draggingInfo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (NSDragOperation) outlineView: (NSOutlineView *) outlineView validateDrop: (id <NSDraggingInfo>) info proposedItem: (id) item proposedChildIndex: (NSInteger) childIndex {

    //    NSLog(@"info.draggingSource = %@", info.draggingSource);
    //    id<NSDraggingInfo> info = info;

    NSDragOperation ret = 0;

    if (childIndex != -1) {
        //        ret = NSDragOperationMove;


    }

    //    if ([item isKindOfClass: [DPOutlineViewSection class]]) {
    //        NSLog(@"childIndex = %li", childIndex);
    //    }
    //    if ([item isKindOfClass: [DPOutlineViewItem class]]) {
    //        NSLog(@"childIndex = %li", childIndex);
    //    }

    if ([item isKindOfClass: [DPOutlineViewItem class]]) {
        //        NSLog(@"DPOutlineViewItem, index = %li", childIndex);
        if (childIndex == -1) {

        }

    } else if ([item isKindOfClass: [DPOutlineViewSection class]]) {
        NSLog(@"DPOutlineViewSection, index = %li", childIndex);
        ret = NSDragOperationMove;
        if (childIndex == -1) {
            //NSUInteger newIndex = [item itemCount];
            //            [self setDropItem: item dropChildIndex: newIndex];
        }
    }
    else if (item == nil) {
        if (childIndex == -1) {

        } else {
            NSLog(@"nil, index = %li", childIndex);
            ret = NSDragOperationMove;
        }

    }

    return ret;
}

- (BOOL) outlineView: (NSOutlineView *) outlineView acceptDrop: (id <NSDraggingInfo>) info item: (id) item childIndex: (NSInteger) newIndex {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);

    //    NSLog(@"info = %@", info);
    //    NSLog(@"item = %@", item);

    NSLog(@"%s, index = %li, item = %@", __PRETTY_FUNCTION__, newIndex, item);

    for (DPOutlineViewItem *draggedItem in draggingItems) {

        NSInteger origIndex = -1;
        DPOutlineViewSection *origSection;

        NSInteger insertIndex = -1;
        DPOutlineViewSection *insertSection;

        origIndex = [draggedItem itemIndex];
        origSection = [draggedItem section];

        if (item == nil) {
            insertSection = [self sectionAtIndex: newIndex - 1];
            insertIndex = [insertSection itemCount];

            [self beginUpdates];

            [draggedItem removeFromSection];
            [insertSection addItem: draggedItem];
            [self insertItemAtIndex: insertIndex inParent: insertSection withAnimation: NSTableViewAnimationEffectGap];
            [self removeItemAtIndex: origIndex inParent: origSection withAnimation: NSTableViewAnimationEffectGap];

            [self endUpdates];

        } else {
            NSLog(@"Moving item.");
            insertSection = item;
            insertIndex = newIndex;

            [self beginUpdates];

            [draggedItem removeFromSection];
            [insertSection insertItem: draggedItem atIndex: insertIndex];
            [self moveItemAtIndex: origIndex inParent: origSection toIndex: insertIndex inParent: insertSection];

            [self endUpdates];

        }

    }

    return YES;
}
//
//- (BOOL) outlineView: (NSOutlineView *) outlineView writeItems: (NSArray *) items toPasteboard: (NSPasteboard *) pasteboard {
//    //    NSLog(@"%s", __PRETTY_FUNCTION__);
//    return NO;
//}


#pragma mark Dragging

- (void) setDragsItems: (BOOL) dragsItems1 {
    dragsItems = dragsItems1;
    [self updateDragTypes];

}

- (void) setDragsSections: (BOOL) dragsSections1 {
    dragsSections = dragsSections1;
}

- (void) updateDragTypes {
    NSMutableArray *draggingTypes = [NSMutableArray arrayWithArray: self.registeredDraggedTypes];

    if (dragsItems && ![draggingTypes containsObject: LOCAL_REORDER_PASTEBOARD_TYPE]) {
        [draggingTypes addObject: LOCAL_REORDER_PASTEBOARD_TYPE];
    } else if (!dragsItems && [draggingTypes containsObject: LOCAL_REORDER_PASTEBOARD_TYPE]) {
        [draggingTypes removeObject: LOCAL_REORDER_PASTEBOARD_TYPE];
    }

    [self registerForDraggedTypes: draggingTypes];
}


- (id <DPOutlineViewDelegate>) outlineDelegate {
    return self.isAwake ? outlineDelegate : nil;
}

@end