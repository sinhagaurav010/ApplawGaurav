//
//  SaveInMemoryController.m
//  LocoPing
//
//  Created by Rohit Dhawan on 29/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaveInMemoryController.h"


@implementation SaveInMemoryController


#pragma mark -saveInDefaultsWithKeys- 

+(void)saveInDefaultsWithKeys:(NSMutableArray*)arrayKeys andDataToSave:(NSMutableArray*)arrayData
{
    int i;
    for(i=0;i<[arrayKeys count];i++)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        //if(![prefs objectForKey:])
        [prefs setObject:[arrayData objectAtIndex:i] forKey:[arrayKeys  objectAtIndex:i]];
        [prefs synchronize];
    }
}


#pragma mark -getDataForKeys- 


+(NSMutableArray*)getDataForKeys:(NSMutableArray*)arrayKeys
{
    NSMutableArray *arrayData = [[[NSMutableArray alloc] init] autorelease];
    int i;
    for(i=0;i<[arrayKeys count];i++)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([prefs objectForKey:[arrayKeys objectAtIndex:i]])
            [arrayData addObject:[prefs objectForKey:[arrayKeys objectAtIndex:i]]];
    }
    return arrayData;
}



+(void)removeTheDataFromKeys:(NSMutableArray*)arrayKeys
{
    int i;
    for(i=0;i<[arrayKeys count];i++)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([prefs objectForKey:[arrayKeys objectAtIndex:i]])
            [prefs removeObjectForKey:[arrayKeys objectAtIndex:i]];
        [prefs synchronize];
    }
}


@end
