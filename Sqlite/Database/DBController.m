//
//  DBController.m
//  QuickFitness
//
//  Created by Nirav on 9/1/16.
//  Copyright © 2016 Nirav. All rights reserved.
//

#import "DBController.h"

static dispatch_once_t pred;

@implementation DBController
@synthesize contactDB;

+ (id)sharedinstence {
    static DBController *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (id)init{
    
    
    return self;
}
-(NSString *)IsEmpty:(NSString *)str
{
    if ([str length] == 0)
    {
        str = @"N/A";
    }
    return str;
}

-(void)encyptDB
{
    const char*key = [[NSString stringWithFormat:@"PRAGMA key = strong"] UTF8String];
    sqlite3_exec(contactDB, key, NULL, NULL, NULL);
}

-(NSString *)getDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(void)openDB
{
    NSString *docsDir;
    docsDir = [self getDirectoryPath];
    aPath = [docsDir stringByAppendingPathComponent: @"SQLITE_DEMO.sqlite"];
    dbpath = [aPath UTF8String];
}
-(void)updateDBPath
{
    dbpath = [aPath UTF8String];
}

#pragma mark - User

-(int)queryUserVersion{
    // get current database version of schema
    [self openDB];
    static sqlite3_stmt *stmt_version;
    int databaseVersion;

    
    if(sqlite3_prepare_v2(contactDB, "PRAGMA user_version;", -1, &stmt_version, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt_version) == SQLITE_ROW) {
            databaseVersion = sqlite3_column_int(stmt_version, 0);
            NSLog(@"%s: version %d", __FUNCTION__, databaseVersion);
        }
        NSLog(@"%s: the databaseVersion is: %d", __FUNCTION__, databaseVersion);
    } else {
        NSLog(@"%s: ERROR Preparing: , %s", __FUNCTION__, sqlite3_errmsg(contactDB) );
    }
    sqlite3_finalize(stmt_version);
    
    return databaseVersion;
}

-(void)insertUser2WhileLoop:(NSInteger)intVal
{
    @synchronized(self)
    {
        NSLog(@"=============== Start DBControl insertUser2WhileLoop %ld",(long)intVal);
        [self openDB];
        [self encyptDB];
        
        const char *sqlStatement = "INSERT INTO USER2 (USER_ID,USER_FNAME,USER_LNAME,USER_PHONE,USER_EMAIL,USER_AZOVA,USER_SEX,USER_AGE,USER_CAST) VALUES (\"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")";
        sqlite3_stmt *compiledStatement;
        sqlite3 *contactDBNew;
        if (sqlite3_open(dbpath, &contactDBNew) == SQLITE_OK)
        {
            NSLog(@"sqlite3_open");
            
            if(sqlite3_prepare_v2(contactDBNew, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                sqlite3_exec(contactDBNew, "BEGIN TRANSACTION", NULL, NULL, nil);
                
                for (int i = 0; i < 200; i++) {
                    
                    sqlite3_bind_text(compiledStatement, 1, [[NSString stringWithFormat:@"UI_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 2, [[NSString stringWithFormat:@"USER_FNAME_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 3, [[NSString stringWithFormat:@"USER_LNAME_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 4, [[NSString stringWithFormat:@"USER_PHONE_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 5, [[NSString stringWithFormat:@"USER_EMAIL_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 6, [[NSString stringWithFormat:@"USER_AZOVA_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 7, [[NSString stringWithFormat:@"USER_SEX_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 8, [[NSString stringWithFormat:@"USER_AGE_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 9, [[NSString stringWithFormat:@"USER_CAST_%d",i] UTF8String], -1, NULL);
                    
                    if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
                        sqlite3_reset(compiledStatement);
                    }
                    else {
                        NSLog(@"error :%s", sqlite3_errmsg(contactDBNew));
                    }
                }
            }
            else
            {
                NSLog(@"sqlite3_open :%s", sqlite3_errmsg(contactDBNew));
            }
            
            sqlite3_exec(contactDBNew, "END TRANSACTION", NULL, NULL, nil);
            sqlite3_finalize(compiledStatement);
            
        }
        
        sqlite3_close(contactDBNew);
        //sqlite3_thread_cleanup();
        //sqlite3_db_release_memory(contactDB);
        
        NSLog(@"=============== END DBControl insertUser2WhileLoop %ld",(long)intVal);
        
    }
}

-(void)insertUserWhileLoop:(NSInteger)intVal
{
    @synchronized(self)
    {
        
        NSLog(@"=============== Start DBControl insertUserWhileLoop %ld",(long)intVal);
        [self openDB];
        [self encyptDB];
        
        const char *sqlStatement = "INSERT INTO USER (USER_ID,USER_FNAME,USER_LNAME,USER_PHONE) VALUES (?, ?, ?, ?)";
        sqlite3_stmt *compiledStatement;
        sqlite3 *contactDBNew;
        if (sqlite3_open(dbpath, &contactDBNew) == SQLITE_OK)
        {
            NSLog(@"sqlite3_open");
            if(sqlite3_prepare_v2(contactDBNew, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                sqlite3_exec(contactDBNew, "BEGIN TRANSACTION", NULL, NULL, nil);
                
                for (int i = 0; i < 200; i++) {
                    
                    sqlite3_bind_text(compiledStatement, 1, [[NSString stringWithFormat:@"UI_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 2, [[NSString stringWithFormat:@"USER_FNAME_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 3, [[NSString stringWithFormat:@"USER_LNAME_%d",i] UTF8String], -1, NULL);
                    sqlite3_bind_text(compiledStatement, 4, [[NSString stringWithFormat:@"USER_PHONE_%d",i] UTF8String], -1, NULL);
                    
                    if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
                        sqlite3_reset(compiledStatement);
                    }
                    else {
                        NSLog(@"error :%s", sqlite3_errmsg(contactDBNew));
                    }
                }
            }
            else
            {
                NSLog(@"sqlite3_open :%s", sqlite3_errmsg(contactDBNew));
            }
            
            sqlite3_exec(contactDBNew, "END TRANSACTION", NULL, NULL, nil);
            sqlite3_finalize(compiledStatement);
            
        }
        
        sqlite3_close(contactDBNew);
        //sqlite3_thread_cleanup();
        //sqlite3_db_release_memory(contactDB);
        
        NSLog(@"=============== END DBControl insertUserWhileLoop %ld",(long)intVal);
        
        }
}

-(void)getUser:(NSInteger)intVal self:(id)selfObjc
{
    @synchronized(selfObjc)
    {
        NSLog(@"=============== Start DBControl getUser %ld",(long)intVal);
        
        [self openDB];
        sqlite3 *contactDBNew;
        
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &contactDBNew) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM USER"];
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(contactDBNew, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSString *USER_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    NSString *USER_FNAME = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                    NSString *USER_LNAME = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                    NSString *USER_PHONE = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                }
            }
            else
            {
                NSLog(@"error :%s", sqlite3_errmsg(contactDBNew));
            }
            sqlite3_finalize(statement);
        }
        else
        {
            NSLog(@"error :%s", sqlite3_errmsg(contactDBNew));
        }
        sqlite3_close(contactDBNew);
        //sqlite3_db_release_memory(contactDB);
        
        NSLog(@"=============== END DBControl getUser %ld",(long)intVal);
    }
}


@end
