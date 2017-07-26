//
// CharacterLocationSeeker_TextView.h
//  CharacterLocationSeekerDemo
//
//  Created by 贺嘉炜 on 2017/7/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// CharacterLocationSeeker_TextView is a tool to figure out the rect of a character in UILabel, with the given character index. It uses a textView to do this
/// Usage:
///     1. Create an instance of CharacterLocationSeeker_TextView
///     2. Config it with the label
///     3. Get the rect with a certain character index

@interface CharacterLocationSeeker_TextView : NSObject

- (void)configWithLabel:(UILabel *)label;

- (CGRect)characterRectAtIndex:(NSUInteger)charIndex;

@end
