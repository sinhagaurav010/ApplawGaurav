//
//  SettingsViewController.h
//  LawApp
//
//  Created by gaurav on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AboutViewController.h"
#import "PickerCustom.h"
#import "Constant.h"

@interface SettingsViewController : UIViewController<MFMailComposeViewControllerDelegate,CustomPickerDelegate> {
    IBOutlet UITableView *tableview;
    NSMutableArray *arraySetting;
    NSMutableArray *arrayFont;
    PickerCustom *pickerCus;

}
-(void)clickOn;
@end
