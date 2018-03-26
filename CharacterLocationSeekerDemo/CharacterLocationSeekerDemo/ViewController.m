//
//  ViewController.m
//  CharacterLocationSeekerDemo
//
//  Created by 贺嘉炜 on 2017/7/25.
//
//

#import "ViewController.h"
#import "CharacterLocationSeeker.h"
#import "CharacterLocationSeeker_TextView.h"

@interface ViewController ()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIView *flagView;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) CharacterLocationSeeker *locationSeeker;
@property (strong, nonatomic) CharacterLocationSeeker_TextView *textViewSeeker;
@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViews];
    [self setupLayout];
}

#pragma mark - Setup Views
- (void)setupViews
{
    // Attributes
    // 无论如何调整label的lineBreakMode,系统的调用方法永远选择的是WordWrapping
    
//    NSString *string = @"【驴悦亲子】广州珠海双飞5日4晚自由行(前2晚住广州长隆酒店、后2晚住珠海长隆横琴湾酒店，广州进珠海返，机票可选【现在预订前20位还赠送儿童旅行成长册】";
    
    NSString *string = @"杭州、乌镇西栅、西塘巴士3日游( 赠宋城门票，船游西溪，纯玩，夜宿乌镇)";
//    NSString *string = @"珠海长隆双飞3日2晚自由行(长隆迎海酒店2晚，含接送机)";
    CGColorRef cgColor = [UIColor cyanColor].CGColor;
    CGFloat borderW = 1.f;

    
    // View Init
    UILabel *label = [UILabel new];
    label.layer.borderColor = cgColor;
    label.layer.borderWidth = borderW;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"Helvetica" size:16];
//    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    label.text = string;
    [self.view addSubview:label];
    self.label = label;
    
    UIView *flagView = [UIView new];
    flagView.frame = CGRectZero;
    flagView.layer.borderColor = [UIColor redColor].CGColor;
    flagView.layer.borderWidth = 1.f;
    flagView.clipsToBounds = YES;
    [self.label addSubview:flagView];
    self.flagView = flagView;
    
    self.buttons = [NSMutableArray arrayWithCapacity:3];
    [self.buttons addObject:[self buttonWithTitle:@"下一个字符的frame" action:@selector(onLocationSeekerButton:)]];
    [self.buttons addObject:[self buttonWithTitle:@"最后一个字符的frame" action:@selector(onTextViewButton:)]];
    [self.buttons addObject:[self buttonWithTitle:@"重置" action:@selector(onRestButton:)]];
}

- (UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action
{
    UIButton *button = [UIButton new];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.tag = 0;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)setupLayout
{
    // Layout
    [self.view addConstraint:[self.label.widthAnchor constraintEqualToConstant:394]];
    [self.view addConstraint:[self.label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100]];
    [self.view addConstraint:[self.label.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10]];
    
    __block UIView *lastView = self.label;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addConstraint:[button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]];
        [self.view addConstraint:[button.topAnchor constraintEqualToAnchor:lastView.bottomAnchor constant:50.f]];
        lastView = button;
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

#pragma mark - Actions
- (IBAction)onLocationSeekerButton:(UIButton *)sender
{
    if (!self.locationSeeker) {
        self.locationSeeker = [CharacterLocationSeeker new];
        [self.locationSeeker configWithLabel:self.label];
    }
    
    for (NSInteger index = 0; index < self.label.text.length; index ++) {
        CGRect frame = [self.locationSeeker characterRectAtIndex:index];
        NSLog(@"%@", NSStringFromCGRect(frame));
    }
    
//    [self layoutFlagWithFrame:[self.locationSeeker characterRectAtIndex:self.label.text.length - 1]];
    [self layoutFlagWithFrame:[self.locationSeeker characterRectAtIndex:sender.tag]];
    sender.tag++;
    if (sender.tag == self.label.text.length) {
        sender.tag = 0;
    }
}

- (IBAction)onTextViewButton:(UIButton *)sender
{
    if (!self.textViewSeeker) {
        self.textViewSeeker = [CharacterLocationSeeker_TextView new];
        [self.textViewSeeker configWithLabel:self.label];
    }
//    [self layoutFlagWithFrame:[self.textViewSeeker characterRectAtIndex:sender.tag]];
    [self layoutFlagWithFrame:[self.textViewSeeker characterRectAtIndex:self.label.text.length - 1]];
    
    
    sender.tag++;
    if (sender.tag == self.label.text.length) {
        sender.tag = 0;
    }
}

- (void)layoutFlagWithFrame:(CGRect)newFrame
{
    NSLog(@"%@", NSStringFromCGRect(newFrame));
    [UIView animateWithDuration:0.15 animations:^{
        self.flagView.frame = newFrame;
    }];
}

- (IBAction)onRestButton:(UIButton *)sender
{
    self.flagView.frame = CGRectZero;
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.tag = 0;
        }
    }
}

@end
