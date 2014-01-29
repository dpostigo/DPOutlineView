//
// Created by Dani Postigo on 1/22/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPOutlineViewSection;
@protocol DPOutlineViewDelegate;

@interface DPOutlineViewItem : NSObject {
    __unsafe_unretained DPOutlineViewSection *section;
}

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, strong) NSImage *image;
@property(nonatomic, assign) DPOutlineViewSection *section;

@property(nonatomic, copy) NSString *subtitle;
- (instancetype) initWithTitle: (NSString *) aTitle;
- (instancetype) initWithTitle: (NSString *) aTitle image: (NSImage *) anImage;
- (instancetype) initWithTitle: (NSString *) aTitle identifier: (NSString *) anIdentifier;
- (instancetype) initWithTitle: (NSString *) aTitle image: (NSImage *) anImage identifier: (NSString *) anIdentifier;
- (NSUInteger) itemIndex;
- (void) removeFromSection;
- (instancetype) initWithTitle: (NSString *) aTitle subtitle: (NSString *) aSubtitle image: (NSImage *) anImage identifier: (NSString *) anIdentifier;
- (instancetype) initWithTitle: (NSString *) aTitle subtitle: (NSString *) aSubtitle image: (NSImage *) anImage;


@end
