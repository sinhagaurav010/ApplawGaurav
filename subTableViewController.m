//
//  subTableViewController.m
//  LawApp
//
//  Created by gaurav on 16/08/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "subTableViewController.h"
#import "XMLReader.h"
#import "SectionsViewController.h"

@implementation subTableViewController

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
    [self.navigationItem setTitle:@"Title II"];
    arrySubTable=[[NSMutableArray alloc]init];
    [arrySubTable addObject:@"815a	Family Matters	"];
    [arrySubTable addObject:@"815e Marriage	"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrySubTable count];
}
- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionHeader = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
    sectionHeader.backgroundColor = [UIColor grayColor];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
    sectionHeader.textColor = [UIColor whiteColor];
    sectionHeader.text = [NSString stringWithFormat:@" "];
    return sectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell] ;
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell] autorelease];
    }
	cell.textLabel.text = [arrySubTable objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
		{
            SectionsViewController *load=[[SectionsViewController alloc]init];
            [self.navigationController pushViewController:load animated:YES];
            [load release];
        }
            
    }
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
