//
//  MYInputAccessoryToolbar.h
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYInputAccessoryToolbar : UIToolbar

typedef void (^MYInputAccessoryToolbarDidDoneTap)(id activeItem);

@property (nonatomic, copy) MYInputAccessoryToolbarDidDoneTap didDoneTapBlock;

+ (instancetype)toolbarWithInputItems:(NSArray *)items;

- (instancetype)initWithInputItems:(NSArray *)items;
- (void)addInputItem:(id)item;
- (void)goToNextItem;
- (void)goToPrevItem;

@end