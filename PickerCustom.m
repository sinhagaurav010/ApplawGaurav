//
//  PickerCustom.m
//  ICMiPhoneApp
//
//  Created by Rohit Dhawan on 23/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerCustom.h"


@implementation PickerCustom
@synthesize client;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsSelectionIndicator = YES;
        // Initialization code
    }
    return self;
}

-(void)addTheElement:(NSMutableArray*)array
{
    arrayElement = [[NSMutableArray alloc] init];
    arrayElement = array;
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrayElement count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrayElement objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        [self.client pickerOptionSelectedWithIndex:row];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
