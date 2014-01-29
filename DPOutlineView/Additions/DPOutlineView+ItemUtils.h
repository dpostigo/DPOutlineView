//
// Created by Dani Postigo on 1/23/14.
//

#import <Foundation/Foundation.h>
#import <DPOutlineView/DPOutlineView.h>

@class DPOutlineViewItem;

@interface DPOutlineView (ItemUtils)

- (id) firstItem;
- (DPOutlineViewItem *) itemForIdentifier: (NSString *) identifier;
@end