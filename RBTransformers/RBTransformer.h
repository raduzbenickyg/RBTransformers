//
//  RBTransformer.h
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RBTransformerType) {
    RBTransformerTypeAutobot,
    RBTransformerTypeDecepticon,
    RBTransformerTypeUnknown
};

@interface RBTransformer : NSObject
+ (id) new NS_UNAVAILABLE;
- (id) init NS_UNAVAILABLE;
- (id) initWithSpecs: (NSArray *) specs;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) int strength;
@property (nonatomic, assign, readonly) int rank;
@property (nonatomic, assign, readonly) int courage;
@property (nonatomic, assign, readonly) int skill;
@property (nonatomic, assign, readonly) RBTransformerType type;
@property (nonatomic, assign, readonly) int overallRating;
@property (nonatomic, assign, readonly) BOOL winsByDefault;
@end
