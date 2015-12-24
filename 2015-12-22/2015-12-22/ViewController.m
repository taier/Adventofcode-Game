/* Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.
If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef
*/

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>

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

- (IBAction)onGenerateButtonPress:(id)sesnder {
    NSString *inputString = self.textFieldValue.stringValue;
    
    if([inputString isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Enter valid information"];
        [alert setInformativeText:@"Valid data needed to perform operation"];
        [alert setAlertStyle:NSWarningAlertStyle];
        if ([alert runModal] == NSAlertFirstButtonReturn) {
        }
        return;
    }
    
    [self findMD5HashWithZEROESforInput:inputString];
}

/**
 * Main Function, that generate result on screen
 *
 * @param input, for what MD5 has
 */

- (void)findMD5HashWithZEROESforInput:(NSString *)inputString {
    BOOL find = false;
    long counter = 0;
    NSString *md5string = @"";
    NSString *firstletters = @"";
    while (!find) {
        md5string = [NSString stringWithFormat:@"%@%li",inputString, counter];
        md5string = [ViewController generateMD5FromString:md5string];
        
        firstletters = [md5string substringToIndex:5];
        if([firstletters isEqualToString:@"00000"]) {
            find = true;
        } else {
            counter++;
        }
    }
    
    self.labelReuslt.stringValue = [NSString stringWithFormat:@"%@%li",inputString,counter];
}

/**
 * Generate MD5 Hash from giving string
 *
 * @param String that need to be MD5hased
 */

+ (NSString *)generateMD5FromString:(NSString *)inputString {
    const char *cStr = [inputString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end
