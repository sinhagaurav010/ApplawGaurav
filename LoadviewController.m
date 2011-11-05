//
//  LoadviewController.m
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "LoadviewController.h"
#import "XMLReader.h"


@implementation LoadviewController
@synthesize FileName,StringTitle,indexPress,arraySec,stringSear,fileContents,indexSectionPress,_isSearch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Setting:) name:SETTING object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowBookmark:) name:SHOWBOOKMARK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyPress:) name:ACTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackwardKeyPress:) name:BACKWARD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ForwardKeyPress:) name:FORWARD object:nil];
    
    if(isFromBookMark == 1)
    {
        switch ([[dictSearch objectForKey:@"num"] integerValue]) {
            case 3:
            {
                isFromBookMark = 0;
                [self.arraySec removeAllObjects];
                self.arraySec = [NSMutableArray arrayWithArray:[[dictSearch objectForKey:@"dict"] objectForKey:@"array"]];
                //NSLog(@"??????????%@",self.arraySec);
                indexPress = [[[dictSearch objectForKey:@"dict"] objectForKey:@"sectionpressindex"] integerValue       ];;
                [self funcLoad];
            }
                break;
            case 2:
            {
                [self removeNot];
                [self.navigationController popViewControllerAnimated:YES];
                break;
            }
            case 1:
            {
                isFromBookMark = 0;
                [self.navigationController popToRootViewControllerAnimated:YES];
                //[self.navigationController dismissModalViewControllerAnimated:YES];
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self removeNot];
}
-(void)removeNot
{
    //NSLog(@"willdisss");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWBOOKMARK object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ACTION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BACKWARD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FORWARD object:nil];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}//<font size="5">Here is a size 5 font</font>background-color

#pragma mark -setting Notification-
-(void)Setting:(NSNotificationCenter*)notification
{
    SettingsViewController *setting=[[SettingsViewController alloc]init];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:setting];
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    //[self presentModalViewController:setting animated: YES];
    [infoNavController release];
    [setting release];
}


-(void)stringfromFileName:(NSString *)stringName
{
    [self.navigationItem setTitle:stringName];
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:stringName ofType:@"htm"];
    self.fileContents =[NSString stringWithContentsOfFile:urlAddress encoding:NSASCIIStringEncoding error:nil];
    if(stringSear!=nil)
    {
        ////NSLog(@"hi");
       //fileContents = [fileContents stringByReplacingOccurrencesOfString:stringSearch withString:[NSString stringWithFormat:@"<SPAN style=\"background-color:yellow\">%@</SPAN>",stringSearch]];
    }
   // NSString *str_Html=[NSString stringWithFormat:@"<html><head><titile></title></head><body><font size=\"50\">%@</font></body></html>",fileContents];
    
    ////NSLog(@"-----%@",fileContents);
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_webView loadHTMLString:fileContents baseURL:baseURL];
    
}
#pragma mark -MailComposer-

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)clickOn
{
    ////NSLog(@"clickon");
	//NSArray *arrayRec = [NSArray arrayWithObjects:@"info@ctlawinfogroup.com",nil];
    //NSLog(@"%d",[MFMailComposeViewController canSendMail]);
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
        if(isForErr == 1)
        {
        NSArray *arrayRec = [NSArray arrayWithObjects:@"info@ctlawinfogroup.com",nil];
		[mcvc setToRecipients:arrayRec];
        [mcvc setSubject:[NSString stringWithFormat:@"Reporting error:%@",self.navigationItem.title]];
        }
        else
        {
            [mcvc setSubject:[NSString stringWithFormat:@"%@",self.navigationItem.title]];
        }
        
        //NSString *messageBdy = stringTestWeb;
        		[mcvc setMessageBody:self.fileContents isHTML:YES];
		//[mcvc addAttachmentData:UIImageJPEGRepresentation(imageToEmail, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
		[self presentModalViewController:mcvc animated:YES];
	}	
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                           message:@"Please Configure Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
        [alerView release];
    }
}

#pragma mark - View lifecycles


- (void)viewDidLoad
{
    UIBarButtonItem *barAction = [self.navigationController.toolbarItems objectAtIndex:4];
    barAction.enabled = YES;
    
    UIBarButtonItem *barButtonBack = [self.navigationController.toolbarItems objectAtIndex:2];
    barButtonBack.enabled = NO;    resultRow = [[NSMutableArray alloc ] init];
    _webView.delegate = self;
    [self funcLoad];
    //    UIBarButtonItem *barBackButton = [self.navigationController.toolbarItems objectAtIndex:0];
//    barBackButton.enabled = YES;
//    
//    UIBarButtonItem *barButtonForward = [self.navigationController.toolbarItems objectAtIndex:2];
//    barButtonForward.enabled = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)funcLoad
{
    [self stringfromFileName:[arraySec objectAtIndex:indexPress]];
    //[self.navigationItem setTitle:StringTitle];
    barBack = [self.navigationController.toolbarItems objectAtIndex:0];
    if(indexPress == 0)
    {
        barBack.enabled = NO;
    }
    else
        barBack.enabled = YES;
    
    barfor = [self.navigationController.toolbarItems objectAtIndex:2];
    if(indexPress == [arraySec count]-1)
    {
        barfor.enabled = NO;
    }
    else
        barfor.enabled = YES;
    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(stringSear)
        NSLog(@"integer%d",[_webView highlightAllOccurencesOfString:stringSear]);
        
    NSString *fontStr = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@0%@'",fontSize,@"%"];

    [webView stringByEvaluatingJavaScriptFromString:fontStr];

    stringTestWeb = [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerText"];
    ////NSLog(@"-------%@", myText);

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)ShowBookmark:(NSNotificationCenter*)notification
{
    ShowBookMarksViewController *ShowBookMarksController=[[ShowBookMarksViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:ShowBookMarksController];
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    //[self presentModalViewController:ShowBookMarksController animated: YES];
    [infoNavController release];
    [ShowBookMarksController release];
}
//-(IBAction)actionKeyPress:(id)sender
//{
//}
-(IBAction)BackwardKeyPress:(NSNotificationCenter*)notification
{
    if(indexPress !=0)
    {
        [self stringfromFileName:[arraySec objectAtIndex:--indexPress]];
       // UIBarButtonItem *barBack = [self.navigationController.toolbarItems objectAtIndex:0];
        barfor.enabled = YES;
        
        if(indexPress == 0)
        {
            barBack.enabled = NO;
        }
        else
            barBack.enabled = YES;

    }
//    else
//        barBack.enabled = NO;
}

#pragma mark -running jQuery-

//- (NSInteger)highlightAllOccurencesOfString:(NSString*)str
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
//    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    //NSLog(@"%@",jsCode);
//    [_webView stringByEvaluatingJavaScriptFromString:jsCode];
//    
//    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
//    [_webView stringByEvaluatingJavaScriptFromString:startSearch];
//    
//    NSString *result = [_webView stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
//    //NSLog(@"%@",result);
//    return [result integerValue];
//}
//
//- (void)removeAllHighlights
//{
//    [_webView stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
//}

-(void)actionKeyPress:(NSNotificationCenter*)notification
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Add Bookmark",@"Email",@"Report content Error",@"Cancel", nil];
    action.actionSheetStyle=UIBarStyleBlackTranslucent;
    [action showInView:self.view];
    [action release];  
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
    {
        AddBookmarkViewController *addBookmark=[[AddBookmarkViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
        addBookmark.stringSave = StringTitle;
        addBookmark.stringViewNum = @"3";
        
        NSMutableDictionary *dictionayToSve = [[NSMutableDictionary   alloc] init];
        [dictionayToSve setObject:arraySec forKey:@"array"];
        [dictionayToSve setObject:[NSString stringWithFormat:@"%d",indexPress] forKey:@"pressindex"];
        [dictionayToSve setObject:[NSString stringWithFormat:@"%d",indexSectionPress] forKey:@"sectionpressindex"];

        addBookmark.dictSave = [[NSMutableDictionary alloc] initWithDictionary:dictionayToSve];
        [dictionayToSve release];
        
        UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:addBookmark];
        [self.navigationController presentModalViewController:infoNavController animated:YES];
       // [self presentModalViewController:addBookmark animated: YES];
        [infoNavController release];
        [addBookmark release];
    }
    else if(buttonIndex == 1 )
    {
        isForErr = 0;
        [self clickOn];
    }
    else if(buttonIndex == 2)
    {
        isForErr = 1;
        [self clickOn];
    }
}


#pragma mark -ForwardKeyPress-

-(IBAction)ForwardKeyPress:(NSNotificationCenter*)notification
{
    
    //NSLog(@"---------------%d",[self.arraySec count]);
    if(indexPress !=([self.arraySec count]-1))
    {
        [self stringfromFileName:[arraySec objectAtIndex:++indexPress]];
        //UIBarButtonItem *barfor = [self.navigationController.toolbarItems objectAtIndex:2];
        barBack.enabled = YES;
        
        if(indexPress == [arraySec count]-1)
        {
            barfor.enabled = NO;
        }
        else
            barfor.enabled = YES;

    }
//    else
//        barfor.enabled = NO;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
