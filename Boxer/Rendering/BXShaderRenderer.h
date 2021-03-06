//
//  BXShaderRenderer.h
//  Boxer
//
//  Created by Alun Bestor on 20/06/2012.
//  Copyright (c) 2012 Alun Bestor and contributors. All rights reserved.
//

#import "BXSupersamplingRenderer.h"

@interface BXShaderRenderer : BXSupersamplingRenderer
{
	NSArray *_shaders;
    CGSize _shaderOutputSizes[10];
    BXTexture2D *_auxiliaryBufferTexture;
    
    CGFloat _minShaderScale;
    CGFloat _maxShaderScale;
    BOOL _shadersEnabled;
    BOOL _shouldUseShaders;
}

#pragma mark -
#pragma mark Properties

//Whether to render frames using the shaders or using a fallback rendering approach.
//For performance, you may wish to turn shaders off temporarily e.g. during window resizing.
//(Note that even when this is YES, shaders may be disabled at certain scale factors.)
@property (assign, nonatomic) BOOL shadersEnabled;

//The minimum and maximum scale at which these shaders should be applied.
//Outside of these the shaders will be disabled.
@property (assign, nonatomic) CGFloat maxShaderScale;
@property (assign, nonatomic) CGFloat minShaderScale;


#pragma mark -
#pragma mark Initialization and deallocation

//Returns a new shader renderer using the specified array of shaders.
- (id) initWithShaders: (NSArray *)shaders
             inContext: (CGLContextObj)glContext
                 error: (NSError **)outError;

//Returns a new shader renderer using shaders loaded from the specified URL.
- (id) initWithContentsOfURL: (NSURL *)shaderURL
                   inContext: (CGLContextObj)glContext
                       error: (NSError **)outError;

@end
