//
//  Created by Ryan Petrich on 2012-12-20.
//

#import "CAKeyframeAnimation+Generation.h"
#import "NSValue+Interpolation.h"

@implementation CAKeyframeAnimation (Generation)

- (void)generateValuesWithFunction:(double (*)(double progress, void *context, unsigned stepCount, unsigned stepIndex))function context:(void *)functionContext start:(NSValue *)startValue end:(NSValue *)endValue steps:(NSUInteger)intermediarySteps;
{
    NSUInteger count = intermediarySteps + 2;
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:intermediarySteps + 2];
    [valueArray addObject:startValue];
    for (NSUInteger i = 1; i <= intermediarySteps; i++) {
        double progress = (double)i / (double)(count);
        double adjustedProgress = function(progress, functionContext, count, i);
        NSValue *adjustedValue = [startValue interpolatedValueWithProgress:adjustedProgress toTargetValue:endValue];
        [valueArray addObject:adjustedValue];
    }
    [valueArray addObject:endValue];
    [self setValues:valueArray];
}

@end

double LinearKeyframeGenerator(double progress, void *context, unsigned stepCount, unsigned stepIndex)
{
    return progress;
}

extern double SinusoidialGenerator(double progress, void *context, unsigned stepCount, unsigned stepIndex)
{
    return sin(progress * M_PI_2);
}

double BezierGenerator(double progress, void *context, unsigned stepCount, unsigned stepIndex)
{
    BezierGeneratorContext *realContext = context;
    return
        3.0 * progress * (1.0 - progress) * (1.0 - progress) * realContext->controlPoints[0] +
        3.0 * progress * progress * (1.0 - progress) * realContext->controlPoints[1] +
        progress * progress * progress * 1.0;
}

double ExponentialDecayGenerator(double progress, void *context, unsigned stepCount, unsigned stepIndex)
{
    ExponentialDecayGeneratorContext *realContext = context;
    double coeff = realContext->coefficient;
    double offset = exp(-coeff);
    double scale = 1.0 / (1.0 - offset);
    return 1.0 - scale * (exp(progress * -coeff) - offset);
}

double SecondOrderResponseGenerator(double progress, void *context, unsigned stepCount, unsigned stepIndex)
{
    SecondOrderResponseGeneratorContext *realContext = context;
    double omega = realContext->omega;
    double zeta = realContext->zeta;
    double beta = sqrt(1 - zeta * zeta);
	double phi = atan(beta / zeta);
	return 1.0 + -1.0 / beta * exp(-zeta * omega * progress) * sin(beta * omega * progress + phi);
}
