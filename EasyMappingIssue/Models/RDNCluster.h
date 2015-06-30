//
//  RDNCluster.h
//  
//
//  Created by Tsyganov Stanislav on 30/06/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RDNCluster;

@interface RDNCluster : NSManagedObject

@property (nonatomic, retain) NSNumber * clusterId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *childClusters;
@end

@interface RDNCluster (CoreDataGeneratedAccessors)

- (void)insertObject:(RDNCluster *)value inChildClustersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChildClustersAtIndex:(NSUInteger)idx;
- (void)insertChildClusters:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChildClustersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChildClustersAtIndex:(NSUInteger)idx withObject:(RDNCluster *)value;
- (void)replaceChildClustersAtIndexes:(NSIndexSet *)indexes withChildClusters:(NSArray *)values;
- (void)addChildClustersObject:(RDNCluster *)value;
- (void)removeChildClustersObject:(RDNCluster *)value;
- (void)addChildClusters:(NSOrderedSet *)values;
- (void)removeChildClusters:(NSOrderedSet *)values;
@end
