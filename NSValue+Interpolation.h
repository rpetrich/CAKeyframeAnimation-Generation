//
//  Created by Ryan Petrich on 2012-12-20.
//

#import <Foundation/Foundation.h>

@interface NSValue (Interpolation)
- (NSValue *)interpolatedValueWithProgress:(double)progress toTargetValue:(NSValue *)target;
@end

@interface NSNumber (Interpolation)
- (NSValue *)interpolatedValueWithProgress:(double)progress toTargetValue:(NSValue *)target;
@end
