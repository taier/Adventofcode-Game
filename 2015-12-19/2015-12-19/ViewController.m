/*
 --- Day 2: I Was Told There Would Be No Math ---
 
 The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.
 
 Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.
 
 For example:
 
 A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
 A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.
 All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?
  

*/

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
*
* Ask User for input
*
*/

- (IBAction)onInputButtonPress:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO]; // yes if more than one dir is allowed
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        if([[panel URLs] count] > 0) {
            [self calculateWrappingPaperSizeBasedOnImputFile:[[panel URLs]firstObject]]; // Start application
        }
    }
}

- (void)calculateWrappingPaperSizeBasedOnImputFile:(NSURL *)fileUrl {
    // Read everything from text
    NSString *fileContents = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil];
    
    // Separate by new line
    NSArray *allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    long overallWrappingPaperSize = 0;
    
    for (NSString *lineString in allLinedStrings) {
        overallWrappingPaperSize += [self getWrappingPaperSizeForInputDimensionString:lineString];
        NSLog(@"Current paper size: %li",overallWrappingPaperSize);
    }
    
    self.labelResult.stringValue = [NSString stringWithFormat:@"%li", overallWrappingPaperSize];
    
    return;
}

- (long)getWrappingPaperSizeForInputDimensionString:(NSString *)inputString {
    long returnValue = 0;
    
    NSArray *stringDimensionsArray = [inputString componentsSeparatedByString:@"x"];
    
    long length = [[stringDimensionsArray objectAtIndex:0] integerValue];
    long width = [[stringDimensionsArray objectAtIndex:1] integerValue];
    long height = [[stringDimensionsArray objectAtIndex:2] integerValue];
    
    long LxW = length * width;
    long WxH = width * height;
    long HxL = height * length;
    
    long minSide = MIN(MIN(LxW, WxH),HxL);
    returnValue = 2 * LxW + 2 * WxH + 2 * HxL + minSide;
    
    return returnValue;
}


@end
