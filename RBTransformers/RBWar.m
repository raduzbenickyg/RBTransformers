//
//  RBWar.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "RBWar.h"
#import "RBBattle.h"

@interface RBWar ()
@property (nonatomic, strong, readwrite) NSArray <RBTransformer *> * warLineup;
@property (nonatomic, strong, readwrite) NSString *Id;
@property (nonatomic, strong, readwrite) RBWarResult *warResult;
@property (nonatomic, assign, readwrite) int battlesFought;
@property (nonatomic, strong)  RXPromise *promise;

@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *battlingAutobots;
@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *battlingDecepticons;

@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *eliminatedAutobots;
@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *eliminatedDecepticons;

@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *survivingAutobots;
@property (nonatomic, strong, readwrite) NSMutableArray <RBTransformer *> *survivingDecepticons;

@property (nonatomic, strong, readwrite) NSMutableArray <RBBattle *> *battles;

@end

@implementation RBWar

-(instancetype)initWithLineup:(NSArray<RBTransformer *> *)lineup andPromise: (RXPromise *) promise{
    if (!lineup) {
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        self.Id = [[NSUUID UUID] UUIDString];
        self.warLineup = lineup;
        self.promise = promise;
        [self processLineup:self.warLineup].then (^id(id value)  {
            
            [self startWar];
            return nil;
            
        },nil).thenOnMain(nil, ^id(NSError* error){
            
            // if we can't prepare our battle lineups for any reason, we'll reject the main (war) promise given to the ViewController
            [self.promise rejectWithReason:error];
            return nil;
        });
    }
    
    return self;
}

-(void)startWar {
    
    NSLog(@"************ BATTLES STARTED *************");
    
    [self.battles enumerateObjectsUsingBlock:^(RBBattle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RBBattleResult battleResult = [self battleBetweenAutobot:obj.autobot andDecepticon:obj.decepticon];
        
        switch (battleResult) {
            case RBBattleResultAutobotWins:
            {
                NSLog(@"battle between Autobot: %@ and Decepticon: %@ RESULT: AutobotWins", obj.autobot.name, obj.decepticon.name);
                [self.eliminatedDecepticons addObject:obj.decepticon];
                [self.survivingAutobots addObject:obj.autobot];
            }
                break;
            case RBBattleResultDecepticonWins:
            {
                NSLog(@"battle between Autobot: %@ and Decepticon: %@ RESULT: DecepticonWins", obj.autobot.name, obj.decepticon.name);
                [self.eliminatedAutobots addObject:obj.autobot];
                [self.survivingDecepticons addObject:obj.decepticon];
            }
                break;
            case RBBattleResultBothDestroyed:
            {
                NSLog(@"battle between Autobot: %@ and Decepticon: %@ RESULT: BothDestroyed", obj.autobot.name, obj.decepticon.name);
                [self.eliminatedDecepticons addObject:obj.decepticon];
                [self.eliminatedAutobots addObject:obj.autobot];
            }
                break;
            case RBBattleResultEveryoneDestroyedGameEnds:
            case RBBattleResultUnknown:
            case RBBattleResultTie:
            {
                NSLog(@"battle between Autobot: %@ and Decepticon: %@ RESULT: EveryoneDestroyedGameEnds", obj.autobot.name, obj.decepticon.name);
                [self.eliminatedAutobots removeAllObjects];
                [self.eliminatedDecepticons removeAllObjects];
                self.eliminatedAutobots = [self.battlingAutobots mutableCopy];
                self.eliminatedDecepticons = [self.battlingDecepticons mutableCopy];
                *stop = YES;
            }
                break;
        }
    }];
    
    NSLog(@"************ BATTLES ENDED *************");
    
    [self decideBattleResult];
}

- (void) decideBattleResult{
    
    NSMutableString *resultString = [NSMutableString new];
    
    NSString *battleString = [NSString stringWithFormat:@"\n%d battle%@\n", self.battlesFought, self.battlesFought > 1 ? @"s": @""];
    [resultString appendString:battleString];
    
    NSString *winningString;
    NSString *losingString;
    
    NSArray * winningTeamMemberArray;
    NSArray * survivingLosingTeamMemberArray;
    
    NSString *winningTeamMemberNames;
    NSString *survivingLosingTeamMemberNames;
    
    NSString* winningTeam = @"";
    NSString* losingTeam = @"";
    
    RBBattleResult result = RBBattleResultUnknown;
    
    if (self.eliminatedAutobots.count < self.eliminatedDecepticons.count) {
        winningTeamMemberArray = [self lineupArray:self.battlingAutobots];
        survivingLosingTeamMemberArray = [self lineupArray:self.survivingDecepticons];
        
        winningTeamMemberNames = [self lineupNames:self.battlingAutobots];
        survivingLosingTeamMemberNames = [self lineupNames:self.survivingDecepticons];
        
        winningTeam = @"Autobots";
        losingTeam = @"Decepticons";
        
        winningString = [NSString stringWithFormat:@"Winning team (Autobots): %@\n", winningTeamMemberNames];
        losingString = [NSString stringWithFormat:@"Survivors from the losing team (Decepticons): %@\n", survivingLosingTeamMemberNames];
        
        result = RBBattleResultAutobotWins;
    }
    else if (self.eliminatedDecepticons.count < self.eliminatedAutobots.count) {
        winningTeamMemberArray = [self lineupArray:self.battlingDecepticons];
        survivingLosingTeamMemberArray = [self lineupArray:self.survivingAutobots];
        
        winningTeamMemberNames = [self lineupNames:self.battlingDecepticons];
        survivingLosingTeamMemberNames = [self lineupNames:self.survivingAutobots];

        winningTeam = @"Decepticons";
        losingTeam = @"Autobots";
        
        winningString = [NSString stringWithFormat:@"Winning team (Decepticons): %@\n", winningTeamMemberNames];
        losingString = [NSString stringWithFormat:@"Survivors from the losing team (Autobots): %@", survivingLosingTeamMemberNames];
        
        result = RBBattleResultDecepticonWins;
    }
    else {
        winningString = @"It's a no decision! A tie.\n";
        losingString = @"It's a no decision! A tie.";
        winningTeam = @"It's a tie";
        losingTeam = @"It's a tie";
        
        result = RBBattleResultTie;
    }
    
    [resultString appendString:winningString];
    [resultString appendString:losingString];

    self.warResult = [[RBWarResult alloc] initWithBattlesFought:self.battlesFought
                                             winningTeamMembers:winningTeamMemberArray
                                     survivingLosingTeamMembers:survivingLosingTeamMemberArray
                                                    winningTeam:winningTeam
                                                     losingTeam:losingTeam
                                              resultDescription:resultString
                                                      warResult:result];

    // This is the main (war) promise given to the ViewController, let's finish it with a result string
    [self.promise fulfillWithValue:self.warResult];
}

- (NSArray *) lineupArray:(NSArray <RBTransformer *> *) lineup {
    NSMutableArray *lineupNames = [NSMutableArray new];
    
    [lineup enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [lineupNames addObject:obj.name];
    }];
    
    return lineupNames;
}

- (NSString *) lineupNames:(NSArray <RBTransformer *> *) lineup {
    NSMutableString *str = [NSMutableString new];
    
    [lineup enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendString:obj.name];
        [str appendString:@" "];
    }];
    
    return str;
}

- (RXPromise *) processLineup: (NSArray <RBTransformer *> *) lineup {
    
    RXPromise *promise = [RXPromise new];
    [self sortWarriorsIntoTeamsFromLineup:lineup].then (^id(id value)  {
        
        return [self sortTransformes:self.battlingAutobots];
        
    },nil).then (^id(id value)  {
        
        return [self sortTransformes:self.battlingDecepticons];
        
    },nil).then (^id(id value)  {
        
        return [self trimExcessTransformers];
        
    },nil).then (^id(id value)  {
        
        return [self prepareBattleLineupBetweenAutobots:self.battlingAutobots andDecepticons:self.battlingDecepticons];
        
    },nil).thenOnMain (^id(id value)  {
        
        [promise fulfillWithValue:value];
        return nil;
        
    },nil).thenOnMain(nil, ^id(NSError* error){
        
        [self.promise rejectWithReason:error];
        return nil;
    });
    
    return promise;
}

- (RXPromise *) sortWarriorsIntoTeamsFromLineup: (NSArray <RBTransformer *> *) lineup {
    
    RXPromise *promise = [RXPromise new];
    
    [lineup enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (obj.type) {
            case RBTransformerTypeAutobot:
            {
                [self.battlingAutobots addObject:obj];
            }
                break;
            case RBTransformerTypeDecepticon:
            {
                [self.battlingDecepticons addObject:obj];
            }
                break;

            case RBTransformerTypeUnknown:
            {
                
            }
                break;

        }
    }];
    
    [promise fulfillWithValue:@"OK"];
    return promise;
}

- (RXPromise *) sortTransformes:(NSMutableArray <RBTransformer *> *) transformers {
    RXPromise *promise = [RXPromise new];
    
    [transformers sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        RBTransformer *t1 = obj1;
        RBTransformer *t2 = obj2;
        
        if (t1.rank > t2.rank) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else {
            return (NSComparisonResult)NSOrderedDescending;
        }
    }];
    
    [promise fulfillWithValue:@"OK"];
    return promise;
}

- (RXPromise *) trimExcessTransformers {
    RXPromise *promise = [RXPromise new];
    
    if (self.battlingAutobots.count != self.battlingDecepticons.count) {
        int maxCount = (int) MIN(self.battlingAutobots.count, self.battlingDecepticons.count);
        
        if (maxCount == 0) {
            self.survivingAutobots = self.battlingAutobots;
            self.survivingDecepticons = self.battlingDecepticons;
            [self.battlingAutobots removeAllObjects];
            [self.battlingDecepticons removeAllObjects];
        }
        else {
            
            int countLimit = maxCount - 1;
            
            [self.battlingAutobots enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > countLimit) {
                    // moving an overflow to survivors
                    [self.survivingAutobots addObject:obj];
                    [self.battlingAutobots removeObject:obj];
                }
            }];
            
            [self.battlingDecepticons enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > countLimit) {
                    // moving an overflow to survivors
                    [self.survivingDecepticons addObject:obj];
                    [self.battlingDecepticons removeObject:obj];
                }
            }];
        }
    }
    
    [promise fulfillWithValue:@"OK"];
    return promise;
}

- (RXPromise *) prepareBattleLineupBetweenAutobots:(NSArray <RBTransformer *> *) autobots andDecepticons:(NSArray <RBTransformer *> *) decepticons {
    
    NSLog(@"************ STARTING LINEUPS *************");
    [autobots enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"autobot: %@ overall: %d rank: %d", obj.name, obj.overallRating, obj.rank);
    }];
    
    NSLog(@"------------------------------------------");
    
    [decepticons enumerateObjectsUsingBlock:^(RBTransformer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"decepticon: %@ overall: %d rank: %d", obj.name, obj.overallRating, obj.rank);
    }];
    
    NSLog(@"******************************************\n\n");
    
    RXPromise *promise = [RXPromise new];
    
    for (int counter = 0; counter < [autobots count]; counter = counter + 1) {
        
        RBTransformer *autobot = [autobots objectAtIndex:counter];
        RBTransformer *decepticon = [decepticons objectAtIndex:counter];

        RBBattle *battle = [[RBBattle alloc] initWithAutobot:autobot andDecepticon:decepticon];
        if (battle) {
            [self.battles addObject:battle];
        }
    }
    
    [promise fulfillWithValue:@"OK"];
    return promise;
}

-(RBBattleResult) battleBetweenAutobot: (RBTransformer *) autobot andDecepticon: (RBTransformer *) decepticon {
    
    self.battlesFought = self.battlesFought + 1;
    
    // rule X
    // Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
    // In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed
    if (autobot.winsByDefault && decepticon.winsByDefault) {
        // game ends. everyone loses.
        return RBBattleResultEveryoneDestroyedGameEnds;
    }
    else if (autobot.winsByDefault && !decepticon.winsByDefault) {
        // autobot wins by rule X
        return RBBattleResultAutobotWins;
    }
    else if (decepticon.winsByDefault && !autobot.winsByDefault) {
        // autobot wins by rule X
        return RBBattleResultDecepticonWins;
    }
    
    // rule 1 If any fighter is down 4 or more points of courage and 3 or more points of strength
    // compared to their opponent, the opponent automatically wins the face-off regardless of overall rating (opponent has ran away)
    
    if ( (autobot.courage - decepticon.courage >= 4) && (autobot.strength - decepticon.strength >= 3)) {
        // autobot wins by rule 1
        return RBBattleResultAutobotWins;
    }
    else if ((decepticon.courage - autobot.courage >= 4) && (decepticon.strength - autobot.strength >= 3)) {
        // decepticon wins by rule 1
        return RBBattleResultDecepticonWins;
    }
    
    // rule 2
    // Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win
    // the fight regardless of overall rating
    
    if ( (autobot.skill - decepticon.skill >= 3)) {
        // autobot wins by rule 2
        return RBBattleResultAutobotWins;
    }
    else if ((decepticon.skill - autobot.skill >= 3)) {
        // decepticon wins by rule 2
        return RBBattleResultDecepticonWins;
    }
    
    //rule 3
    // The winner is the Transformer with the highest overall rating
    if ( (autobot.overallRating > decepticon.overallRating)) {
        // autobot wins by rule 3
        return RBBattleResultAutobotWins;
    }
    else if ((decepticon.overallRating > autobot.overallRating)) {
        // decepticon wins by rule 3
        return RBBattleResultDecepticonWins;
    }
    else {
        // it's a tie. both lose.
        return RBBattleResultAutobotWins;
    }
    
    return RBBattleResultUnknown;
}

-(NSMutableArray<RBTransformer *> *)battlingAutobots {
    if (!_battlingAutobots) {
        _battlingAutobots = [NSMutableArray new];
    }
    return _battlingAutobots;
}

-(NSMutableArray<RBTransformer *> *)battlingDecepticons {
    if (!_battlingDecepticons) {
        _battlingDecepticons = [NSMutableArray new];
    }
    return _battlingDecepticons;
}

-(NSMutableArray<RBTransformer *> *)eliminatedAutobots {
    if (!_eliminatedAutobots) {
        _eliminatedAutobots = [NSMutableArray new];
    }
    return _eliminatedAutobots;
}

-(NSMutableArray<RBTransformer *> *)eliminatedDecepticons {
    if (!_eliminatedDecepticons) {
        _eliminatedDecepticons = [NSMutableArray new];
    }
    return _eliminatedDecepticons;
}

-(NSMutableArray<RBTransformer *> *)survivingAutobots {
    if (!_survivingAutobots) {
        _survivingAutobots = [NSMutableArray new];
    }
    return _survivingAutobots;
}

-(NSMutableArray<RBTransformer *> *)survivingDecepticons {
    if (!_survivingDecepticons) {
        _survivingDecepticons = [NSMutableArray new];
    }
    return _survivingDecepticons;
}

-(NSMutableArray<RBBattle *> *)battles {
    if (!_battles) {
        _battles = [NSMutableArray new];
    }
    return _battles;
}

@end
