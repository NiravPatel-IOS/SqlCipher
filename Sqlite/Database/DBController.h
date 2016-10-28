//
//  DBController.h
//  QuickFitness
//
//  Created by Nirav on 9/1/16.
//  Copyright © 2016 Nirav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VIdbConfig.h"

@interface DBController : NSObject
{
    NSString *aPath;
    const char *dbpath;
    BOOL isDBOppened;
    NSDateFormatter *dateFormat_msgSection1;
    NSDateFormatter *dateFormat_msgSection2;
}
@property (atomic)sqlite3 *contactDB;

+ (id)sharedinstence;
-(void)insertUserWhileLoop:(NSInteger)intVal;
-(void)insertUser2WhileLoop:(NSInteger)intVal;

-(void)getUser:(NSInteger)intVal self:(id)selfObjc;

-(int)queryUserVersion;

@end
