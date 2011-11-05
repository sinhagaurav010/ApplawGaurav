//
//  AddBookmarkViewController.h
//  LawApp
//
//  Created by gaurav on 21/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface AddBookmarkViewController : UIViewController {
    IBOutlet UITableView *tableview;
    NSMutableArray *arrarAddBookmark;
    UITextField *fieldBook;
    NSMutableArray *arrayLaw;
}
@property(nonatomic,retain)NSString *stringSave;
@property(nonatomic,retain)NSString *stringViewNum;
@property(nonatomic,retain)NSMutableDictionary *dictSave;


@end
