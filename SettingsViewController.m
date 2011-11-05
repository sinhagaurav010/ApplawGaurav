//
//  SettingsViewController.m
//  LawApp
//
//  Created by gaurav on 24/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoadviewController.h"

@implementation SettingsViewController

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
//    [arraySetting release];
//    [arrayFont release];
//    [pickerCus release];
//    [tableview release];
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
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:153/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
    pickerCus = [[PickerCustom alloc] initWithFrame:CGRectMake(0, 120, 320, 150)];
    pickerCus.client = self;
    arrayFont = [[NSMutableArray alloc] init];
    int i;
    for (i=10; i<=20; i++) {
        [arrayFont addObject:[NSString stringWithFormat:@"%d",i]];

    }
    //[arrayFont addObject:@"F"];
    [pickerCus addTheElement:arrayFont];
    pickerCus.hidden = YES;
    [self.view addSubview:pickerCus];
    
    
    [self.navigationItem setTitle:@"Setting"];
    arraySetting=[[NSMutableArray alloc]initWithObjects:@"Feedback",@"Font",@"About" ,@"Terms of Use",nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                              style:UIBarButtonItemStylePlain 
                                                                             target:self 
                                                                             action:@selector(closeBtnPressed)];
    NSLog(@"bdf");
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -pickercustomer proctocols-

- (void)pickerOptionSelectedWithIndex:(NSInteger)index
{
    fontSize = [arrayFont objectAtIndex:index];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:fontSize forKey:FONTLAW];
    [prefs synchronize];
    
    pickerCus.hidden = YES;
    
    [tableview  reloadData];
    //[editingField resignFirstResponder];
}

#pragma mark -MailComposer-

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)clickOn
{
    ////NSLog(@"clickon");
	NSArray *arrayRec = [NSArray arrayWithObjects:@"info@ctlawinfogroup.com",nil];
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		[mcvc setSubject:@"Questions or Comments?"];
		[mcvc setToRecipients:arrayRec];
        //		NSString *messageBdy = [NSString stringWithFormat:@"Name %@<br>Phone %@ <br>Address %@<br>%@<br>City %@ <br>%@<br> %@<br>special features%@",textname.text,textphone.text,textAddress.text,buttonTime.titleLabel.text,textCity.text,buttonBed.titleLabel.text,buttonBath.titleLabel.text,textfea.text];
        //		[mcvc setMessageBody:messageBdy isHTML:YES];
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
#pragma mark -tableview code-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySetting count];
}



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
    if(indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",[arraySetting objectAtIndex:indexPath.row],fontSize];//[[arrayHome objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    else
    cell.textLabel.text = [arraySetting objectAtIndex:indexPath.row];//[[arrayHome objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
		{
            [self clickOn];
            //            LoadviewController *SearchController = [[LoadviewController alloc] init];
            //            SearchController.StringTitle=@"Feednback";
            //			[self.navigationController pushViewController:SearchController animated:YES];
            //			[SearchController release];
			break;
		}
        case 1:
        {
            pickerCus.hidden = NO;
            break;
        }
        case 2:
		{
            AboutViewController *SearchController = [[AboutViewController alloc] init];
            
            SearchController.stringTitle=@"About";
            SearchController.stringName = @"about";
            SearchController.stringEX   = @"htm";
			[self.navigationController pushViewController:SearchController animated:YES];
			[SearchController release];
			break;
		}
        case 3:
		{
            AboutViewController *SearchController = [[AboutViewController alloc] init];
            
            SearchController.stringTitle=@"Terms of Use";
            SearchController.stringName = @"TC";
            SearchController.stringEX = @"htm";
			[self.navigationController pushViewController:SearchController animated:YES];
			[SearchController release];
			break;
		}
    }
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
