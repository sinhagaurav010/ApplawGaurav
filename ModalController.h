//
//  ModalController.h
//  LawApp
//
//  Created by gaurav on 23/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchWebView.h"
#import "Constant.h"
@interface ModalController : NSObject<UIWebViewDelegate> {
    UIWebView *_webView;
    NSInteger count;
    NSMutableArray *arrayFiles;
    NSString *stringSearch;
    NSMutableArray *arrayFilesWithString;
}
//+(BOOL)searchStringInFile:(NSString *)stringFileName withString:(NSString *)string;

-(void)searchStringForArray:(NSMutableArray *)arraySearch withString:(NSString *)stringSrch;
@property(retain)    NSMutableArray *arrayFilesWithString;
@property(retain)    NSString *stringSearch;;

-(void)loadInView:(NSString *)stringName;
@end
