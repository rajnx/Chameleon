//
//  ReportController.h
//  Chameleon
//
//  Created by Rajneesh . on 2/18/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *reportView;
@property (strong, nonatomic) NSString *reportString;
@end
