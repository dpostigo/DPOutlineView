//
// Created by Dani Postigo on 1/23/14.
//

#import <DPOutlineView/DPOutlineView+ItemUtils.h>
#import "DPOutlineView+Selection.h"
#import "NSOutlineView+Selection.h"

@implementation DPOutlineView (Selection)

- (void) selectItemByIdentifier: (NSString *) identifier {
    id item = [self itemForIdentifier: identifier];
    if (item) {
        [self selectItem: item];
    }
}
@end