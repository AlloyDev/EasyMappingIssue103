//
//  RDNCluster+RDNMapping.m
//  EasyMappingIssue
//
//  Created by Tsyganov Stanislav on 30/06/15.
//  Copyright (c) 2015 DevAlloy. All rights reserved.
//

#import "RDNCluster+RDNMapping.h"

@implementation RDNCluster (RDNMapping)

+ (EKManagedObjectMapping *)objectMapping {
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass(self) withBlock:^(EKManagedObjectMapping *mapping) {
        mapping.primaryKey = @"clusterId";
        [mapping mapPropertiesFromArray:@[@"title"]];
        [mapping mapPropertiesFromDictionary:@{
                                               @"id" : @"clusterId"
                                               }];
        
        [mapping mapKeyPath:@"related" toProperty:@"childClusters" withValueBlock:^id(NSString *key, NSArray * relatedArray, NSManagedObjectContext *context) {
            EKManagedObjectMapping *clusterMapping = [RDNCluster relatedObjectMapping];
            NSArray *clusters = [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:relatedArray
                                                                       withMapping:clusterMapping
                                                            inManagedObjectContext:context];
            return [NSOrderedSet orderedSetWithArray:clusters];
        }];
    }];
}

+ (EKManagedObjectMapping *)relatedObjectMapping {
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass(self) withBlock:^(EKManagedObjectMapping *mapping) {
        mapping.primaryKey = @"clusterId";
        [mapping mapPropertiesFromArray:@[@"title"]];
        [mapping mapPropertiesFromDictionary:@{
                                               @"id" : @"clusterId"
                                               }];
    }];
}

- (NSString *)description {
    NSMutableString * childClustersString = [NSMutableString new];
    if (self.childClusters.count > 0) {
        for (RDNCluster *childCluster in self.childClusters) {
            [childClustersString appendString:[childCluster.clusterId stringValue]];
            [childClustersString appendString:@","];
        }
    }
    
    return [NSString stringWithFormat:@"ClusterId: %@, children: %@", self.clusterId, childClustersString];
}

@end
