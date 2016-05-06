//
//  FontsTVC.m
//  KeyboardAccessories
//
//  Created by Hijazi on 7/5/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

#import "FontsTVC.h"

@interface FontsTVC ()

@end

@implementation FontsTVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.fonts = [UIFont familyNames];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return [self.fonts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
  
  cell.textLabel.text = self.fonts[indexPath.row];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  [tableView deselectRowAtIndexPath:indexPath animated:true];
  
  if (_didFontTapBlock) {
    _didFontTapBlock(self.fonts[indexPath.row]);
  }
  
}

@end
