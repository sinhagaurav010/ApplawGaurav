//
//  AboutViewController.h
//  LawApp
//
//  Created by Rohit Dhawan on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
    IBOutlet UIWebView *webViewLaw;
}
@property(nonatomic,retain)NSString *stringName;
@property(nonatomic ,retain)NSString *stringTitle;
@property(nonatomic ,retain)NSString *stringEX;

@end
