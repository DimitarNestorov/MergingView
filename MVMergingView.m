#import "MVMergingView.h"

@interface MVMergingView ()

@property (strong) CALayer *borderLayer;
@property (strong) CALayer *backgroundLayer;

@end

@implementation MVMergingView

- (void)layoutSubviews {
    [super layoutSubviews];

    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];

    if (!self.borderLayer) {
        CALayer *borderLayer = [CALayer layer];
        borderLayer.borderWidth = 5.f;
        borderLayer.frame = self.frame;
        borderLayer.zPosition = 10;
        borderLayer.borderColor = UIColor.blackColor.CGColor;
        self.borderLayer = borderLayer;
        [self.superview.layer addSublayer:borderLayer];
    }
    
    if (!self.backgroundLayer) {
        CALayer *backgroundLayer = [CALayer layer];
        backgroundLayer.frame = CGRectMake(self.frame.origin.x + 5.f, self.frame.origin.y + 5.f, self.frame.size.width - 10, self.frame.size.height - 10);
        backgroundLayer.zPosition = 20;
        backgroundLayer.backgroundColor = UIColor.whiteColor.CGColor;
        self.backgroundLayer = backgroundLayer;
        [self.superview.layer addSublayer:backgroundLayer];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

    CGPoint translation = [recognizer translationInView:self];
    self.frame = CGRectOffset(self.frame, translation.x, translation.y);
    [recognizer setTranslation:CGPointZero inView:self];

    self.borderLayer.frame = CGRectOffset(self.borderLayer.frame, translation.x, translation.y);
    self.backgroundLayer.frame = CGRectOffset(self.backgroundLayer.frame, translation.x, translation.y);

    [CATransaction commit];
}

@end
