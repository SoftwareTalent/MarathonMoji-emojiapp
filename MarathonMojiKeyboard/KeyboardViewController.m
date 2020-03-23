//
//  KeyboardViewController.m
//  MarathonMojiKeyboard
//
//  Created by Tomorrow on 8/7/16.
//  Copyright © 2016 MarathonMoji. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardView.h"
#import "UIScrollView+ScrollIndicator.h"

@interface KeyboardViewController () <UIScrollViewDelegate> {
    UIView *allow_view;
    UIView *copy_view;
    BOOL copied;
}

@property (nonatomic, retain) KeyboardView *keyboard;

@end

@implementation KeyboardViewController


- (void)updateViewConstraints {
    [super updateViewConstraints];
    // Add custom view sizing constraints here
    
}

-(void) viewDidAppear:(BOOL)animated
{
    CGFloat _expandedHeight = 216;
    
    NSLayoutConstraint *_heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant: _expandedHeight];
  
    [self.view addConstraint: _heightConstraint];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"Keyboard" owner:nil options:nil] objectAtIndex:0];
    self.keyboard.vc = self;
    self.inputView = self.keyboard;
    
    [self.keyboard.msgview setHidden:YES];
    [self.keyboard.key_scrollview setHidden:NO];
    [self.keyboard.key_num setHidden:YES];
    
    
    int k = 0;
    
    if ([self validateKeyboardHasFullAccess]) {
        for (int i = 0; i<40; i++) {
            for (int j=0; j<2; j++) {
                k++;
                UIButton *btn_emo = [[UIButton alloc] initWithFrame:CGRectMake(20+i*80, 20+j*80, 60, 60)];
                [btn_emo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", k]] forState:UIControlStateNormal];
                [btn_emo addTarget:self action:@selector(onClickKey1:) forControlEvents:UIControlEventTouchUpInside];
                [btn_emo.imageView setContentMode:UIViewContentModeScaleAspectFit];
                [self.keyboard.key_scrollview addSubview:btn_emo];
            }
        }
        
        
        
    } else {
        
        [self displayAllowMSG];
        
    }
    
    
    
}

- (void) displayAllowMSG {
    allow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    [allow_view setBackgroundColor:[UIColor blackColor]];
    [allow_view setAlpha:0.9];
    [allow_view setTag:100];
    
    [self.keyboard.key_scrollview addSubview:allow_view];
    
    UIImageView *allow_img = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3, 50, [UIScreen mainScreen].bounds.size.width/3, 80)];
    [allow_img setImage:[UIImage imageNamed:@"allow_img.png"]];
    [allow_img setContentMode:UIViewContentModeScaleAspectFit];
    [allow_view addSubview:allow_img];
    
    UILabel *label_1 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-310)/2, 15, 310, 20)];
    [label_1 setText:@"To really enjoy this Emoji, Please allow full access in the setting"];
    
    label_1.font = [UIFont systemFontOfSize:10];
    label_1.numberOfLines = 1;
    label_1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label_1.textAlignment = NSTextAlignmentCenter;
    [allow_view addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-190)/2, 145, 190, 20)];
    [label_2 setText:@"PS: we DON'T store your typing info"];
    
    label_2.font = [UIFont systemFontOfSize:10];
    label_2.numberOfLines = 1;
    label_2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label_2.textColor = [UIColor whiteColor];
    label_2.textAlignment = NSTextAlignmentCenter;
    [allow_view addSubview:label_2];
}

- (void) viewDidLayoutSubviews {
    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height){
        //Keyboard is in Portrait
        if (![self validateKeyboardHasFullAccess]) {
            [allow_view removeFromSuperview];
            [self displayAllowMSG];
            
        }
    }
    else{
        if (![self validateKeyboardHasFullAccess]) {
            [allow_view removeFromSuperview];
            [self displayAllowMSG];
            
        }
    }
    
    
}

- (BOOL)validateKeyboardHasFullAccess {
    return !![UIPasteboard generalPasteboard];
}

- (void) viewWillAppear:(BOOL)animated
{
    
    self.keyboard.key_scrollview.delegate = self;
    
    [self.keyboard.key_scrollview setContentSize:CGSizeMake(900, self.keyboard.key_scrollview.frame.size.height)];
    [self.keyboard.key_scrollview setScrollEnabled:YES];
    [self.keyboard.key_scrollview enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypePageControl positions:JMOHorizontalScrollIndicatorPositionBottom color:[UIColor grayColor]];
    
    [self.keyboard.msgview setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    if (!self.keyboard.msgview.hidden) {
        [self.keyboard.msgview setHidden:YES];
        
    }
    
    
}



# pragma key press

- (void) onClickKey1:(id)sender
{
    UIButton* button = (UIButton*) sender;
    UIImage *img = button.imageView.image;
    
    UIPasteboard* pb = [UIPasteboard generalPasteboard];
    
    
    NSData* data = UIImagePNGRepresentation(img);
    [pb setData:data forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
    
    [self.keyboard.msgview setHidden:NO];
    
    
}

- (void) onClickKey :(id)sender
{
    UIButton* button = (UIButton*) sender;
    
    if (button.tag == 1) {
        
        //        [self.textDocumentProxy insertText:button.titleLabel.text];
        [self advanceToNextInputMode];
        
    } else if (button.tag == 2) {
        // num key
        [self.keyboard.key_scrollview setHidden:YES];
        [self.keyboard.key_num setHidden:NO];
        
        
    } else if (button.tag == 3) {
        // emoji key
        [self.keyboard.key_scrollview setHidden:NO];
        [self.keyboard.key_num setHidden:YES];
    } else if (button.tag == 4) {
        [self.textDocumentProxy insertText:@" "];
        //        [self.textDocumentProxy insertText:button.titleLabel.text];
    } else if (button.tag == 5) {
        [self.textDocumentProxy insertText:@"\n"];
    } else if (button.tag == 6) {
        [self.textDocumentProxy deleteBackward];
    } else if (button.tag ==10) {
        //        [self.textDocumentProxy insertText:@"adsf"];
        [self.textDocumentProxy insertText:button.titleLabel.text];
        
    }
    
}

- (void) copyToPasteBoard:(UIImage *) image
{
    UIPasteboard* pb = [UIPasteboard generalPasteboard];
    NSData* data = UIImagePNGRepresentation(image);
    [pb setData:data forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
}


# pragma scrollview delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.25 animations:^{
        [scrollView refreshCustomScrollIndicatorsWithAlpha:0.0];
    }];
}

- (void)dealloc
{
    [self.keyboard.key_scrollview disableCustomScrollIndicator];
    
}


@end
