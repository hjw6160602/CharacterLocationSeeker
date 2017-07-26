//
//  CharacterLocationSeeker.h
//  CharacterLocationSeekerDemo
//
//  Created by 贺嘉炜 on 2017/7/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CharacterLocationSeeker : NSObject

- (void)configWithLabel:(UILabel *)label;

- (void)configWithLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth;

- (void)configWithLabel:(UILabel *)label maxHeight:(CGFloat)maxHeight;

- (CGRect)characterRectAtIndex:(NSUInteger)charIndex;

@end
