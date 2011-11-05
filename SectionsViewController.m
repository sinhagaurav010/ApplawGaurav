//
//  SectionsViewController.m
//  LawApp
//
//  Created by gaurav on 17/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "SectionsViewController.h"
#import "LoadviewController.h"
#import "AddBookmarkViewController.h"
#import "Constant.h"
#import "SettingsViewController.h"

@implementation SectionsViewController
@synthesize disableViewOverlay;
@synthesize arraySections,stringtitle,arrayAll,indexPress;
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
    [tableview release];
    [searchBar release];
    [arrayItems release];
    [modal release];
    [disableViewOverlay dealloc];
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
    isSearch = 0;
    [self functionToLoad];
    //searchBar.showsCancelButton = YES;
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //arraySections =[[NSMutableArray alloc]initWithObjects:@"Sec46b-1",@"Sec46b-2",@"Sec46b-3",@"Sec46b-4",@"Sec46b-5",@"Sec46b-6",@"Sec46b-7",@"Sec46b-8",@"Sec46b-9",@"Sec46b-10",@"Sec46b-11",nil];
    
    self.disableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0.0f,44.0f,320.0f,416.0f)];
    self.disableViewOverlay.backgroundColor=[UIColor blackColor];
    self.disableViewOverlay.alpha = 0;
}

#pragma mark -function load-

-(void)functionToLoad
{
    //NSLog(@"functionToLoad");
    arraySections = [[NSMutableArray alloc] initWithArray:[[[arrayAll objectAtIndex:indexPress] objectForKey:@"section"] componentsSeparatedByString:@","]];
    stringtitle = [[arrayAll objectAtIndex:indexPress] objectForKey:@"title"];
    
    arrayItems = [[NSMutableArray alloc] initWithArray:arraySections];
    if(isFromBookMark == 1)
        [tableview  reloadData];

}

#pragma mark -tableview code-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayItems count];
}
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionHeader = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
    sectionHeader.backgroundColor = [UIColor colorWithRed:232/256.0 green:212/256.0 blue:191/256.0 alpha:0.8];
    sectionHeader.lineBreakMode = YES,
    sectionHeader.numberOfLines = 2;
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
    sectionHeader.textColor = [UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    sectionHeader.text = stringtitle;
    return sectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section 
{
    return 40;
}

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
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell] autorelease];
    }
	cell.textLabel.text = [arrayItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoadviewController *load=[[LoadviewController alloc]init];
    //load.FileName = [arraySections objectAtIndex:indexPath.row];
    load.indexPress = indexPath.row;
    if(isSearch == 0)
        load.stringSear = nil;
    else
        load.stringSear = searchBar.text;
    //NSLog(@"%@",load.stringSear);
    //NSLog(@"%@",arrayItems);
    load.arraySec = [NSMutableArray arrayWithArray:arrayItems];
    load.StringTitle = [arrayItems objectAtIndex:indexPath.row];

    load.indexSectionPress = indexPress;
    //NSLog(@"%@",load.stringSear);

    load.StringTitle = [arrayItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:load animated:YES];
    [load release];
}

#pragma mark -search bar delegate-

- (void)enableCancelButton:(UISearchBar *)aSearchBar{
    for (id subview in [aSearchBar subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:TRUE];
        }
    }  
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    isSearch = 1;
    [arrayItems removeAllObjects];
    tableview.scrollEnabled=YES;
    tableview.allowsSelection=YES;
    [self performSelector:@selector(enableCancelButton:) withObject:searchBar afterDelay:0.0];
    // Removing the disableViewOverlay
    [disableViewOverlay removeFromSuperview];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stringFound:) name:STRINGFIND object:nil];
    modal = [[ModalController alloc] init];
    [modal searchStringForArray:arraySections withString:searchBar.text];
//    for(int i=0;i<[arraySections count];i++)
//    {
//        if([ModalController searchStringInFile:[arraySections objectAtIndex:i] withString:_searchBar.text])
//            [arrayItems addObject:[arraySections objectAtIndex:i]];
//    }
    
    [searchBar resignFirstResponder];    
}

-(void)stringFound:(NSNotificationCenter*)notification
{
    //NSLog(@"hitititi");
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:STRINGFIND object:nil];
    arrayItems = [[NSMutableArray alloc] initWithArray:modal.arrayFilesWithString];
//    arrayItems = [NSMutableArray arrayWithArray:modal.arrayFilesWithString];
    [tableview  reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    tableview.scrollEnabled = NO;
    tableview.allowsSelection=NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [HomeViewController setToolBarItemStatus:NO withArray:self.navigationController.toolbarItems];
    
    // Fading in the disableViewOverlay
    self.disableViewOverlay.alpha = 0;
    [self.view addSubview:self.disableViewOverlay];
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    self.disableViewOverlay.alpha = 0.6;
    [UIView commitAnimations];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [HomeViewController setToolBarItemStatus:YES withArray:self.navigationController.toolbarItems];

    [self setbarbutton];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    isSearch = 0;
    [searchBar setText:@""];
    [searchBar setShowsCancelButton:NO animated:YES];
    tableview.scrollEnabled=YES;
    tableview.allowsSelection=YES;
    [disableViewOverlay removeFromSuperview];
    [searchBar resignFirstResponder]; 
    arrayItems = [[NSMutableArray alloc] initWithArray:arraySections];
    [tableview   reloadData];

}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowBookmark:) name:SHOWBOOKMARK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyPress:) name:ACTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackwardKeyPress:) name:BACKWARD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ForwardKeyPress:) name:FORWARD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Setting:) name:SETTING object:nil];
    
    [self setbarbutton];
    
    if(isSearch == 1)
    {
        UIBarButtonItem *barAction = [self.navigationController.toolbarItems objectAtIndex:4];
        barAction.enabled = NO;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    if(isFromBookMark == 1)
    {
        switch ([[dictSearch objectForKey:@"num"] integerValue]) {
            case 2:
            {
                indexPress = [[[dictSearch objectForKey:@"dict"] objectForKey:@"pressindex"] integerValue];
                [self functionToLoad];
                 isFromBookMark = 0;
            }
                break;
            case 3:
            {
                 isFromBookMark = 0;
                LoadviewController *load=[[LoadviewController alloc]init];
                if(isSearch == 0)
                    load.stringSear = nil;
                else
                    load.stringSear = searchBar.text;
                load.arraySec = [[NSMutableArray alloc] initWithArray:[[dictSearch objectForKey:@"dict"] objectForKey:@"array"]];
                load.indexPress = [[dictSearch objectForKey:@"pressindex"] integerValue];
                load.StringTitle = [[NSMutableArray arrayWithArray:[[dictSearch objectForKey:@"dict"] objectForKey:@"array"]] objectAtIndex:[[dictSearch objectForKey:@"pressindex"] integerValue]];
                [self removeNot];
                
                [self.navigationController pushViewController:load animated:YES];
                [load release];
               
                break;
            }
            case 1:
            {
                isFromBookMark = 0;
                [self.navigationController popViewControllerAnimated:YES];
                //[self.navigationController dismissModalViewControllerAnimated:YES];
                break;
            }
            default:
                break;
        }
    }
   
}

-(void)setbarbutton
{
    barBack = [self.navigationController.toolbarItems objectAtIndex:0];
    if(indexPress == 0)
    {
        barBack.enabled = NO;
    }
    else
        barBack.enabled = YES;
    
    
    barfor = [self.navigationController.toolbarItems objectAtIndex:2];
    if(indexPress == [arrayAll count]-1)
    {
        barfor.enabled = NO;
    }
    else
        barfor.enabled = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    //NSLog(@"willlllll");
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


//-(IBAction)actionKeyPress:(id)sender
//{
//}

#pragma mark -arrayAfterClickAtIndex-

-(void)arrayAfterClickAtIndex:(NSInteger)index
{
    isSearch = 0;
    [searchBar setText:@""];
    arraySections = [[NSMutableArray alloc] initWithArray:[[[arrayAll objectAtIndex:indexPress] objectForKey:@"section"] componentsSeparatedByString:@","]];
    stringtitle = [[arrayAll objectAtIndex:indexPress] objectForKey:@"title"];
    
    arrayItems = [[NSMutableArray alloc] initWithArray:arraySections];
    [tableview reloadData];
}

#pragma mark -backwardkeypress-

-(IBAction)BackwardKeyPress:(NSNotificationCenter*)notification
{
    if(indexPress !=0)
    {
        [self arrayAfterClickAtIndex:--indexPress];
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

#pragma mark -fowardkeypress-

-(IBAction)ForwardKeyPress:(NSNotificationCenter*)notification
{
    if(indexPress !=([arrayAll count]-1))
    {
        [self arrayAfterClickAtIndex:++indexPress];

        //[self stringfromFileName:[arraySec objectAtIndex:++indexPress]];
        //UIBarButtonItem *barfor = [self.navigationController.toolbarItems objectAtIndex:2];
        barBack.enabled = YES;
        
        if(indexPress == [arrayAll count]-1)
        {
            barfor.enabled = NO;
        }
        else
            barfor.enabled = YES;
        
    }
    //    else
    //        barfor.enabled = NO;
    
}

#pragma mark -actionkeypress-

-(void)actionKeyPress:(NSNotificationCenter*)notification
{
    //NSLog(@"asdads");
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Bookmark", nil];
    action.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    [action showInView:self.view];
    [action release];    
}

#pragma mark -actionsheet delegate-

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
    {
        AddBookmarkViewController *addBookmark=[[AddBookmarkViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
        addBookmark.stringSave = stringtitle;
        addBookmark.stringViewNum = @"2";
        
        NSMutableDictionary *dictionayToSve = [[NSMutableDictionary   alloc] init];
        //[dictionayToSve setObject:arrayAll forKey:@"array"];
        [dictionayToSve setObject:[NSString stringWithFormat:@"%d",indexPress] forKey:@"pressindex"];
        addBookmark.dictSave = [[NSMutableDictionary alloc] initWithDictionary:dictionayToSve];
        [dictionayToSve release];

        UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:addBookmark];
        [self.navigationController presentModalViewController:infoNavController animated:YES];
       // [self presentModalViewController:addBookmark animated: YES];
        [infoNavController release];
        [addBookmark release];
    }
}

#pragma mark -bookmark notification-

-(void)ShowBookmark:(NSNotificationCenter*)notification
{
    ShowBookMarksViewController *ShowBookMarksController=[[ShowBookMarksViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:ShowBookMarksController];
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    //[self presentModalViewController:ShowBookMarksController animated: YES];
    [infoNavController release];
    [ShowBookMarksController release];
}

#pragma mark -setting notification-

-(void)Setting:(NSNotificationCenter*)notification
{
    SettingsViewController *setting=[[SettingsViewController alloc]init];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:setting];
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    //[self presentModalViewController:setting animated: YES];
    [infoNavController release];
    [setting release];
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
