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



@interface Block : CCSprite {
    
	
	CCSprite *Blk;
	Layer2 *myLayer;
	float dBulletVelocity;
	
}


@property (nonatomic,readwrite) float dBulletVelocity;
@property (nonatomic,retain) CCSprite *Blk;
@property (nonatomic,retain) Layer2 *myLayer;

-(void)StartMove:(int)Random;
-(id) initWithLayer:(CCLayer * )layer Velocity:(float)vel;
-(int)getRandomNumberBetween:(int)from to:(int)to;


@end
