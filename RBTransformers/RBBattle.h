//
//  RBBattle.h
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-26.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTransformer.h"

typedef NS_ENUM(NSInteger, RBBattleResult) {
    RBBattleResultAutobotWins,
    RBBattleResultDecepticonWins,
    RBBattleResultBothDestroyed,
    RBBattleResultEveryoneDestroyedGameEnds,
    RBBattleResultUnknown
};

@interface RBBattle : NSObject
+ (id) new NS_UNAVAILABLE;
- (id) init NS_UNAVAILABLE;
- (id) initWithAutobot: (RBTransformer *) autobot andDecepticon: (RBTransformer *) decepticon;

@property (nonatomic, strong, readonly) RBTransformer *autobot;
@property (nonatomic, strong, readonly) RBTransformer *decepticon;
@property (nonatomic, assign) RBBattleResult *battleResult;
@end
