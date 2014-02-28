//
// Created by Dani Postigo on 1/23/14.
//

#import <Foundation/Foundation.h>
#import <DPOutlineView/DPOutlineView.h>

@interface DPOutlineView (Selection)

- (void) selectItemByTitle: (NSString *) title;
- (void) selectItemByIdentifier: (NSString *) identifier;
@end