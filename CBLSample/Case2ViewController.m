//
//  Case2ViewController.m
//  CBLSample
//
//  Created by Danil Nikiforov on 02.03.15.
//  Copyright (c) 2015 Danil. All rights reserved.
//

#import "Case2ViewController.h"
#import "AppDelegate.h"
#import <CouchbaseLite/CouchbaseLite.h>

@interface Case2ViewController (){
    CBLDocument * sharedDocument;
}


@end

@implementation Case2ViewController


- (CBLDocument*)createDoc {
    NSError* error;
    NSDictionary * dictionary = @{@"first_name": @"Danil",
                                  @"last_name" : @"Nikiforov",
                                  @"timestamp" : @"2014-04-30T17:15"};
    CBLDocument * document = [[AppDelegate database] createDocument];
    
    [document putProperties: dictionary error: &error];
    if(error)
        NSLog(@"error: %@", error);
    return document;
}

- (void)updateDoc: (CBLDocument*) doc{
    NSError* error;

    NSString* timestamp = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970];
    NSDictionary * dictionary = @{@"timestamp" : timestamp};
    
    [doc putProperties:dictionary error:&error];
    
    if(error)
        NSLog(@"error: %@", error);
}

- (void)addNewProperty: (CBLDocument*) doc{
    NSError* error;

    NSString* timestamp = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970];
    __block int i = 0;
    [doc update:^BOOL(CBLUnsavedRevision * newRev) {
        i++;
        newRev[timestamp] = @"new property";
        NSLog(@"update block called : %i times", i);
        return YES;
    } error:&error];

    
    if(error)
        NSLog(@"error: %@", error);
}

- (IBAction)start:(id)sender {
    sharedDocument = [self createDoc];
    for (int i=0; i<1000; i++) {
//                NSLog(@"1read new doc: %@",sharedDocument.properties);
        [self updateDoc: sharedDocument];
//                NSLog(@"1read updated doc: %@",sharedDocument.properties);
    }
    NSLog(@"1");
}





- (IBAction)startAgain:(id)sender {
    for (int i=0; i<1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addNewProperty: sharedDocument];
//            NSLog(@"2read updated doc: %@",sharedDocument.properties);
        });
    }
    NSLog(@"2");
}

@end
