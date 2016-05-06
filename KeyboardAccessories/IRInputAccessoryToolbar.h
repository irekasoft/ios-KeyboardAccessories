//
//  IRInputAccessoryToolbar.h
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsTVC.h"

@interface IRInputAccessoryToolbar : UIToolbar
typedef void (^MYInputAccessoryToolbarDidDoneTap)(id activeItem);
typedef void (^MYInputAccessoryToolbarDidFontTap)(id activeItem);

@property (nonatomic, copy) MYInputAccessoryToolbarDidDoneTap didDoneTapBlock;
@property (nonatomic, copy) MYInputAccessoryToolbarDidDoneTap didFontTapBlock;

+ (instancetype)toolbarWithInputItems:(NSArray *)items;

- (instancetype)initWithInputItems:(NSArray *)items;
- (void)addInputItem:(id)item;
- (void)goToNextItem;
- (void)goToPrevItem;
@end
