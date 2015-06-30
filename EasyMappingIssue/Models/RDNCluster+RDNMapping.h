//
//  RDNCluster+RDNMapping.h
//  EasyMappingIssue
//
//  Created by Tsyganov Stanislav on 30/06/15.
//  Copyright (c) 2015 DevAlloy. All rights reserved.
//

#import "RDNCluster.h"
#import "EasyMapping.h"

@interface RDNCluster (RDNMapping) <EKManagedMappingProtocol>

- (NSString *)description;

@end
