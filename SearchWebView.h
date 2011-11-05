//
//  SearchWebView.h
//  LawApp
//
//  Created by gaurav on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

@end