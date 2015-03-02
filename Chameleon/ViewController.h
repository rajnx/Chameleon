//
//  ViewController.h
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

- (IBAction)startBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *iterationsCount;
@property (weak, nonatomic) IBOutlet UITextField *url;

- (IBAction)unwindToHomePage:(UIStoryboardSegue *)segue;

@end

