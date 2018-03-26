//
//  CharacterLocationSeeker.m
//  CharacterLocationSeekerDemo
//
//  Created by 贺嘉炜 on 2017/7/25.
//
//

#import "CharacterLocationSeeker.h"

@interface CharacterLocationSeeker ()
@property (strong, nonatomic) NSTextStorage *textStorage;
@property (strong, nonatomic) NSLayoutManager *layoutManager;
@property (strong, nonatomic) NSTextContainer *textContainer;
@end

@implementation CharacterLocationSeeker

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.textStorage = [[NSTextStorage alloc] init];
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.textContainer = [[NSTextContainer alloc] init];
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
}

- (void)configWithLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth {
    [self configWithLabel:label];
    self.textContainer.size = CGSizeMake(maxWidth, label.bounds.size.height);
}

- (void)configWithLabel:(UILabel *)label maxHeight:(CGFloat)maxHeight {
    [self configWithLabel:label];
    self.textContainer.size = CGSizeMake(label.bounds.size.width, maxHeight);
}

- (void)configWithLabel:(UILabel *)label {
    self.textContainer.size = label.bounds.size;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = label.numberOfLines;
    self.textContainer.lineBreakMode = label.lineBreakMode;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSRange textRange = NSMakeRange(0, attributedText.length);
    [attributedText addAttribute:NSFontAttributeName value:label.font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = label.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [self.textStorage setAttributedString:attributedText];
}

- (CGRect)characterRectAtIndex:(NSUInteger)charIndex {
    if (charIndex >= self.textStorage.length) {
        return CGRectZero;
    }
    NSRange characterRange = NSMakeRange(charIndex, 1);
    NSRange glyphRange = [self.layoutManager glyphRangeForCharacterRange:characterRange actualCharacterRange:nil];
    return [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
}

@end
