//
//  RBTransformer.m
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import "RBTransformer.h"

@interface RBTransformer ()
@property (nonatomic, assign, readwrite) int overallRating;
@property (nonatomic, assign, readwrite) BOOL winsByDefault;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) int strength;
@property (nonatomic, assign, readwrite) int rank;
@property (nonatomic, assign, readwrite) int courage;
@property (nonatomic, assign, readwrite) int skill;
@property (nonatomic, assign, readwrite) RBTransformerType type;
@property (nonatomic, assign) int intelligence;
@property (nonatomic, assign) int speed;
@property (nonatomic, assign) int endurance;
@property (nonatomic, assign) int firepower;
@end

@implementation RBTransformer

- (instancetype) initWithSpecs: (NSArray *) specs; {
    
    self = [super init];
    if (self) {
        
        __block BOOL error = NO;
        
        if (specs.count != 10) {
            error = YES;
        }
        
        [specs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >= 2) {
                int value = [self checkValue:obj];
                if (value == -1) {
                    error = YES;
                    *stop = YES;
                }
            }
        }];
        
        if (error) return nil;
        
        [specs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                {
                    self.name = obj;
                }
                    break;
                case 1:
                {
                    if ([obj isEqualToString:@"A"]) {
                        self.type = RBTransformerTypeAutobot;
                    }
                    else if ([obj isEqualToString:@"D"]) {
                        self.type = RBTransformerTypeDecepticon;
                    }
                    else {
                        error = YES;
                    }
                }
                    break;
                case 2:
                {
                    self.strength = [obj intValue];
                }
                    break;
                case 3:
                {
                    self.intelligence = [obj intValue];
                }
                    break;
                case 4:
                {
                    self.speed = [obj intValue];
                }
                    break;
                case 5:
                {
                    self.endurance = [obj intValue];
                }
                    break;
                case 6:
                {
                    self.rank = [obj intValue];
                }
                    break;
                case 7:
                {
                    self.courage = [obj intValue];
                }
                    break;
                case 8:
                {
                    self.firepower = [obj intValue];
                }
                    break;
                case 9:
                {
                    self.skill = [obj intValue];
                }
                    break;
            }
            
        }];
        
        if (error) return nil;
    }
    
    return self;
}

- (int) checkValue: (NSNumber *) obj {
    int value = [obj intValue];
    if (value >= 1 && value <= 10) {
        return value;
    }
    return -1;
}

-(int )overallRating {
    int overallRating = self.strength + self.intelligence + self.speed + self.endurance + self.firepower;
    return overallRating;
}

-(BOOL)winsByDefault {
    if ([self.name isEqualToString:@"Optimus Prime"] || [self.name isEqualToString:@"Predaking"] ) {
        return YES;
    }
    return NO;
}

@end
