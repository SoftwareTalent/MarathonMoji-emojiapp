//
//  KeyboardView.m
//  FishMoji
//
//  Created by mobiledev on 1/15/16.
//  Copyright © 2016 reed. All rights reserved.
//

#import "KeyboardView.h"

@implementation KeyboardView

@synthesize vc;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (IBAction)onClickKey:(id)sender {
    [vc performSelector:@selector(onClickKey:) withObject:sender];
}
@end
