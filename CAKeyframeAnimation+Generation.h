//  Created by Ryan Petrich on 2012-12-20.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (Generation)

- (void)generateValuesWithFunction:(double (*)(double progress, void *context, unsigned stepCount, unsigned stepIndex))function context:(void *)functionContext start:(NSValue *)startValue end:(NSValue *)endValue steps:(NSUInteger)intermediarySteps;

@end

extern double LinearGenerator(double, void *, unsigned, unsigned);

extern double SinusoidialGenerator(double, void *, unsigned, unsigned);

extern double BezierGenerator(double, void *, unsigned, unsigned);
typedef struct {
    double controlPoints[2];
} BezierGeneratorContext;

extern double ExponentialDecayGenerator(double, void *, unsigned, unsigned);
typedef struct {
    double coefficient;
} ExponentialDecayGeneratorContext;

extern double SecondOrderResponseGenerator(double, void *, unsigned, unsigned);
typedef struct {
    double omega;
    double zeta;
} SecondOrderResponseGeneratorContext;
