//
//  TSVServerResponseMapper.h
//  EasyMappingIssue
//
//  Created by Tsyganov Stanislav on 30/06/15.
//  Copyright (c) 2015 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDNServerResponseMapper : NSObject

- (NSArray *)mapServerResponse:(NSDictionary *)response;

@end
