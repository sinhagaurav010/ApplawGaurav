//
//  LoadviewController.h
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "SearchWebView.h"
#import "SettingsViewController.h"
#import "AddBookmarkViewController.h"
#import "ShowBookMarksViewController.h"
#import <MessageUI/MessageUI.h>
@interface LoadviewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>{
    
    IBOutlet UIWebView *_webView;
    IBOutlet     UIButton *buttonNext;
    IBOutlet  UIButton *buttonBack;
    NSString *FileName;
    int count,pageno;
    NSString *StringTitle; 
    UIBarButtonItem *barBack;
    UIBarButtonItem *barfor;
    NSString *stringTestWeb;
    NSString *fileContents;
    BOOL isForErr;
    NSMutableArray	*resultRow ;  ///////////this array will have selected row result
}
-(void)clickOn;
//- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
-(void)funcLoad;
-(void)removeNot;
@property(nonatomic,assign)NSInteger indexSectionPress;

@property(nonatomic,retain)NSString *FileName;
@property(nonatomic,assign)NSInteger indexPress;
@property(nonatomic,retain)NSString *StringTitle;
@property(nonatomic,retain)NSString *stringSear;
@property(nonatomic,retain)NSString *fileContents;
@property(assign)    BOOL _isSearch;

@property(retain)NSMutableArray *arraySec;
-(void)stringfromFileName:(NSString *)stringName;
//-(IBAction)buttonNext:(id)sender;
//-(IBAction)buttonBack:(id)sender;
//


@end

