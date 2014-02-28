//
// Created by Dani Postigo on 1/23/14.
//

#import <DPOutlineView/DPOutlineView+ItemUtils.h>
#import "DPOutlineView+Selection.h"
#import "NSOutlineView+Selection.h"
#import "DPOutlineView+ItemUtils.h"

@implementation DPOutlineView (Selection)


- (void) selectItemByTitle: (NSString *) title {
    id item = [self itemForTitle: title];
    if (item) {
        [self selectItem: item];
    } else {
        NSLog(@"Could not find item.");

    }
}
- (void) selectItemByIdentifier: (NSString *) identifier {
    id item = [self itemForIdentifier: identifier];
    if (item) {
        [self selectItem: item];
    }
}
@end