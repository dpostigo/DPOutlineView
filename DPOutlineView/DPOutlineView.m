//
// Created by Dani Postigo on 1/9/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <DPOutlineView/DPTableCellView.h>
#import "DPOutlineView.h"
#import "DPOutlineView+ItemUtils.h"
#import "NSObject+CallSelector.h"
#import "DPOutlineViewItem.h"
#import "DPOutlineView+Methods.h"
#import "DPOutlineViewSection.h"
#import "NSView+DPFrameUtils.h"

@implementation DPOutlineView

@synthesize fitsScrollViewToHeight;
@synthesize isExpanding;
@synthesize isAnimatingBackground;

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        allowsSelection = YES;
    }

    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];

    self.floatsGroupRows = NO;

}


- (void) reloadData {
    [self callSelector: @selector(prepareDatasource) object: nil];
    [self prepareDatasource];
    [super reloadData];

    if (autoExpands) {
        [self expandAllItems];
        [self expandBackground];
    }

    if (fitsScrollViewToHeight) {
        //        [self fitScrollViewToHeight];
    }

    [self callSelector: @selector(outlineViewDidReload) object: nil];
}


- (void) prepareDatasource {

}



#pragma mark Height



- (BOOL) isExpanded {
    return [self isItemExpanded: self.firstItem];
}

- (CGFloat) outlineHeight {
    CGFloat ret = 0;

    for (int j = 0; j < self.numberOfRows; j++) {
        NSRect rowRect = [self rectOfRow: j];
        //        NSLog(@"rowRect at %i = %@", j, NSStringFromRect(rowRect));
        ret += rowRect.size.height;
    }

    if (self.numberOfRows > 0) {
        NSRect lastRect = [self rectOfRow: self.numberOfRows - 1];
        //        NSLog(@"lastRect = %@", NSStringFromRect(lastRect));
        ret = lastRect.origin.y + lastRect.size.height;
    }
    return ret;
}

- (NSLayoutConstraint *) scrollViewHeightConstraint {
    NSLayoutConstraint *ret = nil;
    NSArray *constraints = [NSArray arrayWithArray: self.enclosingScrollView.constraints];
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            ret = constraint;
            break;

        }
    }
    return ret;
}


- (CGFloat) expandedHeight {
    if (expandedHeight == 0 && self.isExpanded) {
        expandedHeight = self.outlineHeight;
    }
    return expandedHeight;
}





#pragma mark Collapse / expand background

- (CGFloat) backgroundAnimationDuration {
    return 0.25;
}

- (void) expandBackground {
    if (self.fitsScrollViewToHeight && !self.isAnimatingBackground) {

        if (self.expandedHeight > 0) {
            NSLayoutConstraint *constraint = self.scrollViewHeightConstraint;
            if (constraint) {
                isAnimatingBackground = YES;
                [NSAnimationContext runAnimationGroup: ^(NSAnimationContext *context) {
                    context.duration = self.backgroundAnimationDuration - 0.05;
                    [constraint.animator setConstant: expandedHeight];

                } completionHandler: ^() {
                    isAnimatingBackground = NO;
                }];
            }

        } else {

        }
    }
}

- (void) collapseBackground {
    if (self.fitsScrollViewToHeight && !self.isAnimatingBackground) {
        NSLayoutConstraint *constraint = self.scrollViewHeightConstraint;
        if (constraint && unexpandedHeight > 0) {
            isAnimatingBackground = YES;
            [NSAnimationContext runAnimationGroup: ^(NSAnimationContext *context) {
                context.duration = self.backgroundAnimationDuration;
                //                context.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
                [constraint.animator setConstant: unexpandedHeight];

            } completionHandler: ^() {
                //                NSLog(@"Did collapse background.");
                isAnimatingBackground = NO;
            }];
        }
    }
}


- (NSString *) animationInfoString: (CGFloat) heightValue {
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    //    [strings addObject: @"{"];
    if (heightValue > 0) [strings addObject: [NSString stringWithFormat: @"\t\theightValue = %f", heightValue]];
    [strings addObject: [NSString stringWithFormat: @"\t\tself.height = %f", self.height]];
    [strings addObject: [NSString stringWithFormat: @"\t\tself.isExpanded = %d", self.isExpanded]];
    [strings addObject: [NSString stringWithFormat: @"\t\tself.numberOfRows = %li", self.numberOfRows]];
    [strings addObject: [NSString stringWithFormat: @"\t\tself.outlineHeight = %f", self.outlineHeight]];
    [strings addObject: [NSString stringWithFormat: @"\t\t[self rectOfRow: lastRow] = %@", NSStringFromRect([self rectOfRow: self.numberOfRows - 1])]];
    //    [strings addObject: @"}"];
    NSString *logString = [strings componentsJoinedByString: @", "];
    return logString;
}










#pragma mark NSOutlineViewDataSource

- (NSInteger) outlineView: (NSOutlineView *) outlineView numberOfChildrenOfItem: (id) item {
    return item == nil ? [self.sections count] : [((DPOutlineViewSection *) item) itemCount];
}

- (id) outlineView: (NSOutlineView *) outlineView child: (NSInteger) index ofItem: (id) item {
    return item == nil ? [self sectionAtIndex: (NSUInteger) index] : [((DPOutlineViewSection *) item) itemAtIndex: (NSUInteger) index];
}

- (BOOL) outlineView: (NSOutlineView *) outlineView isItemExpandable: (id) item {
    return [item isKindOfClass: [DPOutlineViewSection class]] ? [item itemCount] > 0 : NO;
}

- (id) outlineView: (NSOutlineView *) outlineView objectValueForTableColumn: (NSTableColumn *) tableColumn byItem: (id) item {
    return [item isKindOfClass: [DPOutlineViewSection class]] ? [item title] : item;
}



#pragma mark Cells

- (NSView *) outlineView: (NSOutlineView *) outlineView viewForTableColumn: (NSTableColumn *) tableColumn item: (id) item {

    NSView *ret = nil;
    if ([item isKindOfClass: [DPOutlineViewSection class]]) {
        ret = [outlineView makeViewWithIdentifier: @"HeaderCell" owner: self.cellStorage];
        [self willDisplayHeader: (NSTableCellView *) ret forSection: item];
    } else {
        ret = [outlineView makeViewWithIdentifier: @"DataCell" owner: self.cellStorage];
        [self willDisplayCell: (NSTableCellView *) ret forItem: item];
    }

    return ret;
}


- (void) willDisplayHeader: (NSTableCellView *) cellView forSection: (DPOutlineViewSection *) section {
    if ([cellView isKindOfClass: [DPTableCellView class]]) {
        [self willDisplayTableHeader: (DPTableCellView *) cellView forSection: section];
    }
    [self callSelector: @selector(willDisplayHeader:forSection:) object: cellView object: section];

}

- (void) willDisplayTableHeader: (DPTableCellView *) cellView forSection: (DPOutlineViewSection *) section {
    [self callSelector: @selector(willDisplayTableHeader:forSection:) object: cellView object: section];

}


- (void) willDisplayCell: (NSTableCellView *) cellView forItem: (DPOutlineViewItem *) item {
    if ([cellView isKindOfClass: [DPTableCellView class]]) {
        [self willDisplayTableCellView: (DPTableCellView *) cellView forItem: item];
    }
    [self callSelector: @selector(willDisplayCell:forItem:) object: cellView object: item];

}


- (void) willDisplayTableCellView: (DPTableCellView *) cellView forItem: (DPOutlineViewItem *) item {
    [self callSelector: @selector(willDisplayTableCellView:forItem:) object: cellView object: item];

}




#pragma mark Expansion

- (void) outlineViewItemWillCollapse: (NSNotification *) notification {
    expandedHeight = self.outlineHeight;
    [self collapseBackground];

    [self callSelector: @selector(outlineViewItemWillCollapse:) object: notification];
}

- (void) outlineViewItemDidCollapse: (NSNotification *) notification {
    unexpandedHeight = self.outlineHeight;
    [self collapseBackground];

    [self callSelector: @selector(outlineViewItemDidCollapse:) object: notification];
}

- (void) outlineViewItemWillExpand: (NSNotification *) notification {
    [self expandBackground];

    [self callSelector: @selector(outlineViewItemWillExpand:) object: notification];
}


- (void) outlineViewItemDidExpand: (NSNotification *) notification {
    [self expandBackground];

    [self callSelector: @selector(outlineViewItemDidExpand:) object: notification];
}





#pragma mark Row views

- (NSTableRowView *) outlineView: (NSOutlineView *) outlineView rowViewForItem: (id) item {
    NSTableRowView *ret = [self rowViewForItem: item];
    return ret;
}


- (NSTableRowView *) rowViewForItem: (id) item {
    NSTableRowView *ret = nil;
    if (self.outlineDelegate && [self.outlineDelegate respondsToSelector: @selector(rowViewForItem:)]) {
        ret = [outlineDelegate rowViewForItem: item];
    } else if (self.rowViewClass) {
        ret = [[self.rowViewClass alloc] init];
    }
    return ret;
}

- (void) didAddRowView: (NSTableRowView *) rowView forRow: (NSInteger) row {
    [super didAddRowView: rowView forRow: row];

    id item = [self itemAtRow: row];
    if ([item isKindOfClass: [DPOutlineViewSection class]]) {
        [self didAddRowView: rowView forSection: item];
    } else {
        [self didAddRowView: rowView forItem: item];
    }
}

//
//- (NSRect) frameOfOutlineCellAtRow: (NSInteger) row {
//    return NSZeroRect;
////    NSLog(@"%s", __PRETTY_FUNCTION__);
////    NSRect ret = [super frameOfOutlineCellAtRow: row];
////
////    ret.origin.x = 0;
////    NSLog(@"ret = %@", NSStringFromRect(ret));
////    return ret;
//}







#pragma mark Selection

- (BOOL) selectionShouldChangeInOutlineView: (NSOutlineView *) outlineView {
    return self.allowsSelection;
}

- (BOOL) outlineView: (NSOutlineView *) outlineView shouldSelectItem: (id) item {
    BOOL ret = YES;
    if ([item isKindOfClass: [DPOutlineViewSection class]]) {
        ret = NO;
    }
    return ret;
}

- (void) outlineViewSelectionDidChange: (NSNotification *) notification {
    id item = [self itemAtRow: self.selectedRow];
    if ([item isKindOfClass: [DPOutlineViewSection class]]) {

    } else {
        [self didSelectItem: item];
    }

}

//
//- (void) outlineView: (NSOutlineView *) outlineView willDisplayOutlineCell: (id) cell forTableColumn: (NSTableColumn *) tableColumn item: (id) item {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//
//}


//- (BOOL) outlineView: (NSOutlineView *) outlineView shouldShowCellExpansionForTableColumn: (NSTableColumn *) tableColumn item: (id) item {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    return YES;
//}
//
//
//- (BOOL) outlineView: (NSOutlineView *) outlineView shouldShowOutlineCellForItem: (id) item {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    return YES;
//}


- (BOOL) outlineView: (NSOutlineView *) outlineView isGroupItem: (id) item {
    return [self.sections containsObject: item];
}


#pragma mark Re-worked





- (void) didAddRowView: (NSTableRowView *) rowView forSection: (DPOutlineViewSection *) section {
    [self callSelector: @selector(didAddRowView:forSection:) object: rowView object: section];
}


- (void) didAddRowView: (NSTableRowView *) rowView forItem: (DPOutlineViewItem *) item {
    [self callSelector: @selector(didAddRowView:forItem:) object: rowView object: item];
}

- (void) didSelectItem: (DPOutlineViewItem *) item {
    [self callSelector: @selector(didSelectItem:) object: item];
}




#pragma mark Sections


#pragma mark Call selectors

- (void) callSelector: (SEL) selector object: (id) object {
    [self callSelector: selector object: object object: nil object: nil];
}

- (void) callSelector: (SEL) selector object: (id) object object: (id) object2 {
    [self callSelector: selector object: object object: object2 object: nil];
}

- (void) callSelector: (SEL) selector object: (id) object object: (id) object2 object: (id) object3 {
    //    if (outlineDelegate && [outlineDelegate respondsToSelector: selector]) {
    //        id theDelegate = outlineDelegate;
    //        IMP imp = [theDelegate methodForSelector: selector];
    //        void (*func)(id, SEL, id, id, id) = (void *) imp;
    //        func(theDelegate, selector, object, object2, object3);
    //    }
    [self forwardSelector: selector delegate: self.outlineDelegate object: object object: object2 object: object2];
}


@end