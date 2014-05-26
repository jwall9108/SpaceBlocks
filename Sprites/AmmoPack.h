//
//  MyCocos2DClass.h
//  Sprites
//
//  Created by jeremy wall on 8/20/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import	"Layer2.h"

@interface AmmoPack : CCSprite {
    CCSprite *ammo;
	Layer2 *ParentLayer;
}

@property (nonatomic,readwrite) float dAmmoVelocity;
@property (nonatomic,retain) CCSprite *ammo;
@property (nonatomic,retain) Layer2 *ParentLayer;


-(void)StartMove:(int)Random;
-(id) initWithLayer:(CCLayer * )layer Velocity:(float)Velocity;
-(int)getRandomNumberBetween:(int)from to:(int)to;

@end
