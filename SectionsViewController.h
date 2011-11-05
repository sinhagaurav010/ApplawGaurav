//
//  SectionsViewController.h
//  LawApp
//
//  Created by gaurav on 17/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowBookMarksViewController.h"
#import "ModalController.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"
@interface SectionsViewController : UIViewController<UIActionSheetDelegate> {
    IBOutlet UITableView *tableview;
    IBOutlet UISearchBar *searchBar;
    NSMutableArray *arrayItems;
    BOOL  isSearch;
    UIView *disableViewOverlay;
    UIBarButtonItem *barBack;
    UIBarButtonItem *barfor;
    ModalController *modal;
}
-(void)removeNot;
-(void)arrayAfterClickAtIndex:(NSInteger)index;
-(void)functionToLoad;
-(void)setbarbutton;
-(void)enableCancelButton:(UISearchBar *)searchBar;

@property (retain) UIView *disableViewOverlay;
@property(retain)    NSMutableArray *arraySections;
@property(retain)NSString *stringtitle;
@property(assign)NSInteger indexPress;
@property(retain)    NSMutableArray *arrayAll;

@end
