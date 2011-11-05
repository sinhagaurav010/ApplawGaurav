//
//  ModalController.m
//  LawApp
//
//  Created by gaurav on 23/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "ModalController.h"


@implementation ModalController
@synthesize arrayFilesWithString,stringSearch;
//+(BOOL)searchStringInFile:(NSString *)stringFileName withString:(NSString *)string;
//{
////    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:stringFileName ofType:@"htm"];
////    NSString *fileContents =[NSString stringWithContentsOfFile:urlAddress encoding:NSASCIIStringEncoding error:nil];
////    if([fileContents rangeOfString:string].length>0)
////        return YES;
////    else
////        return NO;
//}

-(void)searchStringForArray:(NSMutableArray *)arraySearch withString:(NSString *)stringSrch
{
   self.arrayFilesWithString = [[NSMutableArray alloc] init];
   self.stringSearch = stringSrch;
    //NSLog(@"%@",self.stringSearch);
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    
    arrayFiles = [[NSMutableArray alloc] initWithArray:arraySearch];
    
    count = 0;
    
    if(count<[arrayFiles count])
    {
        [self loadInView:[arrayFiles objectAtIndex:count]];
    }
}
-(void)loadInView:(NSString *)stringName
{
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:stringName ofType:@"htm"];
    NSString *fileContents =[NSString stringWithContentsOfFile:urlAddress encoding:NSASCIIStringEncoding error:nil];
    //    if(stringSearch!=nil)
    //    {
    //        ////NSLog(@"hi");
    //        //fileContents = [fileContents stringByReplacingOccurrencesOfString:stringSearch withString:[NSString stringWithFormat:@"<SPAN style=\"background-color:yellow\">%@</SPAN>",stringSearch]];
    //    }
    // NSString *str_Html=[NSString stringWithFormat:@"<html><head><titile></title></head><body><font size=\"50\">%@</font></body></html>",fileContents];
    
    ////NSLog(@"-----%@",fileContents);
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_webView loadHTMLString:fileContents baseURL:baseURL];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([_webView highlightAllOccurencesOfString:self.stringSearch]>0)
    {
        [self.arrayFilesWithString addObject:[arrayFiles objectAtIndex:count]];
    }
    ++count;
    if(count<[arrayFiles count])
    {
        [self loadInView:[arrayFiles objectAtIndex:count]]; 
    }
    else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:STRINGFIND object:nil];
     //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowBookmark:) name:SHOWBOOKMARK object:nil];
    }
}


- (void)dealloc {
    [_webView release];
    [arrayFiles release];
    [super dealloc];
}
@end
