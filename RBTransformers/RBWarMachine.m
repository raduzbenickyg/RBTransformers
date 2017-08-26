//
//  RBWarMachine.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "RBWarMachine.h"

@interface RBWarMachine ()
@property (nonatomic, strong, readwrite) RBWar *currentWar;
@end

@implementation RBWarMachine
+ (RBWarMachine *)shared
{
    static dispatch_once_t predicate;
    static RBWarMachine *shared;
    
    dispatch_once(&predicate, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (RXPromise *) startBattleWithLineup: (NSArray *) lineup {
    
    RXPromise *promise = [RXPromise new];
    
    if (!self.currentWar && lineup) {
        self.currentWar = [[RBWar alloc] initWithLineup:[self parseLineup:lineup] andPromise:promise];
    }
    else {
        [promise rejectWithReason:@"UNABLE TO START WAR"];
    }
    
    promise.thenOnMain (^id(id value)  {
        
        self.currentWar = nil;
        return nil;
        
    },nil).thenOnMain(nil, ^id(NSError* error){
        
        self.currentWar = nil;
        return nil;
    });
    
    return promise;
}

- (NSArray <RBTransformer *> *) parseLineup: (NSArray *) lineup {
    NSMutableArray *transformers = [NSMutableArray new];
    
    [lineup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RBTransformer *transformer = [[RBTransformer alloc] initWithSpecs:obj];
        if (transformer) [transformers addObject:transformer];
    }];
    
    return transformers;
}

@end
