//
//  TSVServerResponseMapper.m
//  EasyMappingIssue
//
//  Created by Tsyganov Stanislav on 30/06/15.
//  Copyright (c) 2015 DevAlloy. All rights reserved.
//

#import "RDNServerResponseMapper.h"

#import <EasyMapping/EKManagedObjectMapping.h>
#import <MagicalRecord/MagicalRecord.h>

#import "RDNCluster+RDNMapping.h"

@implementation RDNServerResponseMapper

- (NSArray *)mapServerResponse:(NSDictionary *)response {
    
    // Creating root saving context
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    
    // Array of clusters  mapping
    NSArray *clustersRepresentation = [response valueForKey:@"clusters"];
    EKManagedObjectMapping *clustersMapping = [RDNCluster objectMapping];
    [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:clustersRepresentation
                                                        withMapping:clustersMapping
                                             inManagedObjectContext:rootSavingContext];

    // Save context
    [rootSavingContext MR_saveToPersistentStoreAndWait];
    
    // Fetch clusters
    NSArray *clusters = [RDNCluster MR_findAll];
    
    return clusters;
}

@end
