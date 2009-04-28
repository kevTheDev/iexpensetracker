//
//  GlossyLabel.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 28/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GlossyLabel.h"


@implementation GlossyLabel

- (void)drawRect:(CGRect)rect 
{
	

    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// Get drawing font.
	
	CGFontRef font = CGFontCreateWithFontName((CFStringRef)[[self font] fontName]);

	CGContextSetFont(ctx, font);
	CGContextSetFontSize(ctx, [[self font] pointSize]);
	
	
	// Transform text characters to unicode glyphs.
	
	NSInteger length = [[self text] length];
	unichar chars[length];
	CGGlyph glyphs[length];
	[[self text] getCharacters:chars range:NSMakeRange(0, length)];
	CGFontGetGlyphsForUnichars(font, chars, glyphs, length);
	
	// Measure text dimensions.
	
	CGContextSetTextDrawingMode(ctx, kCGTextInvisible); 
	CGContextSetTextPosition(ctx, 0, 0);
	CGContextShowGlyphs(ctx, glyphs, length);
	CGPoint textEnd = CGContextGetTextPosition(ctx);
	
	// Calculate text drawing point.
	
	CGPoint alignment = CGPointMake(0, 0);
	CGPoint anchor = CGPointMake(textEnd.x * (-0.5), [[self font] pointSize] * (-0.25));  
	CGPoint p = CGPointApplyAffineTransform(anchor, CGAffineTransformMake(1, 0, 0, -1, 0, 1));
	
	if ([self textAlignment] == UITextAlignmentCenter) {
		alignment.x = [self bounds].size.width * 0.5 + p.x;
	}
	else if ([self textAlignment] == UITextAlignmentLeft) {
		alignment.x = 0;
	}
	else {
		alignment.x = [self bounds].size.width - textEnd.x;
	}
	
	alignment.y = [self bounds].size.height * 0.5 + p.y;
	
	// Flip back mirrored text.
	
	CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1, -1));
	
	// Draw text clipping path.
	
	//CGContextSetTextDrawingMode(ctx, kCGTextClip);

	CGContextSetTextDrawingMode(ctx, kCGTextFill);
	CGFloat backComponents[4] = { 255.0, 255.0, 255.0, 1.0}; // white
	CGContextSetFillColor(ctx, backComponents);
	CGContextShowGlyphsAtPoint(ctx, alignment.x, alignment.y, glyphs, length);
	
	// Restore text mirroring.
	
	CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
	
	// Setup gradients for background Color
	
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
	
    CGFloat components[8] = { 1.0, 1.0, 1.0, 0.95,  // Start color
	1.0, 1.0, 1.0, 0.001 }; // End color
	
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
	
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawLinearGradient(ctx, glossGradient, topCenter, midCenter, 0);
	
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
	
	
	
	
	
	
	CGContextClip(ctx);

}

//- (void)drawRect:(CGRect)rect {
//	CGContextRef ctx = UIGraphicsGetCurrentContext();
//	
//	// Get drawing font.
//	
//	CGFontRef font = CGFontCreateWithFontName((CFStringRef)[[self font] fontName]);
//	CGContextSetFont(ctx, font);
//	CGContextSetFontSize(ctx, [[self font] pointSize]);
//	
//	// Transform text characters to unicode glyphs.
//	
//	NSInteger length = [[self text] length];
//	unichar chars[length];
//	CGGlyph glyphs[length];
//	[[self text] getCharacters:chars range:NSMakeRange(0, length)];
//	CGFontGetGlyphsForUnichars(font, chars, glyphs, length);
//	
//	// Measure text dimensions.
//	
//	CGContextSetTextDrawingMode(ctx, kCGTextInvisible); 
//	CGContextSetTextPosition(ctx, 0, 0);
//	CGContextShowGlyphs(ctx, glyphs, length);
//	CGPoint textEnd = CGContextGetTextPosition(ctx);
//	
//	// Calculate text drawing point.
//	
//	CGPoint alignment = CGPointMake(0, 0);
//	CGPoint anchor = CGPointMake(textEnd.x * (-0.5), [[self font] pointSize] * (-0.25));  
//	CGPoint p = CGPointApplyAffineTransform(anchor, CGAffineTransformMake(1, 0, 0, -1, 0, 1));
//	
//	if ([self textAlignment] == UITextAlignmentCenter) {
//		alignment.x = [self bounds].size.width * 0.5 + p.x;
//	}
//	else if ([self textAlignment] == UITextAlignmentLeft) {
//		alignment.x = 0;
//	}
//	else {
//		alignment.x = [self bounds].size.width - textEnd.x;
//	}
//	
//	alignment.y = [self bounds].size.height * 0.5 + p.y;
//	
//	// Flip back mirrored text.
//	
//	CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1, -1));
//	
//		
//	// Draw text clipping path.
//	
//	CGContextSetTextDrawingMode(ctx, kCGTextClip);
//	CGContextShowGlyphsAtPoint(ctx, alignment.x, alignment.y, glyphs, length);
//	
//	// Restore text mirroring.
//	
//	CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//	
//	// Fill text clipping path with gradient.
//	
//	 size_t num_locations = 2;
//	 CGFloat locations[2] = { 0.0, 1.0 };
//	
//	 CGFloat components[8] = { 1.0, 1.0, 1.0, 0.95,  // Start color
//	1.0, 1.0, 1.0, 0.001 }; // End color
//	
//	CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
//	CGGradientRef glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
//	
//	//CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
////	CGPoint end = CGPointMake(rect.origin.x, rect.size.height);
////	CGContextDrawLinearGradient(ctx, glossGradient, start, end, 0);
//	
//	
//	CGRect currentBounds = self.bounds;
//	CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
//	CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
//	CGContextDrawLinearGradient(ctx, glossGradient, topCenter, midCenter, 0);
//	
//	// Cut outside clipping path.
//	
//	CGContextClip(ctx);
//}

@end
