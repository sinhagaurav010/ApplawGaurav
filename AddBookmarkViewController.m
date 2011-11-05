//
//  AddBookmarkViewController.m
//  LawApp
//
//  Created by gaurav on 21/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "AddBookmarkViewController.h"


@implementation AddBookmarkViewController
@synthesize stringSave,stringViewNum,dictSave;
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
    // [arrayLaw release];
    [tableview release];
    [arrarAddBookmark release];
    [fieldBook release];
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
    self.navigationController.toolbar.tintColor=[UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    
    fieldBook = [[UITextField alloc] init];
    fieldBook.enablesReturnKeyAutomatically = YES;
    fieldBook.text = stringSave;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" 
                                                                   style:UIBarButtonItemStylePlain 
                                                                  target:self 
                                                                  action:@selector(closeBtnPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
    
    
    UIBarButtonItem *SaveBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save" 
                                                                style:UIBarButtonItemStylePlain 
                                                               target:self 
                                                               action:@selector(save)];
    
    self.navigationItem.rightBarButtonItem = SaveBtn;
    
    [SaveBtn release];
    
    //arrarAddBookmark=[[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)save
{
    if([fieldBook.text length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                        message:@"Please enter the bookmark name" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {//BOOKMARKARAY
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        arrayLaw = [[NSMutableArray alloc] init];
        if([prefs arrayForKey:BOOKMARKARAY])       
        {
            arrayLaw = [NSMutableArray arrayWithArray:[prefs arrayForKey:BOOKMARKARAY] ];
        }
        
        
        //NSLog(@"arrayalal%@",arrayLaw);
        
        NSMutableDictionary *dictToSave = [[NSMutableDictionary alloc] init];
        [dictToSave setObject:stringSave forKey:@"content"];
        [dictToSave setObject:stringViewNum forKey:@"num"];
        [dictToSave setObject:dictSave forKey:@"dict"];
        
        //NSLog(@"klujklj+++++++++%@",dictToSave);
        //[dictionaryLaw setObject:stringSave forKey:fieldBook.text];
        [arrayLaw addObject:dictToSave];
        [dictToSave release];
        
        [prefs setObject:arrayLaw forKey:BOOKMARKARAY];
        [prefs synchronize];
        
        //[arrayLaw release];
        
        
        prefs = [NSUserDefaults standardUserDefaults];
        arrayLaw = [[NSMutableArray alloc] init];
        //NSLog(@"here2");
        
        if([prefs arrayForKey:ARRAYLAW])       
        {
            arrayLaw = [NSMutableArray arrayWithArray:[prefs arrayForKey:ARRAYLAW] ];
        }
        //NSLog(@"here2");
        
        //[dictionaryLaw setObject:stringSave forKey:fieldBook.text];
        [arrayLaw addObject:fieldBook.text];
        //NSLog(@"here2");
        [prefs setObject:arrayLaw forKey:ARRAYLAW];
        //NSLog(@"here2");
        
        //[prefs synchronize];
        //[arrayLaw release];
        if([prefs synchronize])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                            message:@"Saved Successfullly" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                            message:@"Failed!!" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return stringtitle;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell] autorelease];
    }
    if(indexPath.section==0)
    {
        fieldBook.frame = CGRectMake(12, 10, cell.frame.size.width-24, cell.frame.size.height);
        [cell addSubview:fieldBook];
    }
    if(indexPath.section==1)
    {
        cell.textLabel.text=@"Bookmark";
        cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
    }
    
    //cell.selectionStyle = UITableViewCellEditingStyleNone;
    
	//cell.textLabel.text = [arrayItems objectAtIndex:indexPath.row];
    //    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    //	cell.accessoryType = 1;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)closeBtnPressed
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
