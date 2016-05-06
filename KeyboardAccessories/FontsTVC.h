//
//  FontsTVC.h
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontsTVC : UITableViewController

typedef void (^MYInputDidFontTap)(NSString *font);

@property (nonatomic, copy) MYInputDidFontTap didFontTapBlock;
@property (strong) NSArray *fonts;

@end
