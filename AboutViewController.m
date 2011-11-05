//
//  AboutViewController.m
//  LawApp
//
//  Created by Rohit Dhawan on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize stringName,stringTitle,stringEX;

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
    [webViewLaw release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationItem setTitle:stringTitle];
    
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:stringName ofType:stringEX];
    NSString *fileContents =[NSString stringWithContentsOfFile:urlAddress encoding:NSASCIIStringEncoding error:nil];
   
    // NSString *str_Html=[NSString stringWithFormat:@"<html><head><titile></title></head><body><font size=\"50\">%@</font></body></html>",fileContents];
    
    //NSLog(@"-----%@",fileContents);
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webViewLaw loadHTMLString:fileContents baseURL:baseURL];
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
