//
//  KKTextView.m
//  ShopMall
//
//  Created by KingsleyYau on 13-4-15.
//  Copyright (c) 2013年 DrCOM. All rights reserved.
//

#import "KKTextView.h"
@implementation KKTextView
@synthesize kkTextViewDelegate;
@synthesize tipsLabel = _tipsLabel;
- (void)initialize {
    if(!self.tipsLabel) {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
        [toolBar setBarStyle:UIBarStyleBlack];
        
        UIBarButtonItem *barItem;
        NSMutableArray *mutableArray = [NSMutableArray array];
        _tipsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 160, 36)] autorelease];
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.font = [UIFont systemFontOfSize:20];
        _tipsLabel.textColor = [UIColor whiteColor];
        barItem = [[[UIBarButtonItem alloc] initWithCustomView:_tipsLabel] autorelease];
        [mutableArray addObject:barItem];
        
        barItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] autorelease];
        barItem.width = 80;
        [mutableArray addObject:barItem];
        
        barItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textViewDoneInput)] autorelease];
        [mutableArray addObject:barItem];
        
        [toolBar setItems:mutableArray];
        [self setInputAccessoryView:toolBar];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}
- (void)dealloc {
    self.kkTextViewDelegate = nil;
    [super dealloc];
}
- (void)textViewDoneInput {
    [self resignFirstResponder];
    if([self.kkTextViewDelegate respondsToSelector:@selector(textViewDoneInput:)]) {
        [self.kkTextViewDelegate textViewDoneInput:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
