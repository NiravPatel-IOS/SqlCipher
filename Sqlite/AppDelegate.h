//
//  AppDelegate.h
//  Sqlite
//
//  Created by Nirav on 9/1/16.
//  Copyright © 2016 Nirav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer *timer_;
    NSInteger intValue;
    NSInteger intValueThred2;
    
    NSInteger intCounter;
}
@property (strong, nonatomic) UIWindow *window;


@end

