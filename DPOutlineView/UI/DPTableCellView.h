//
// Created by Dani Postigo on 1/11/14.
// Copyright (c) 2014 Elastic Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPTableCellView : NSTableCellView {

    IBOutlet NSTextField *textLabel;
    IBOutlet NSTextField *detailTextLabel;
    IBOutlet NSButton *button;

}

@property(nonatomic, strong) NSTextField *detailTextLabel;
@property(nonatomic, strong) NSTextField *textLabel;
@property(nonatomic, strong) NSButton *button;
@end