//
//  RBWarMachine.h
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBWar.h"
#import "RXPromise/RXPromise.h"

@interface RBWarMachine : NSObject
+ (id)new NS_UNAVAILABLE;
- (id)init NS_UNAVAILABLE;
+ (RBWarMachine *)shared;

- (RXPromise *) startBattleWithLineup: (NSArray *) lineup;
@property (nonatomic, strong, readonly) RBWar *currentWar;
@end
