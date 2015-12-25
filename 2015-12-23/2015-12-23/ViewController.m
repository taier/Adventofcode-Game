//
//  ViewController.m
//  2015-12-23
//
//  Created by Deniss Kaibagarovs on 22/12/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

/**
 * Application Enter point
 */

- (IBAction)onImputButtonPress:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO]; // yes if more than one dir is allowed
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            [self calculateNiceStrinsFromInput:url];
        }
    }
}

/**
 * Main Application Function
 *
 * @param imput file URL
 */

- (void)calculateNiceStrinsFromInput:(NSURL *)inputStringURL {
    
    // Read everything from text
    NSString *fileContents = [NSString stringWithContentsOfURL:inputStringURL encoding:NSUTF8StringEncoding error:nil];
    
    // Separate by new line
    NSArray *allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    long niceWordsCount = 0;
    
    for (NSString *lineString in allLinedStrings) {
        
        if(![ViewController checkStringForThirdRule:lineString]) {continue;}
        NSLog(@"Pass third Rule: %@",lineString);
        
        if(![ViewController checlStringForSecondRule:lineString]) {continue;}
        NSLog(@"Pass second Rule: %@",lineString);
        
        if(![ViewController checkStringForFirstRule:lineString]) {continue;}
        NSLog(@"Pass first Rule: %@",lineString);
        
        niceWordsCount++;
    }
    
    self.labelResult.stringValue = [NSString stringWithFormat:@"%li", niceWordsCount];
}

/**
 * It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
 *
 * @param Input String
 */

+ (BOOL)checkStringForThirdRule:(NSString *)string {
    BOOL pass = true;
    
    BOOL containAB = [string rangeOfString:@"ab"].location != NSNotFound;
    BOOL containCD = [string rangeOfString:@"cd"].location != NSNotFound;
    BOOL containPQ = [string rangeOfString:@"pq"].location != NSNotFound;
    BOOL containXY = [string rangeOfString:@"xy"].location != NSNotFound;
    
    if(containAB || containCD || containPQ || containXY) {
        pass = false;
    }
    
    return pass;
}

/**
 * It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd)
 *
 * @param Input String
 */

+ (BOOL)checlStringForSecondRule:(NSString *)string {
    
    BOOL hasDoubleLetter = false;
    for(int i = 1 ;i < [string length]; i++) {
        char secondChar = [string characterAtIndex:i];
        char firstChar = [string characterAtIndex:i-1];
        if (firstChar == secondChar) {
            hasDoubleLetter = true;
            break;
        }
    }
    
    return hasDoubleLetter;
}

/**
 * It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
 *
 * @param Input String
 */

+ (BOOL)checkStringForFirstRule:(NSString *)string {
    
    NSMutableArray *array = [@[] mutableCopy];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [array addObject:substring];
    }] ;
    
    NSCountedSet * set = [[NSCountedSet alloc] initWithArray:array];
    int overallCount = 0;
    
    for (NSString *nucleobase in @[@"a", @"e", @"i", @"o", @"u"]){
        NSUInteger count = [set countForObject:nucleobase];
        overallCount += count;
        NSLog(@"%@: %lu", nucleobase, (unsigned long)count);
    }
    
    return overallCount < 3 ? false : true;

}

@end
