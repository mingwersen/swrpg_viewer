//
//  RPGWeapon.h
//  SWRPG_Viewer
//
//  Created by matthew ingwersen on 6/13/17.
//  Copyright © 2017 matthew ingwersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGWeapon : NSObject



@property NSString* weaponName;
@property NSString* weaponKey;
@property NSString* weaponDescription;
@property NSString* weaponQuality;

@property NSString* damage;
@property int hardPoints;
@property int encumberance;
@property int critLevel;
@property NSString* rangedLevel;





@end
