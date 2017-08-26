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
@property (nonatomic, strong, readwrite) NSArray <RBTransformer*> *winningTeamMembers;
@property (nonatomic, strong, readwrite) NSArray <RBTransformer*> *survivingLosingTeamMembers;
@property (nonatomic, strong, readwrite) NSString * winningTeam;
@property (nonatomic, strong, readwrite) NSString *losingTeam;
@property (nonatomic, strong, readwrite) NSString *resultDescription;
@end

@implementation RBWarResult

-(instancetype)initWithBattlesFought: (int) battlesFought
                  winningTeamMembers: (NSArray <RBTransformer*> *) winningTeamMembers
          survivingLosingTeamMembers: (NSArray <RBTransformer*> *) survivingLosingTeamMembers
                         winningTeam: (NSString *) winningTeam
                          losingTeam: (NSString *) losingTeam
                   resultDescription: (NSString *) resultDescription
{
    self = [super init];
    
    if (self) {
        self.battlesFought = battlesFought;
        self.winningTeamMembers = winningTeamMembers;
        self.survivingLosingTeamMembers = survivingLosingTeamMembers;
        self.winningTeam = winningTeam;
        self.losingTeam = losingTeam;
        self.resultDescription = resultDescription;
    }
    
    return self;
}

@end
