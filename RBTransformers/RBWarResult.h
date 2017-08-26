//
//  RBWarResult.h
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-26.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTransformer.h"
#import "RBWarResult.h"
#import "RBBattle.h"

@interface RBWarResult : NSObject
-(instancetype)initWithBattlesFought: (int) battlesFought
                  winningTeamMembers: (NSArray <RBTransformer*> *) winningTeamMembersArray
          survivingLosingTeamMembers: (NSArray <RBTransformer*> *) survivingLosingTeamMembersArray
                         winningTeam: (NSString *) winningTeamNames
                          losingTeam: (NSString *) losingTeamNames
                   resultDescription: (NSString *) resultDescription
                           warResult: (RBBattleResult) result;

// war end result enum
@property (nonatomic, assign, readonly) RBBattleResult result;

// the count for how many battles took place
@property (nonatomic, assign, readonly) int battlesFought;

// an array of RBTransformer class objects of the winning team members.
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *winningTeamMembersArray;

// an array of RBTransformer class objects of the surviving losing team members.
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *survivingLosingTeamMembersArray;

// concatenated names of the winning team members
@property (nonatomic, strong, readonly) NSString *winningTeamMembersNames;

// concatenated names of the losing team members
@property (nonatomic, strong, readonly) NSString *losingTeamMembersNames;

// a concatenated full results description string
@property (nonatomic, strong, readonly) NSString *resultDescription;
@end
