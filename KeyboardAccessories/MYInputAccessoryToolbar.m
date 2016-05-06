//
//  MYInputAccessoryToolbar.m
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import "MYInputAccessoryToolbar.h"

@interface MYInputAccessoryToolbar()

@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) UIBarButtonItem *prevButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@property (nonatomic, copy) NSMutableArray *inputItems;

@property (nonatomic) NSInteger activeItemIndex;
@property (nonatomic) id activeItem;
@end

@implementation MYInputAccessoryToolbar

+ (instancetype)toolbarWithInputItems:(NSArray *)items {
  return [[self alloc] initWithInputItems:items];
}

#pragma mark - Initializations

- (instancetype)init {
  self = [super init];
  if (self) {
    _inputItems = [NSMutableArray new];
    
    _prevButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:101 target:self action:@selector(prevButtonTaped)];
    _nextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:102 target:self action:@selector(nextButtonTaped)];
    _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonTaped)];
    [_doneButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} forState:UIControlStateNormal];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 20.0f;
    
    UIBarButtonItem *flexSpace  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray<UIBarButtonItem *> *barButtons = @[_prevButton, fixedSpace, _nextButton, flexSpace, _doneButton];
    
    [self sizeToFit];
    
    self.items = barButtons;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidBeginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    
  }
  return self;
}

- (instancetype) initWithInputItems:(NSArray *)items {
  self = [self init];
  
  for (id item in items) {
    [self addInputItem:item];
  }
  
  return self;
}

#pragma mark - Accessors

- (void)addInputItem:(id)item {
  if ([item respondsToSelector:@selector(setInputAccessoryView:)]) {
    [item setInputAccessoryView:self];
  }
  
  [_inputItems addObject:item];
}

#pragma mark - Actions

- (void)itemDidBeginEditing:(NSNotification *)noticifation {
  NSInteger itemIndex = [_inputItems indexOfObject:noticifation.object];
  if (itemIndex != NSNotFound && _activeItem != noticifation.object) {
    _activeItemIndex = itemIndex;
    _activeItem      = noticifation.object;
    [self activeItemChanged];
  }
}

- (void)activeItemChanged {
  _prevButton.enabled = _activeItemIndex != 0;
  _nextButton.enabled = _activeItemIndex != _inputItems.count - 1;
}

- (void)prevButtonTaped {
  [self goToPrevItem];
}

- (void)nextButtonTaped {
  [self goToNextItem];
}

- (void)goToNextItem {
  [_inputItems[_activeItemIndex + 1] becomeFirstResponder];
}

- (void)goToPrevItem {
  [_inputItems[_activeItemIndex - 1] becomeFirstResponder];
}

- (void)doneButtonTaped {
  if (_didDoneTapBlock) {
    _didDoneTapBlock(_activeItem);
  }
  [_activeItem resignFirstResponder];
}

#pragma mark - Dealloc

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
}

@end

