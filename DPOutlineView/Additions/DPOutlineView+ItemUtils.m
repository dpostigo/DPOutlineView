//
// Created by Dani Postigo on 1/23/14.
//

#import "DPOutlineView+ItemUtils.h"
#import "DPOutlineViewItem.h"
#import "DPOutlineViewSection.h"

@implementation DPOutlineView (ItemUtils)

- (id) firstItem {
    return [self itemAtRow: 0];
}


- (DPOutlineViewItem *) itemForIdentifier: (NSString *) identifier {
    DPOutlineViewItem *ret = nil;

    for (DPOutlineViewSection *section in self.sections) {
        for (int j = 0; j < [section itemCount]; j++) {
            DPOutlineViewItem *item = [section itemAtIndex: j];
            if ([item.identifier isEqualToString: identifier]) {
                ret = item;
                break;
            }
        }

    }
    return ret;
}
@end