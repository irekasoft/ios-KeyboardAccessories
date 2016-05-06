//
//  ViewController.h
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsTVC.h"

@interface ViewController : UIViewController {
  
  FontsTVC *fontsTVC;
  
  __block Boolean flagForFonts;
  NSRange selectedRange;
}


@property (weak, nonatomic) IBOutlet UITextView *tv_one;

@end

