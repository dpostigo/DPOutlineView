//
// Created by Dani Postigo on 1/23/14.
//

#import "NSOutlineView+Selection.h"

@implementation NSOutlineView (Selection)

- (void) selectFirstItem {
    [self selectItemAtRow: 0 section: 0];
}


- (void) selectItem: (id) item {
    NSInteger itemIndex = [self rowForItem: item];
    if (itemIndex < 0) {
        itemIndex = [self rowForItem: item];
        if (itemIndex < 0)
            return;
    }

    [self selectRowIndexes: [NSIndexSet indexSetWithIndex: (NSUInteger) itemIndex] byExtendingSelection: NO];
}

- (void) selectItemAtRow: (NSInteger) rowIndex section: (NSInteger) sectionIndex {
    //    if (self.dataSource) {
    //        if ([self.dataSource isKindOfClass: [BasicOutlineViewController class]]) {
    //            BasicOutlineViewController *controller = (BasicOutlineViewController *) self.dataSource;
    //            if (sectionIndex < [controller.dataSource count]) {
    //                OutlineSection *section = [controller.dataSource objectAtIndex: sectionIndex];
    //                if (section && rowIndex < [section.rows count]) {
    //
    //                    [self selectItem: [section.rows objectAtIndex: 0]];
    //                }
    //
    //            }
    //
    //        }
    //    }

}

@end