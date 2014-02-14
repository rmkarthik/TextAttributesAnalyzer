//
//  TextStatsViewControllerViewController.m
//  TextAttributesAnalyzer
//
//  Created by Karthik on 2/14/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorCharacters;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharacters;
@end

@implementation TextStatsViewController

-(void) setTextToAnalyze:(NSMutableAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if(self.view.window)    [self updateUI];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void) updateUI {
    self.colorCharacters.text = [NSString stringWithFormat:@"%d colorful characters", [[self charactersWithAttributes:NSForegroundColorAttributeName] length]];
    self.outlineCharacters.text = [NSString stringWithFormat:@"%d outlined characters", [[self charactersWithAttributes:NSStrokeWidthAttributeName] length]];
}

-(NSAttributedString *)charactersWithAttributes:(NSString *) attributeName {

    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    NSUInteger index=0;
    
    while(index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index ++;
        }
    }
    
    return characters;
}



@end
