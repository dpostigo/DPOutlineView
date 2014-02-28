//
// Created by Dani Postigo on 2/5/14.
//

#import <DPOutlineView/NSOutlineView+Insertion.h>
#import <DPOutlineView/DPOutlineViewItem.h>
#import <DPOutlineView/DPOutlineViewSection.h>
#import "DPOutlineView+Remove.h"
#import "DPOutlineViewItem.h"

@implementation DPOutlineView (Remove)

- (void) removeItem: (DPOutlineViewItem *) item {
    DPOutlineViewSection *parent = [self parentForItem: item];
    if (parent) {
        [self removeItemAtIndex: item.itemIndex inParent: parent];
        [parent removeItem: item];
    }
}
@end