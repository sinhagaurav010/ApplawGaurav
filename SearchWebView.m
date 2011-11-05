//
//  SearchWebView.m
//  LawApp
//
//  Created by gaurav on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "SearchWebView.h"


@implementation UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str
{
    //NSLog(@"highlightAllOccurencesOfString");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
    //[self stringByEvaluatingJavaScriptFromString:startSearch];
    NSLog(@"%@",[self stringByEvaluatingJavaScriptFromString:startSearch]);
    NSString *result = [self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
    return [result integerValue];
}

- (void)removeAllHighlights
{
    [self stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}

@end