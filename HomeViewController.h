//
//  HomeViewController.h
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLReader.h"
#import "SectionsViewController.h"
#import "AddBookmarkViewController.h"
#import "ShowBookMarksViewController.h"
#import "ModalController.h"
#import "LoadviewController.h"


@interface HomeViewController : UIViewController<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView *tableview;
    IBOutlet UISearchBar *search;
    NSMutableArray *arrayHome;
    BOOL  isSearch;
    UIView *disableViewOverlay;
    ModalController *modal;
    
    NSMutableArray *arrayTableItems;
}

@property (retain) UIView *disableViewOverlay;
@property (retain)  IBOutlet UITableView *tableview;
-(void)barButtonSetting;
-(void)enableCancelButton:(UISearchBar *)searchBar;
+(void)setToolBarItemStatus:(BOOL)ishidden withArray:(NSArray *)arrayTool;
-(void)removeNot;

@end
