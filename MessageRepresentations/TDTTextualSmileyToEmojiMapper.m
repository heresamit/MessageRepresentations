#import "TDTTextualSmileyToEmojiMapper.h"
#import "NSArray+FunctionalUtils.h"

// both the mapping file format and the actual substitution algorithm rely
// on the assumption that the textual smileys will occur on word boundaries
// (i.e. will never contain embedded spaces)

#define MAPPING_DATA_FILE_NAME @"TextualSmileyToEmoji"
#define MAPPING_DATA_FILE_TYPE @"txt"

static TDTTextualSmileyToEmojiMapper *sharedInstance;

@interface TDTTextualSmileyToEmojiMapper ()
@property (nonatomic, retain) NSDictionary *mappings;
@end

@implementation TDTTextualSmileyToEmojiMapper

@synthesize mappings = mappings_;

+ (void)initialize {
  if (self == [TDTTextualSmileyToEmojiMapper class]) {
    sharedInstance = [[TDTTextualSmileyToEmojiMapper alloc] init];
  }
}

+ (TDTTextualSmileyToEmojiMapper *)sharedInstance {
  return sharedInstance;
}

- (id)init {
  self = [super init];
  if (self) {
    self.mappings = [self parseMappings:[self readUTF8DataFromMappingsFile]];
  }
  return self;
}

- (NSString *)readUTF8DataFromMappingsFile {
  NSBundle *appBundle = [NSBundle bundleForClass:[self class]];
  NSString *path = [appBundle pathForResource:MAPPING_DATA_FILE_NAME ofType:MAPPING_DATA_FILE_TYPE];
  NSError *error;
  NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  if (fileContents == nil) {
    TDTLogError(@"cannot read textual smiley to emoji mapping file: %@", error);
    abort();
  }
  return fileContents;
}

// each line contains space separated strings (textual smileys), and the corresponding
// emoji character is the last column of the line:
//    <textual smiley 1> <textual smiley 2> ... <emoji>
// blank lines are ignored

- (NSDictionary *)parseMappings:(NSString *)mappings {
  NSMutableDictionary *mappingsDict = [NSMutableDictionary dictionary];
  NSArray *lines = [mappings componentsSeparatedByString:@"\n"];
  for (NSString *line in lines) {
    if ([line length] == 0) {
      continue;
    }
    NSArray *columns = [line componentsSeparatedByString:@" "];
    if ([columns count] < 2) {
      TDTLogError(@"invalid textual smiley to emoji mapping: %@", line);
      abort();
    }
    NSString *emoji = [columns lastObject];
    NSArray *textualSmileys = [columns subarrayWithRange:NSMakeRange(0, [columns count] - 1)];
    for (NSString *textualSmiley in textualSmileys) {
      [mappingsDict setValue:emoji forKey:textualSmiley];
    }
  }
  return mappingsDict;
}

- (NSString *)convertString:(NSString *)string {
  NSParameterAssert(string);

  // Doing a naive splitting of string on spaces results in corner cases (like
  // a textual smiley on the line end) not being properly converted. So we use
  // a slightly more involved iteration using a |NSScanner|.
  // We alternatively
  // - scan for (any) whitespace, and store the exact whitespace
  // - then scan the string for words, and store the replacement
  // Finally, we convert the array of stored substrings into a single string.

  __block BOOL didReplacementOccur = NO;
  NSMutableArray *reassembledStringComponents = [NSMutableArray array];
  NSCharacterSet *allWhitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];

  NSScanner *scanner = [NSScanner scannerWithString:string];
  // disable the default behaviour to skip on whitespace
  scanner.charactersToBeSkipped = nil;

  while (![scanner isAtEnd]) {

    NSString *delimiter;
    if ([scanner scanCharactersFromSet:allWhitespace intoString:&delimiter]) {
      [reassembledStringComponents addObject:delimiter];
    }

    NSString *word;
    if ([scanner scanUpToCharactersFromSet:allWhitespace intoString:&word]) {
      NSString *replacement = [self.mappings objectForKey:word];
      if (replacement) {
        didReplacementOccur = YES;
        [reassembledStringComponents addObject:replacement];
      } else {
        [reassembledStringComponents addObject:word];
      }
    }

  }

  if (didReplacementOccur) {
    return [reassembledStringComponents componentsJoinedByString:@""];
  }
  return string;
}

@end
