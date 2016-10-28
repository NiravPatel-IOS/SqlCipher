//
//  ViewController.h
//  Sqlite
//
//  Created by Nirav on 9/1/16.
//  Copyright © 2016 Nirav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *timer_AddUser;
    NSTimer *timer_AddUser_2;
    NSInteger intVal;
    
    IBOutlet UIButton *btnNew;
    IBOutlet UILabel *lblCounter;
}

@end

