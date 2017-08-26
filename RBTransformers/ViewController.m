//
//  ViewController.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "ViewController.h"
#import "RBTransformer.h"
#import "RBWarMachine.h"
#import "RXPromise/RXPromise.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startWar];
}

- (void)startWar {
    
    NSError *error;
    NSString* jsonPath = [[NSBundle mainBundle] pathForResource:@"transformers" ofType:@"json"];
    NSData *transformersJsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *transformersJson = [NSJSONSerialization JSONObjectWithData:transformersJsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        self.textView.text = error.localizedDescription;
        return;
    }
    
    // the war starts here
    [[RBWarMachine shared] startBattleWithLineup:transformersJson].thenOnMain (^id(RBWarResult* result)  {
        
        [self updateUIWithResult:result];
        return nil;
        
    },nil).thenOnMain(nil, ^id(NSError* error){
        
        NSLog(@"************ WAR ENDED WITH ERROR ************ %@", error);
        self.textView.text = error.localizedDescription;
        return nil;
    });
    
}

- (void) updateUIWithResult: (RBWarResult*) result {
    self.textView.text = result.resultDescription;
    
    NSLog(@"\n\n");
    NSLog(@"************ WAR RESULTS START ************");
    NSLog(@"winners                     : %@", result.winningTeamMembersNames);
    NSLog(@"battles fought              : %d", result.battlesFought);
    NSLog(@"winning team (%@)                   : %@", result.winningTeamMembersNames, result.winningTeamMembersArray);
    NSLog(@"survivors from losing team (%@)     : %@", result.losingTeamMembersNames, result.survivingLosingTeamMembersArray);
    NSLog(@"************ WAR RESULTS END ************");
    NSLog(@"\n\n");
}

@end
