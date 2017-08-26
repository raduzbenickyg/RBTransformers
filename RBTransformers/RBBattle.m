//
//  RBBattle.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-26.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "RBBattle.h"

@interface RBBattle ()
@property (nonatomic, strong, readwrite) RBTransformer *autobot;
@property (nonatomic, strong, readwrite) RBTransformer *decepticon;
@end

@implementation RBBattle
-(instancetype)initWithAutobot:(RBTransformer *)autobot andDecepticon:(RBTransformer *)decepticon {
    self = [super init];
    
    if (self) {
        if (!autobot || !decepticon) {
            return nil;
        }
        
        self.autobot = autobot;
        self.decepticon = decepticon;
    }
    
    return self;
}

@end
