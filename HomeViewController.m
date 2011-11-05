//
//  HomeViewController.m
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "HomeViewController.h"
//#import "subTableViewController.h"
#import "SettingsViewController.h"

@implementation HomeViewController
@synthesize disableViewOverlay,tableview;

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
    //    aapDelegate = [[LawAppAppDelegate alloc] init];
    //    aapDelegate.client =  self;
    //    
    
    
    //NSLog(@"%@",self.navigationController.toolbarItems);
    
    //search.showsCancelButton = YES;
    
    
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    self.navigationController.toolbar.tintColor=[UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    
    NSString *filePath	= [[NSBundle mainBundle]pathForResource:@"LAWS" ofType:@"xml"];
	NSString *fileContents= [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"filecontents=%@",fileContents);
	NSData  *comicVideoXmlfileData= [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *_xmlDictionary = [[XMLReader dictionaryForXMLData:comicVideoXmlfileData error:&error] retain];
    //    //NSLog(@"%@",[[[[_xmlDictionary objectForKey:@"login"] objectForKey:@"login"] objectAtIndex:0] objectForKey:@"text"]);
    
    [self.navigationItem setTitle:@"CT Family Statutes"];
    
    if([[[_xmlDictionary objectForKey:@"Laws"] objectForKey:@"law"] isKindOfClass:[NSArray class]])
    {
        arrayHome=[[NSMutableArray alloc]initWithArray:[[_xmlDictionary objectForKey:@"Laws"] objectForKey:@"law"]];
    }
    else
    {
        arrayHome = [[NSMutableArray alloc] init];
        [arrayHome addObject:[[_xmlDictionary objectForKey:@"Laws"] objectForKey:@"law"]];
    }
    arrayTableItems = [[NSMutableArray alloc] initWithArray:arrayHome];
    [_xmlDictionary release];
    //NSLog(@"%@",arrayHome);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.disableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0.0f,44.0f,320.0f,416.0f)];
    self.disableViewOverlay.backgroundColor=[UIColor blackColor];
    self.disableViewOverlay.alpha = 0;
}

#pragma mark -barbutton setting-

-(void)barButtonSetting
{
    UIBarButtonItem *barNutton = [self.navigationController.toolbarItems objectAtIndex:0];
    barNutton.enabled = NO;
    
    UIBarButtonItem *barButtonBack = [self.navigationController.toolbarItems objectAtIndex:2];
    barButtonBack.enabled = NO;
}

#define mark -viewWillAppear-

- (void)viewWillAppear:(BOOL)animated
{
    [self barButtonSetting];
    if(isSearch == 1)
    {
        UIBarButtonItem *barAction = [self.navigationController.toolbarItems objectAtIndex:4];
        barAction.enabled = NO;
        
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyPress:) name:ACTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowBookmark:) name:SHOWBOOKMARK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Setting:) name:SETTING object:nil];
    
    if(isFromBookMark == 1)
    {
        switch ([[dictSearch objectForKey:@"num"] integerValue]) {
            case 2:
            {
                isFromBookMark = 0;
                SectionsViewController *load=[[SectionsViewController alloc]init];
                load.arrayAll = arrayHome;
                load.indexPress = [[[dictSearch objectForKey:@"dict"] objectForKey:@"pressindex"] integerValue];
                //NSLog(@"%d",load.indexPress);
                //load.stringtitle = [[arrayHome objectAtIndex:indexPath.row] objectForKey:@"title"];
                [self.navigationController pushViewController:load animated:YES];
                [load release];
            }
                break;
            case 3:
            {
                [self removeNot];
                SectionsViewController *load=[[SectionsViewController alloc]init];
                load.arrayAll = arrayHome;
                load.indexPress = [[[dictSearch objectForKey:@"dict"] objectForKey:@"sectionpressindex"] integerValue       ];
                //load.stringtitle = [[arrayHome objectAtIndex:indexPath.row] objectForKey:@"title"];
                [self.navigationController pushViewController:load animated:YES];
                [load release];
                break;
            }
              case 1:
                isFromBookMark = 0;
                //[self.navigationController dismissModalViewControllerAnimated:YES];
                break;
            default:
                break;
        }
        
    }

    
}

-(void)removeNot
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ACTION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWBOOKMARK object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SETTING object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    //NSLog(@"ndfnv");
    [self removeNot];
}


-(void)ShowBookmark:(NSNotificationCenter*)notification
{
    ShowBookMarksViewController *ShowBookMarksController=[[ShowBookMarksViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:ShowBookMarksController];
   
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    
    //[self.navigationController pushViewController:infoNavController animated:YES];
    //[self.navigationController pushViewController:ShowBookMarksController animated:YES];
    [infoNavController release];
    [ShowBookMarksController release];
}
-(void)actionKeyPress:(NSNotificationCenter*)notification
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Bookmark", nil];
    action.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    [action showInView:self.view];
    [action release];    
}
-(void)Setting:(NSNotificationCenter*)notification
{
    SettingsViewController *setting = [[SettingsViewController alloc]init];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:setting];
    [self.navigationController presentModalViewController:infoNavController animated:YES];
    
    //[self.navigationController pushViewController:infoNavController animated:YES];
    //[self.navigationController pushViewController:setting animated:YES];
    [infoNavController release];
    [setting release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
    {
        AddBookmarkViewController *addBookmark=[[AddBookmarkViewController alloc]init] ;//]WithNibName:@"Add Bookmark" bundle:nil];
        addBookmark.stringSave = @"CT Family Law Statutes";
        addBookmark.stringViewNum = @"1";
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"NA" forKey:@"NA"];
        addBookmark.dictSave = dict;
        [dict release];
        
        UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:addBookmark];
        [self.navigationController presentModalViewController:infoNavController animated:YES];
        //[self presentModalViewController:addBookmark animated: YES];
        
        //[self.navigationController pushViewController:infoNavController animated:YES];
        //[self.navigationController pushViewController:addBookmark animated:YES];
        [infoNavController release];
        [addBookmark release];
    }
}

#pragma mark -table code-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isSearch == 0)
        return [arrayTableItems count];
    else
        return [[[arrayTableItems objectAtIndex:section] objectForKey:@"section"] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UILabel *sectionHeader = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
    sectionHeader.backgroundColor = [UIColor colorWithRed:232/256.0 green:212/256.0 blue:191/256.0 alpha:0.8];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
    sectionHeader.textColor = [UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];

    if(isSearch == 0)
        sectionHeader.text = [NSString stringWithFormat:@"Family Statutes"];
    else
        sectionHeader.text = [[arrayTableItems objectAtIndex:section] objectForKey:@"title"];
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 45;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    if(isSearch == 1)
        return [arrayTableItems count];
    else    
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
//    NSString *stringCell = @"dfgfd";
//	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
//    if(!cell)
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:stringCell] autorelease];
//    }
    static NSString *identifier = @"cefdsf";// The cell row
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell != nil)
        return cell;
    
    NSLog(@"reload");

    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(isSearch == 0)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]; 
        
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        NSString *cellText;
        NSString *cellTitle;
        
        
        NSLog(@"here");
        cellTitle = [[arrayHome objectAtIndex:indexPath.row] objectForKey:@"name"];
        cellTitle = [cellTitle stringByAppendingString:@": "];
        //cellText = [cellText stringByAppendingString:[[arrayTableItems objectAtIndex:indexPath.row] objectForKey:@"title"]];
        cellText= [[arrayTableItems objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        cell.textLabel.textColor = [UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];

        cell.detailTextLabel.text = cellText;
        cell.textLabel.text = cellTitle;
        
    }
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]; 
        
//        cell.textLabel.numberOfLines = 2;
//        cell.detailTextLabel.numberOfLines = 2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
//        NSString *cellText;
//        NSString *cellTitle;
//        
        
        NSLog(@"----%@",[[[arrayTableItems objectAtIndex:indexPath.section] objectForKey:@"section"] objectAtIndex:indexPath.row]);
        cell.textLabel.text = [[[arrayTableItems objectAtIndex:indexPath.section] objectForKey:@"section"] objectAtIndex:indexPath.row];
    }
	//[[arrayHome objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
	cell.accessoryType = 1;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:ACTION object:nil];
    UIBarButtonItem *newBackButton				= [[UIBarButtonItem alloc] initWithTitle: @"Home" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    [newBackButton release];
    
    if(isSearch == 0)
    {
        SectionsViewController *load=[[SectionsViewController alloc]init];
        load.arrayAll = arrayHome;
        load.indexPress = indexPath.row;
        //load.stringtitle = [[arrayHome objectAtIndex:indexPath.row] objectForKey:@"title"];
        [self.navigationController pushViewController:load animated:YES];
        [load release];
    }
    else
    {
        LoadviewController  *loadController = [[LoadviewController alloc] init];
        NSMutableArray *arraYSearch = [[NSMutableArray alloc] init];
        int i;
        for(i=0;i<[arrayTableItems count];i++)
        {
            NSArray *arraySerch = [NSArray arrayWithArray:[[arrayTableItems objectAtIndex:i] objectForKey:@"section"]];
            int j;
            for(j=0;j<[arraySerch count];j++)
            {
                [arraYSearch addObject:[arraySerch objectAtIndex:j]];
            }
            //arraYSearch = [NSMutableArray arrayWithArray:[[arrayTableItems objectAtIndex:i] objectForKey:@"section"]];
        }
        loadController.arraySec = [[NSMutableArray alloc] initWithArray:arraYSearch];
        loadController.StringTitle = [arraYSearch objectAtIndex:indexPath.row];
        [arraYSearch release];
        
        int pressInd = 0;
        if(indexPath.section == 0)
            pressInd = indexPath.row;
        else
        {
            int j;
            for(j=0;j<indexPath.section;j++)
                pressInd += [[[arrayTableItems objectAtIndex:j] objectForKey:@"section"] count];
            pressInd += indexPath.row;
        }
        //NSLog(@"%d",pressInd);
        loadController.indexPress = pressInd;
        loadController.stringSear = search.text;
        
        [self.navigationController pushViewController:loadController animated:YES];
        [loadController release];
    }
    
}

#pragma mark -search bar code-

- (void)enableCancelButton:(UISearchBar *)aSearchBar {
    for (id subview in [aSearchBar subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:TRUE];
        }
    }  
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
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
+(void)setToolBarItemStatus:(BOOL)ishidden withArray:(NSArray *)arrayTool
{
    
    NSArray *arrayToolBaarItems = [NSArray arrayWithArray:arrayTool];
    int i;
    for(i=0;i<[arrayToolBaarItems count];i++)
    {
        if([[arrayToolBaarItems objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]])
        {
        UIBarButtonItem *baritem = [arrayToolBaarItems objectAtIndex:i];
        baritem.enabled = ishidden;
        }
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([[searchBar text] length]>0)
    {

        //self.navigationController.toolbarHidden = YES;
        [searchBar resignFirstResponder];
        isSearch = 1;
        tableview.scrollEnabled=YES;
        tableview.allowsSelection=YES;
        [self performSelector:@selector(enableCancelButton:) withObject:searchBar afterDelay:0.0];
        // Removing the disableViewOverlay
        [disableViewOverlay removeFromSuperview];

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Loading...";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stringFound:) name:STRINGFIND object:nil];
        
        NSMutableArray *arraYSearch = [[NSMutableArray alloc] init];
        int i;
        for(i=0;i<[arrayHome count];i++)
        {
            NSArray *arraySerch = [NSArray arrayWithArray:[[[arrayHome objectAtIndex:i] objectForKey:@"section"]componentsSeparatedByString:@","]];
            int j;
            for(j=0;j<[arraySerch count];j++)
            {
                [arraYSearch addObject:[arraySerch objectAtIndex:j]];
            }
        }
        //[arraYSearch addObject:(id)]
        modal = [[ModalController alloc] init];
        [modal searchStringForArray:arraYSearch withString:searchBar.text];
        [arraYSearch release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                        message:@"Please provide search string"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
    tableview.scrollEnabled=YES;
    tableview.allowsSelection=YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // Removing the disableViewOverlay
    [disableViewOverlay removeFromSuperview];

    //[self.navigationController setToolbarHidden:NO animated:YES];
    [HomeViewController setToolBarItemStatus:YES withArray:self.navigationController.toolbarItems];
    [self barButtonSetting];
    
    isSearch = 0;
 
    self.navigationController.toolbar.userInteractionEnabled = YES;

    arrayTableItems = [[NSMutableArray alloc] initWithArray:arrayHome];
    [self.tableview  reloadData];
    [searchBar resignFirstResponder];
}
#pragma mark -stringFound-

-(void)stringFound:(NSNotificationCenter*)notification
{
    arrayTableItems = [[NSMutableArray alloc] init];
    //[arrayTableItems removeAllObjects];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:STRINGFIND object:nil];
    int i;
    for(i=0;i<[arrayHome count];i++)
    {
        NSMutableArray *arraYSearch = [[NSMutableArray alloc] init];
        NSArray *arraySerch = [NSArray arrayWithArray:[[[arrayHome objectAtIndex:i] objectForKey:@"section"]componentsSeparatedByString:@","]];
        int j;
        for(j=0;j<[modal.arrayFilesWithString count];j++)
        {
            if([arraySerch containsObject:[modal.arrayFilesWithString objectAtIndex:j]])
                [arraYSearch addObject:[modal.arrayFilesWithString objectAtIndex:j]];
            //[arraYSearch addObject:[arraySerch objectAtIndex:j]];
        }
        if([arraYSearch count]>0)
        {
            NSMutableDictionary *dicLaw = [[NSMutableDictionary alloc] init];
            [dicLaw setObject:[[arrayHome objectAtIndex:i]objectForKey:@"title"] forKey:@"title"];
            [dicLaw setObject:arraYSearch forKey:@"section"];
            [arrayTableItems addObject:dicLaw];
            [dicLaw release];
            //[arrayTableItems addObject: ]
        }
        
        [arraYSearch release];
    }
    
    isSearch = 1;
    
    NSLog(@"%@",arrayTableItems);
    self.tableview.delegate = nil;
    self.tableview.dataSource = nil;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview reloadData];
   //[self.tableview  re]
    //[self.tableview  reloadData];
    //NSLog(@"dfsbndsf%@",modal.arrayFilesWithString);
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
