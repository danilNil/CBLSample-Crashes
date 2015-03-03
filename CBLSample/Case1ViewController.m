//
//  Case1ViewController.m
//  CBLSample
//
//  Created by Danil Nikiforov on 02.03.15.
//  Copyright (c) 2015 Danil. All rights reserved.
//

#import "Case1ViewController.h"
#import "AppDelegate.h"
#import <CouchbaseLite/CouchbaseLite.h>

@interface Case1ViewController (){
    CBLDocument * sharedDocument;
}


@end

@implementation Case1ViewController



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
    [doc update:^BOOL(CBLUnsavedRevision * newRev) {
        newRev[@"timestamp"] = [NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970];
        NSLog(@"read doc properties inside update block: %@",doc.properties);
        return YES;
    } error:&error];
    
    if(error)
        NSLog(@"error: %@", error);
}

- (IBAction)start:(id)sender {
    sharedDocument = [self createDoc];
    for (int i=0; i<1000; i++) {
//        NSLog(@"1read new doc: %@",sharedDocument.properties);
        [self updateDoc: sharedDocument];
//        NSLog(@"1read updated doc: %@",sharedDocument.properties);
    }
    NSLog(@"1");
}





- (IBAction)startAgain:(id)sender {
    for (int i=0; i<1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self updateDoc: sharedDocument];
            NSLog(@"2read updated doc: %@",sharedDocument.properties);
        });
    }
    NSLog(@"2");
}


@end
