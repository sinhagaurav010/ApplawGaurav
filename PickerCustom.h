//
//  PickerCustom.h
//  ICMiPhoneApp
//
//  Created by Rohit Dhawan on 23/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*
.
 */
#import <UIKit/UIKit.h>

@protocol CustomPickerDelegate <NSObject>
- (void)pickerOptionSelectedWithIndex:(NSInteger)index;
//Required Protocol
@end

@interface PickerCustom : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource> {
    NSMutableArray *arrayElement;
    id<CustomPickerDelegate>client;
}
@property (retain)	id <CustomPickerDelegate> client;
-(void)addTheElement:(NSMutableArray*)array;
@end
