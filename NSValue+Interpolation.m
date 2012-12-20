//
//  Created by Ryan Petrich on 2012-12-20.
//

#import "NSValue+Interpolation.h"

#import <CoreGraphics/CoreGraphics.h>

@implementation NSValue (Interpolation)

- (NSValue *)interpolatedValueWithProgress:(double)progress toTargetValue:(NSValue *)target
{
    const char *sourceType = [self objCType];
    const char *targetType = [target objCType];
    if (strcmp(sourceType, targetType) != 0) {
        // Types don't match!
        return nil;
    }
    CGFloat remainingProgress = 1.0 - progress;
    if (strcmp(targetType, @encode(CGPoint)) == 0) {
        CGPoint sourceValue = [self CGPointValue];
        CGPoint targetValue = [target CGPointValue];
        CGPoint finalValue;
        finalValue.x = sourceValue.x * remainingProgress + targetValue.x * progress;
        finalValue.y = sourceValue.y * remainingProgress + targetValue.y * progress;
        return [NSValue valueWithCGPoint:finalValue];
    }
    if (strcmp(targetType, @encode(CGSize)) == 0) {
        CGSize sourceValue = [self CGSizeValue];
        CGSize targetValue = [target CGSizeValue];
        CGSize finalValue;
        finalValue.width = sourceValue.width * remainingProgress + targetValue.width * progress;
        finalValue.height = sourceValue.height * remainingProgress + targetValue.height * progress;
        return [NSValue valueWithCGSize:finalValue];
    }
    if (strcmp(targetType, @encode(CGRect)) == 0) {
        CGRect sourceValue = [self CGRectValue];
        CGRect targetValue = [target CGRectValue];
        CGRect finalValue;
        finalValue.origin.x = sourceValue.origin.x * remainingProgress + targetValue.origin.x * progress;
        finalValue.origin.y = sourceValue.origin.y * remainingProgress + targetValue.origin.y * progress;
        finalValue.size.width = sourceValue.size.width * remainingProgress + targetValue.size.width * progress;
        finalValue.size.height = sourceValue.size.height * remainingProgress + targetValue.size.height * progress;
        return [NSValue valueWithCGRect:finalValue];
    }
    // TODO: Add more types
    return nil;
}

@end

@implementation NSNumber (Interpolation)

- (NSValue *)interpolatedValueWithProgress:(double)progress toTargetValue:(NSValue *)target
{
    if (![target isKindOfClass:[NSNumber class]])
        return nil;
    double sourceValue = [self doubleValue];
    double targetValue = [(NSNumber *)target doubleValue];
    double finalValue = sourceValue * (1.0 - progress) + targetValue * progress;
    return [NSNumber numberWithDouble:finalValue];
}

@end
