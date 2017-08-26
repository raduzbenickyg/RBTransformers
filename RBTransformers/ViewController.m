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
}

- (IBAction)startWar:(UIButton *)sender {
    
    sender.enabled = NO;
    
    NSError *error;
    NSString* jsonPath = [[NSBundle mainBundle] pathForResource:@"transformers" ofType:@"json"];
    NSData *transformersJsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *transformersJson = [NSJSONSerialization JSONObjectWithData:transformersJsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        sender.enabled = YES;
        self.textView.text = error.localizedDescription;
        return;
    }
    
    // the war starts here
    [[RBWarMachine shared] startBattleWithLineup:transformersJson].thenOnMain (^id(RBWarResult* result)  {
        
        [self updateUIWithResult:result];
        sender.enabled = YES;
        return nil;
        
    },nil).thenOnMain(nil, ^id(NSError* error){
        
        sender.enabled = YES;
        NSLog(@"************ WAR ENDED WITH ERROR ************ %@", error);
        self.textView.text = error.localizedDescription;
        return nil;
    });
    
}

- (void) updateUIWithResult: (RBWarResult*) result {
    self.textView.text = result.resultDescription;
    
    NSLog(@"\n\n");
    NSLog(@"************ WAR RESULTS START ************");
    NSLog(@"winners                     : %@", result.winningTeam);
    NSLog(@"battles fought              : %d", result.battlesFought);
    NSLog(@"winning team (%@)                   : %@", result.winningTeam, result.winningTeamMembers);
    NSLog(@"survivors from losing team (%@)     : %@", result.losingTeam, result.survivingLosingTeamMembers);
    NSLog(@"************ WAR RESULTS END ************");
    NSLog(@"\n\n");
}

@end
