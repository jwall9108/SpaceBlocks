//
//  Missle.h
//  Sprites
//
//  Created by jeremy wall on 9/23/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Layer2.h"


@interface Missile : CCSprite {
	
	CCSprite *sMissile;
	Layer2 *lParentLayer;
	
}

@property (nonatomic,retain) CCSprite *sMissile;
@property (nonatomic,retain) Layer2 *lParentLayer;


-(id) initWithLayer:(CCLayer * )layer StartPoint:(CGPoint)BeginPoint;
-(int) getRandomNumberBetween:(int)from to:(int)to;
-(void) StartMoves:(CGPoint)Start;




@end
