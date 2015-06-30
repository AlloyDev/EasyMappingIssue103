//
//  EKManagedObjectModel.h
//  EasyMappingExample
//
//  Created by Denys Telezhkin on 22.06.14.
//  Copyright (c) 2014 EasyKit. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "EKMappingProtocol.h"

#if __has_feature(nullability) // Xcode 6.3+
#pragma clang assume_nonnull begin
#else
#define nullable
#define __nullable
#endif

/**
 EKManagedObjectModel is a convenience base class for NSManagedObject subclasses. It allows creating CoreData objects from JSON representation and vice versa.
 */
@interface EKManagedObjectModel : NSManagedObject <EKManagedMappingProtocol>

/**
 Create CoreData object using provided JSON dictionary within provided NSManagedObjectContext. 
 
 This method uses EKManagedObjectMapping object, provided by objectMapping method of EKManagedMappingProtocol.
 
 @param properties parsed JSON NSDictionary.
 
 @context context, in which object will be created
 
 @return mapped object
 */
+(instancetype)objectWithProperties:(NSDictionary *)properties
                          inContext:(NSManagedObjectContext *)context;

/**
 Serialize mapped object back to JSON representation.
 
 @param context, from which object will be serialized
 
 @return NSDictionary representation of current object.
 */
- (NSDictionary *)serializedObjectInContext:(nullable NSManagedObjectContext *)context;

@end

@interface EKManagedObjectModel(Deprecated)

- (NSDictionary *)serializedObject __deprecated_msg("Use serializedObjectInContext instead");

@end


#if __has_feature(nullability)
#pragma clang assume_nonnull end
#endif
