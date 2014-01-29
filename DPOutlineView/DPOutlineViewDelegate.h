//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPOutlineViewItem;
@class DPOutlineViewSection;
@class DPTableCellView;

@protocol DPOutlineViewDelegate <NSObject>

@required
- (void) prepareDatasource;

@optional
- (NSTableRowView *) rowViewForItem: (id) item;
- (void) didAddRowView: (NSTableRowView *) rowView;
- (void) didAddRowView: (NSTableRowView *) rowView forSection: (DPOutlineViewSection *) section;
- (void) didAddRowView: (NSTableRowView *) rowView forItem: (DPOutlineViewItem *) item;

- (void) willDisplayHeader: (NSTableCellView *) cellView forSection: (DPOutlineViewSection *) section;
- (void) willDisplayTableHeader: (DPTableCellView *) cellView forSection: (DPOutlineViewSection *) section;
- (void) willDisplayCell: (NSTableCellView *) cellView forItem: (DPOutlineViewItem *) item;
- (void) willDisplayTableCellView: (DPTableCellView *) cellView forItem: (DPOutlineViewItem *) item;
- (void) didSelectItem: (DPOutlineViewItem *) item;

- (void) outlineViewDidReload;

- (void) outlineViewItemWillCollapse: (NSNotification *) notification;
- (void) outlineViewItemDidCollapse: (NSNotification *) notification;
- (void) outlineViewItemWillExpand: (NSNotification *) notification;
- (void) outlineViewItemDidExpand: (NSNotification *) notification;

@end
