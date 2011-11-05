//
//  ShowBookMarksViewController.h
//  LawApp
//
//  Created by gaurav on 21/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveInMemoryController.h"
#import "Constant.h"

@interface ShowBookMarksViewController : UIViewController {
    IBOutlet UITableView *tableViewLaw;
    NSMutableArray *arrayBookMark;
    NSMutableArray *arrayLaw;
}
-(void)getDataForTable;
@end
