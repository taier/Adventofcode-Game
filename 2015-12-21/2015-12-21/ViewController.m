/*
 Santa is delivering presents to an infinite two-dimensional grid of houses.
 
 He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.
 
 However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?
 
 For example:
 
 > delivers presents to 2 houses: one at the starting location, and one to the east.
 ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
 ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
 */

#import "ViewController.h"
#import "Node.h"

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
            [self calculateVisitedHouseCountFromInputFile:[[panel URLs]firstObject]]; // Start application
        }
    }
}

/**
 * Calculate how many houses Santa has visited. Output in _visitedHouses
 *
 *@param Input File URL
 */

- (void)calculateVisitedHouseCountFromInputFile:(NSURL*)fileUrl {
    
    // Read everything from text
    NSString *fileContents = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil];
    CGPoint currentPosition = CGPointMake(500, 500);
    int matrix[1000][1000] = {0,0};
    int visitedHouses = 1; // For start one
   
    for (int i = 0; i < [fileContents length]; i++) {
        NSString *currentMove = [NSString stringWithFormat:@"%C", [fileContents characterAtIndex:i]];
        NSLog(@"Current Move:%@",currentMove);
        currentPosition = [ViewController getCurrentPossitionAfterMove:currentMove currentPosition:currentPosition];
        int visitSingleHouseCount = matrix[(int)currentPosition.x][(int)currentPosition.y];
        
        visitSingleHouseCount++;
        NSLog(@"Single Present:%i",visitSingleHouseCount);
        if (visitSingleHouseCount == 1) {
            visitedHouses++;
             NSLog(@"Visited Houses:%i",visitedHouses);
        }
        
        matrix[(int)currentPosition.x][(int)currentPosition.y] = visitSingleHouseCount;
    }
    
    self.labelResult.stringValue = [NSString stringWithFormat:@"%i",visitedHouses];
    
}

/**
 * Move current position to new location and return new current position
 */

+ (CGPoint)getCurrentPossitionAfterMove:(NSString *)moveDirection currentPosition:(CGPoint)currentPosition {
    
    if ([moveDirection isEqualToString:@"^"]) {
        currentPosition = [self moveCurrentPositionUp:currentPosition];
    } else if ([moveDirection isEqualToString:@"<"]) {
        currentPosition = [self moveCurrentPositionLeft:currentPosition];
    } else if ([moveDirection isEqualToString:@">"]) {
        currentPosition = [self moveCurrentPositionRight:currentPosition];
    } else if ([moveDirection isEqualToString:@"v"]) {
        currentPosition = [self moveCurrentPositionDown:currentPosition];
    }
    
    NSLog(@"Current Position X:%.0f Y:%.0f",currentPosition.x,currentPosition.y);
    return currentPosition;
}

/**
 * Move current position and return updated current
 */

+ (CGPoint)moveCurrentPositionUp:(CGPoint)currentPosition {
    return CGPointMake(currentPosition.x, currentPosition.y + 1);
}

/**
 * Move current position and return updated current
 */

+ (CGPoint)moveCurrentPositionLeft:(CGPoint)currentPosition {
    return CGPointMake(currentPosition.x - 1, currentPosition.y);
}

/**
 * Move current position and return updated current
 */

+ (CGPoint)moveCurrentPositionRight:(CGPoint)currentPosition {
    return CGPointMake(currentPosition.x + 1, currentPosition.y);

}

/**
 * Move current position and return updated current
 */

+ (CGPoint)moveCurrentPositionDown:(CGPoint)currentPosition {
   return CGPointMake(currentPosition.x, currentPosition.y - 1);
}

@end
