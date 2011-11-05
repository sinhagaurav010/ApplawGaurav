//
//  SaveInMemoryController.h
//  LocoPing
//
//  Created by Rohit Dhawan on 29/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SaveInMemoryController : NSObject {
    
}
+(void)saveInDefaultsWithKeys:(NSMutableArray*)arrayKeys andDataToSave:(NSMutableArray*)arrayData;
+(NSMutableArray*)getDataForKeys:(NSMutableArray*)arrayKeys;
+(void)removeTheDataFromKeys:(NSMutableArray*)arrayKeys;


@end
