//
// Created by Dani Postigo on 2/5/14.
//

#import <Foundation/Foundation.h>
#import "DPOutlineView.h"

@class DPOutlineViewItem;

@interface DPOutlineView (Remove)

- (void) removeItem: (DPOutlineViewItem *) item;
@end