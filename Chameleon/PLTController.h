//
//  PLTController.h
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HtmlLog.h"

@interface PLTController : UIViewController<UIWebViewDelegate>
- (IBAction)reRun:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewReport;

@property (strong, nonatomic) NSDate *webViewRequestLoadStart;
@property (strong, nonatomic) NSDate *webViewLoadStart;
@property (strong, nonatomic) NSDate *webViewLoadFinish;

@property (nonatomic) BOOL isLoadStarted;

@property(strong, nonatomic) NSString *loadStartTime;
@property(strong, nonatomic) NSString *loadCompleteTime;

@property(nonatomic) int noOfIterations;

@property (strong, nonatomic) HtmlLog *log;
@property (weak) NSTimer *timer;
-(void)analyzePage:(NSTimer *)timer;

@end
