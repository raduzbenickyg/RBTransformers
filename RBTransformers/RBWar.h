//
//  RBWar.h
//  RBTransformers
//
//  Created by Raduz Benicky on 2017-08-25.
//  Copyright © 2017 Raduz Benicky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTransformer.h"
#import "RXPromise/RXPromise.h"
#import "RBWarResult.h"

@interface RBWar : NSObject
+ (id) new NS_UNAVAILABLE;
- (id) init NS_UNAVAILABLE;
- (id) initWithLineup: (NSArray <RBTransformer *> *) lineup andPromise: (RXPromise *) promise;

@property (nonatomic, strong, readonly) NSArray <RBTransformer *> * warLineup;
@property (nonatomic, strong, readonly) RBWarResult *warResult;
@property (nonatomic, strong, readonly) NSString *Id;
@end
