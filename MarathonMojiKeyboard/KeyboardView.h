//
//  KeyboardView.h
//  FishMoji
//
//  Created by mobiledev on 1/15/16.
//  Copyright © 2016 reed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+ScrollIndicator.h"


@interface KeyboardView : UIView 
@property (nonatomic, retain) id vc;
@property (strong, nonatomic) IBOutlet UIScrollView *key_scrollview;
@property (strong, nonatomic) IBOutlet UIView *msgview;
@property (strong, nonatomic) IBOutlet UIView *key_num;

- (IBAction)onClickKey:(id)sender;
@end
