//
//  ViewController.m
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import "ViewController.h"
#import "IRInputAccessoryToolbar.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstrain;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden{
  return true;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self registerKeyboardNotifications];
  
  fontsTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FontsTVC"];
  
  IRInputAccessoryToolbar *input =[IRInputAccessoryToolbar toolbarWithInputItems:@[_tv_one]];
  input.didFontTapBlock = ^(id activeItem){

    if (flagForFonts== false){
      flagForFonts = true;
      self.tv_one.inputView = fontsTVC.view;
      [self.tv_one becomeFirstResponder];

    }else{
      flagForFonts = false;
      self.tv_one.inputView = nil;
      [self.tv_one becomeFirstResponder];
      
    }
    
  };
  
  input.didDoneTapBlock = ^(id activeItem){
    
    self.tv_one.inputView = nil;
    
  };
  __weak typeof(self) weakSelf = self;
  fontsTVC.didFontTapBlock = ^(NSString *font){
    
    NSLog(@"%@",font);
    
    UIFont *fontText = [UIFont fontWithName:font size:80];

    NSDictionary *dictBoldText = @{NSFontAttributeName:fontText};

    
    NSMutableAttributedString *mutAttrTextViewString = [[NSMutableAttributedString alloc] initWithAttributedString:weakSelf.tv_one.attributedText];
    
    [mutAttrTextViewString setAttributes:dictBoldText range:selectedRange];
    _tv_one.attributedText = mutAttrTextViewString;
    [weakSelf.tv_one setSelectedRange:selectedRange];
    
  };
  
}

- (void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)registerKeyboardNotifications{
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
  
 
}

#pragma mark - Keyboard Notifications Handlers




- (void)kbWillShow:(NSNotification *)notification
{

  [self updateView:notification show:true];
}


- (void)kbWillHide: (NSNotification *)notification
{

  [self updateView:notification show:false];
}

- (void)updateView:(NSNotification *)notification show:(BOOL)show
{
  
  CGRect keyboardBounds = [(NSValue *)[[notification userInfo] objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];

  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
  [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
  [UIView setAnimationBeginsFromCurrentState:YES];
  
  

  
  if (show == true) {
    self.bottomLayoutConstrain.constant = keyboardBounds.size.height;
  }else{
    self.bottomLayoutConstrain.constant = 0;

  }
  
  [UIView commitAnimations];
  
}

#pragma mark - 

- (void)textViewDidChangeSelection:(UITextView *)textView{
  selectedRange = textView.selectedRange;
  NSString *string1 = [textView.text substringWithRange:textView.selectedRange];
  NSLog(@"selected %@",string1);
  
}


@end
