//
//  LawAppAppDelegate.m
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "LawAppAppDelegate.h"
#import "AddBookmarkViewController.h"
@implementation LawAppAppDelegate


@synthesize window=window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:FONTLAW])
        fontSize  = [prefs objectForKey:FONTLAW];
    else
        fontSize = @"10";
    
    isFromBookMark = 0;
    NSArray *arrayButt = [NSArray arrayWithObjects:barButtonBck,barfixed1,forButton,barfixed2,actionButton,barfixed3,bookButton,barfixed4,settingButton, nil];
    [toolbar setItems:arrayButt];
    
    // Override point for customization after application launch.
    home=[[HomeViewController alloc]init];
    navigation=[[UINavigationController alloc]initWithRootViewController:home] ;
    //NSLog(@"%@",toolbar.items);
    
    [navigation setToolbarItems:toolbar.items];
    
    [self.window addSubview:navigation.view];
    
    [navigation.view addSubview:toolbar];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
-(IBAction)clickToBack:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BACKWARD object:nil];
    
}
-(IBAction)clickToForward:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FORWARD object:nil];
}
-(IBAction)clickToAction:(id)sender
{
    //NSLog(@"dfnjvsndf");
        

    [[NSNotificationCenter defaultCenter] postNotificationName:ACTION object:nil];
}
-(IBAction)clickToBookMark:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWBOOKMARK object:nil];

}
-(IBAction)clickToSetting:(id)sender
{
      [[NSNotificationCenter defaultCenter] postNotificationName:SETTING object:nil];
    
}
- (void)dealloc
{
    [home release];
    [toolbar release];
    [navigation release];
    [window release];
    [super dealloc];
}

@end
