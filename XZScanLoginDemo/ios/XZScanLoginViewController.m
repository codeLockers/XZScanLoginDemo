//
//  XZScanLoginViewController.m
//  XZScanLoginDemo
//
//  Created by 徐章 on 2016/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "XZScanLoginViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface XZScanLoginViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@end

@implementation XZScanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor greenColor];
  
  self.session = [[AVCaptureSession alloc] init];
  self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  NSError *error;
  
  self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
  
  if (error)
    return;
  
  if ([self.session canAddInput:self.input]) {
    [self.session addInput:self.input];
  }
  
  self.output = [[AVCaptureMetadataOutput alloc] init];
  
  if ([self.session canAddOutput:self.output]) {
    [self.session addOutput:self.output];
  }
  
  [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]];
  [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
  self.output.rectOfInterest = CGRectMake(0, 0, 0.5, 0.5);

  self.preView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
  self.preView.videoGravity = AVLayerVideoGravityResizeAspectFill;
  self.preView.frame = self.view.bounds;
  
  [self.view.layer addSublayer:self.preView];
  
  [self.session startRunning];
  
  self.maskLayer = [[CAShapeLayer alloc] init];
  self.maskLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor;
  self.maskLayer.fillRule = kCAFillRuleEvenOdd;
  UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.view.frame];
  
  CGFloat width =  [UIScreen mainScreen].bounds.size.width - 100;
  CGRect scanRect = CGRectMake(50, ([UIScreen mainScreen].bounds.size.height - width)/2.0f-50, width,  width);
  
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:scanRect];
  
  clipPath.usesEvenOddFillRule = YES;
  [clipPath appendPath:maskPath];
  
  self.maskLayer.path = clipPath.CGPath;
  
  [self.view.layer addSublayer:self.maskLayer];
  
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:scanRect];
  imageView.layer.borderColor = [UIColor greenColor].CGColor;
  imageView.layer.borderWidth = 2.0f;
  [self.view addSubview:imageView];
  
  UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(scanRect.origin.x, scanRect.origin.y, scanRect.size.width, 2)];
  animationView.backgroundColor = [UIColor redColor];
  

  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
      animation.duration = 2.0f;

      animation.toValue =  animation.toValue = [NSValue valueWithCGPoint:CGPointMake(animationView.center.x,animationView.center.y+width)];
      animation.repeatCount = MAXFLOAT;

      [animationView.layer addAnimation:animation forKey:@"animation"];
    
  });

  
  

  
  [self.view addSubview:animationView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
