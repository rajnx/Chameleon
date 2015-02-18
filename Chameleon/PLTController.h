//
//  PLTController.h
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLTController : UIViewController<UIWebViewDelegate>
- (IBAction)reRun:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) NSDate *methodStart;
@property (strong, nonatomic) NSDate *methodFinish;
@end
