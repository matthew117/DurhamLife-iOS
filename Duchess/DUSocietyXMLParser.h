//
//  DUSocietyXMLParser.h
//  Duchess
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import <Foundation/Foundation.h>
#import "DUSociety.h"

@interface DUSocietyXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *_societyList;
    
@private
    DUSociety *_currentSociety;
    
    BOOL _isNameTag;
    BOOL _isConstitutionTag;
    BOOL _isWebsiteTag;
    BOOL _isEmailTag;
}

@property (nonatomic, strong) NSMutableArray *societyList;

@end
