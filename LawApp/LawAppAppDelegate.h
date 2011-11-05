//
//  LawAppAppDelegate.h
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "HomeViewController.h"


@interface LawAppAppDelegate : NSObject <UIApplicationDelegate, UIActionSheetDelegate> {
    UINavigationController *navigation;
    UIWindow *window;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *barButtonBck; 
    IBOutlet UIBarButtonItem *forButton; 
    IBOutlet UIBarButtonItem *actionButton; 
    IBOutlet UIBarButtonItem *bookButton; 
    IBOutlet UIBarButtonItem *settingButton; 
    IBOutlet UIBarItem *barfixed1; 
    IBOutlet UIBarItem *barfixed2; 
    IBOutlet UIBarItem *barfixed3;    
    HomeViewController   *home;
    IBOutlet UIBarItem *barfixed4;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
-(IBAction)clickToBack:(id)sender;
-(IBAction)clickToForward:(id)sender;
-(IBAction)clickToAction:(id)sender;
-(IBAction)clickToBookMark:(id)sender;
-(IBAction)clickToSetting:(id)sender;
@end
