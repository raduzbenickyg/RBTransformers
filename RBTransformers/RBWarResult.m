//
//  RBWarResult.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-26.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "RBWarResult.h"

@interface RBWarResult ()
@property (nonatomic, assign, readwrite) int battlesFought;
@property (nonatomic, assign, readwrite) RBBattleResult result;
@property (nonatomic, strong, readwrite) NSArray <RBTransformer*> *winningTeamMembersArray;
@property (nonatomic, strong, readwrite) NSArray <RBTransformer*> *survivingLosingTeamMembersArray;
@property (nonatomic, strong, readwrite) NSString *winningTeamMembersNames;
@property (nonatomic, strong, readwrite) NSString *losingTeamMembersNames;
@property (nonatomic, strong, readwrite) NSString *resultDescription;
@end

@implementation RBWarResult

-(instancetype)initWithBattlesFought: (int) battlesFought
                  winningTeamMembers: (NSArray <RBTransformer*> *) winningTeamMembersArray
          survivingLosingTeamMembers: (NSArray <RBTransformer*> *) survivingLosingTeamMembersArray
                         winningTeam: (NSString *) winningTeamNames
                          losingTeam: (NSString *) losingTeamNames
                   resultDescription: (NSString *) resultDescription
                           warResult: (RBBattleResult) result
{
    self = [super init];
    
    if (self) {
        self.battlesFought = battlesFought;
        self.result = result;
        self.winningTeamMembersArray = winningTeamMembersArray;
        self.survivingLosingTeamMembersArray = survivingLosingTeamMembersArray;
        self.winningTeamMembersNames = winningTeamNames;
        self.losingTeamMembersNames = losingTeamNames;
        self.resultDescription = resultDescription;
    }
    
    return self;
}

@end
