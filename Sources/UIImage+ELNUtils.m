//
//  UIImage+ELNUtils.m
//  Megafon
//
//  Created by Alexander Malnev on 08/12/15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "UIImage+ELNUtils.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (ELNUtils)

+ (UIImage *)eln_imageWithSize:(CGSize)size drawingBlock:(void (^)(CGRect rect, CGContextRef context))drawing
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect drawingRect = CGRectMake(0, 0, size.width, size.height);

    if (drawing) {
        drawing(drawingRect, context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)eln_imageWithColor:(UIColor *)color
{
    return [self eln_imageWithSize:CGSizeMake(1, 1) drawingBlock:^(CGRect rect, CGContextRef context) {
        [color setFill];
        [[UIBezierPath bezierPathWithRect:rect] fill];
    }];
}

+ (UIImage *)eln_ovalImageWithSize:(CGSize)size color:(UIColor *)color fill:(BOOL)fill
{
    return [self eln_imageWithSize:size drawingBlock:^(CGRect rect, CGContextRef context) {
        CGFloat px = 1 / [UIScreen mainScreen].scale;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(px, px, px, px))];
        path.lineWidth = 1;
        
        if (fill) {
            [color setFill];
            [path fill];
        } else {
            [color setStroke];
            [path stroke];
        }
    }];
}

+ (UIImage *)eln_alphaImageNamed:(NSString *)name blendedWithColor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContextWithOptions (image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [color setFill];
    CGContextFillRect(context, rect);
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, image.CGImage);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

- (UIImage *)eln_blurredImageWithRadius:(CGFloat)blurRadius saturationAdjustment:(CGFloat)saturation {
    if (self.size.width < 1.0
        || self.size.height < 1.0
        || self.CGImage == nil) {
        return nil;
    }
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = ABS(saturation - 1.0) > __FLT_EPSILON__;
    
    CGImageRef inputCGImage = self.CGImage;
    CGFloat inputImageScale = self.scale;
    
    CGSize outputImageSizeInPoints = self.size;
    CGRect outputImageRectInPoints = { CGPointZero, outputImageSizeInPoints };
    
    CGBitmapInfo inputImageBitmapInfo = CGImageGetBitmapInfo(inputCGImage);
    CGImageAlphaInfo inputImageAlphaInfo = (inputImageBitmapInfo & kCGBitmapAlphaInfoMask);
    
    BOOL useOpaqueContext = (inputImageAlphaInfo == kCGImageAlphaNone
                             || inputImageAlphaInfo == kCGImageAlphaNoneSkipLast
                             || inputImageAlphaInfo == kCGImageAlphaNoneSkipFirst);
    
    UIGraphicsBeginImageContextWithOptions(outputImageRectInPoints.size, useOpaqueContext, inputImageScale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -CGRectGetHeight(outputImageRectInPoints));
    
    if (hasBlur || hasSaturationChange) {
        vImage_Buffer effectInBuffer;
        vImage_Buffer scratchBuffer1;
        
        vImage_Buffer *inputBuffer;
        vImage_Buffer *outputBuffer;
        
        vImage_CGImageFormat format = {
            .bitsPerComponent = 8,
            .bitsPerPixel = 32,
            .colorSpace = NULL,
            .bitmapInfo = (CGBitmapInfo)(kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little),
            .version = 0,
            .decode = NULL,
            .renderingIntent = kCGRenderingIntentDefault
        };
        
        vImage_Error e = vImageBuffer_InitWithCGImage(&effectInBuffer, &format, NULL, self.CGImage, kvImageNoFlags);
        if (e != kvImageNoError) {
            UIGraphicsEndImageContext();
            return nil;
        }
        
        vImageBuffer_Init(&scratchBuffer1, effectInBuffer.height, effectInBuffer.width, format.bitsPerPixel, kvImageNoFlags);
        inputBuffer = &effectInBuffer;
        outputBuffer = &scratchBuffer1;
        
        // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
        if (hasBlur) {
            
            
            CGFloat inputRadius = blurRadius * inputImageScale;
            if (inputRadius - 2.0 < __FLT_EPSILON__)
                inputRadius = 2.0;
            uint32_t radius = floor((inputRadius * 3.0 * sqrt(2.0 * M_PI) / 4.0 + 0.5) / 2.0);
            
            radius |= 1;
            
            NSInteger tempBufferSize = vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, NULL, 0, 0, radius, radius, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
            void *tempBuffer = malloc((unsigned long)tempBufferSize);
            
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(outputBuffer, inputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(inputBuffer, outputBuffer, tempBuffer, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            
            free(tempBuffer);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
        
        // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/index.html#grayscaleEquivalent
        if (hasSaturationChange) {
            CGFloat s = saturation;
            
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0.0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0.0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0.0,
                0.0,                  0.0,                  0.0,                  1.0,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            vImageMatrixMultiply_ARGB8888(inputBuffer, outputBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            
            vImage_Buffer *temp = inputBuffer;
            inputBuffer = outputBuffer;
            outputBuffer = temp;
        }
        
        CGImageRef effectCGImage;
        if ((effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, NULL, NULL, kvImageNoAllocate, NULL)) == NULL ) {
            effectCGImage = vImageCreateCGImageFromBuffer(inputBuffer, &format, NULL, NULL, kvImageNoFlags, NULL);
            free(inputBuffer->data);
        }
        
        CGContextSaveGState(outputContext);
        CGContextDrawImage(outputContext, outputImageRectInPoints, effectCGImage);
        CGContextRestoreGState(outputContext);
        
        CGImageRelease(effectCGImage);
        free(outputBuffer->data);
    } else {
        CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage);
    }
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
