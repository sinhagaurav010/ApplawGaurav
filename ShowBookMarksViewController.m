//
//  ShowBookMarksViewController.m
//  LawApp
//
//  Created by gaurav on 21/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "ShowBookMarksViewController.h"


@implementation ShowBookMarksViewController

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
    [tableViewLaw release];
    [arrayBookMark release];
    [arrayLaw release];
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
    NSLog(@"here i am ");
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    [self getDataForTable];
    //    NSMutableArray *arrayKeys = [[NSMutableArray alloc] init];
    //    [arrayKeys addObject:BOOKMARK];
    //    if([[SaveInMemoryController  getDataForKeys:arrayKeys] count]>0)
    //    {
    //        arrayBookMark = [NSMutableArray arrayWithArray:[[SaveInMemoryController  getDataForKeys:arrayKeys] objectAtIndex:0]];
    //    }
    //    [arrayKeys release];
    
    NSLog(@"here i am ");

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(backBtnPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];

    NSLog(@"here i am ");

    UIBarButtonItem *editbutton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = editbutton;
    [editbutton release];
    NSLog(@"here i am ");

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)getDataForTable
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    arrayBookMark = [[NSMutableArray alloc] init];
    if([prefs arrayForKey:ARRAYLAW])
    {
        arrayBookMark = [[NSMutableArray alloc]initWithArray:[prefs arrayForKey:ARRAYLAW] ];
    }
}
-(void)edit
{
    tableViewLaw.editing = YES;
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(done)];
    self.navigationItem.rightBarButtonItem = done;
    [done release];
}
-(void)done
{
    tableViewLaw.editing = NO;
    UIBarButtonItem *editbutton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = editbutton;
    [editbutton release];
}

#pragma mark -table code-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayBookMark count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ////NSLog(@"%@",arrayBookMark);
    [arrayBookMark removeObjectAtIndex:[indexPath row]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:arrayBookMark forKey:ARRAYLAW];
    [prefs synchronize];
    
    arrayLaw = [[NSMutableArray alloc] init];
    prefs = [NSUserDefaults standardUserDefaults];
    if([prefs arrayForKey:BOOKMARKARAY])       
    {
        arrayLaw = [NSMutableArray arrayWithArray:[prefs arrayForKey:BOOKMARKARAY] ];
    }
    [arrayLaw removeObjectAtIndex:[indexPath row]];
    //[dictionaryLaw setObject:stringSave forKey:fieldBook.text];
    [prefs setObject:arrayLaw forKey:BOOKMARKARAY];
    [prefs synchronize];
    //[arrayLaw release];
    [tableViewLaw reloadData];
    //    arrayBookMark = [[NSMutableArray alloc] init];
    //    if([prefs arrayForKey:ARRAYLAW])
    //    {
    //arrayBookMark = [NSMutableArray arrayWithArray:[prefs arrayForKey:ARRAYLAW] ];
    //}
}

//- (UIView *)tableView:(UITableView *)tableView
//viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *sectionHeader = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
//    sectionHeader.backgroundColor = [UIColor grayColor];
//    sectionHeader.lineBreakMode = YES,
//    sectionHeader.numberOfLines = 2;
//    sectionHeader.textAlignment = UITextAlignmentCenter;
//    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
//    sectionHeader.textColor = [UIColor whiteColor];
//    sectionHeader.text = stringtitle;
//    return sectionHeader;
//}


//- (CGFloat)tableView:(UITableView *)tableView
//heightForHeaderInSection:(NSInteger)section 
//{
//    return 40;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return stringtitle;
//}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
    NSLog(@"here i am ");

	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell] autorelease];
    }
	cell.textLabel.text = [arrayBookMark objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayContent = [[NSMutableArray alloc] init];
    if([prefs arrayForKey:BOOKMARKARAY])
    {
        arrayContent = [[NSMutableArray alloc]initWithArray:[prefs arrayForKey:BOOKMARKARAY] ];
    }
    //if([arrayContent objectAtIndex:indexPath.row])
    //{
        isFromBookMark = 1;
        //NSLog(@"------search%@",[arrayContent objectAtIndex:indexPath.row]);
        dictSearch = [[NSMutableDictionary alloc] initWithDictionary:[arrayContent objectAtIndex:indexPath.row]];
        [arrayContent release];
        [self.navigationController dismissModalViewControllerAnimated:YES];
   // }
}


-(void)backBtnPressed
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
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
