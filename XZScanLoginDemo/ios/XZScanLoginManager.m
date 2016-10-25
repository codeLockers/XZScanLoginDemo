//
//  XZScanLoginManager.m
//  XZScanLoginDemo
//
//  Created by 徐章 on 2016/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "XZScanLoginManager.h"
#import "XZScanLoginViewController.h"

@implementation XZScanLoginManager

RCT_EXPORT_MODULE()

- (UIView *)view{

  XZScanLoginViewController *scanLoginVc = [[XZScanLoginViewController alloc] init];
  
  return scanLoginVc.view;
}


@end
