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

@interface RBWarResult : NSObject
-(instancetype)initWithBattlesFought: (int) battlesFought
                  winningTeamMembers: (NSArray <RBTransformer*> *) winningTeamMembers
          survivingLosingTeamMembers: (NSArray <RBTransformer*> *) survivingLosingTeamMembers
                         winningTeam: (NSString *) winningTeam
                          losingTeam: (NSString *) losingTeam
                   resultDescription: (NSString *) resultDescription;

@property (nonatomic, assign, readonly) int battlesFought;
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *winningTeamMembers;
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *survivingLosingTeamMembers;
@property (nonatomic, strong, readonly) NSString *winningTeam;
@property (nonatomic, strong, readonly) NSString *losingTeam;
@property (nonatomic, strong, readonly) NSString *resultDescription;
@end
