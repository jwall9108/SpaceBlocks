//
//  Missle.m
//  Sprites
//
//  Created by jeremy wall on 9/23/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import "Missile.h"
#import "Block.h"
#import "AmmoPack.h"

@implementation Missile

@synthesize sMissile = _sMissile, lParentLayer = _lParentLayer;

-(id) initWithLayer:(Layer2 *)layer StartPoint:(CGPoint)BeginPoint

{
	self = [super init];
	if (self)
	{
		_lParentLayer = layer;
		[_lParentLayer addChild:self];
		_sMissile = [CCSprite spriteWithFile:@"Missile.png"];
		_sMissile.position = ccp(BeginPoint.x, -50);
		[self addChild:_sMissile];
		[self StartMoves:BeginPoint];
		[self schedule:@selector(BlockCollisionTimer:) interval:.01];
		[self schedule:@selector(AmmoCollisionTimer:) interval:.01];
	}
	return self;
}

-(void) StartMoves: (CGPoint)Start
{
	
	[_sMissile runAction:
	[CCRepeatForever actionWithAction:
	[CCSequence actions:
	[CCMoveTo actionWithDuration:1 position:ccp(Start.x, 330)],
	[CCCallFuncND actionWithTarget:self selector:@selector(removeMe) data:_sMissile],nil]]];
	
}


-(void) BlockCollisionTimer:(ccTime)deltab
{
    for(Block *myNode in _lParentLayer.aBlock)
    {
			CGRect rectSprite = myNode.Blk.boundingBox;
			CGRect rtSprite = _sMissile.boundingBox;
			if(CGRectIntersectsRect(rtSprite, rectSprite))
			{
				[self removeMe];
				[_lParentLayer removeChild:myNode cleanup:YES];
				[_lParentLayer Exlplode:_sMissile.position];
				
				CCLabelTTF *hitPoint =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%s", "+10"] fontName:@"Arial" fontSize:12];
			
				hitPoint.position= _sMissile.position;
				[_lParentLayer addChild:hitPoint];
				[hitPoint runAction:
				[CCRepeatForever actionWithAction:
				[CCSequence actions:
				[CCMoveTo actionWithDuration:.3 position:ccp(hitPoint.position.x +15, hitPoint.position.y + 20)],
				[CCFadeOut actionWithDuration:.2],
				[CCCallFuncND actionWithTarget:self selector:@selector(removeHitLabel:) data:hitPoint],nil]]];
				[_lParentLayer BlockHit:1];
				break;
			}
    }
}

-(void) AmmoCollisionTimer:(ccTime)deltab
{
	for(AmmoPack *myNode in _lParentLayer.aAmmoPacks)
    {
		CGRect rectSprite = myNode.ammo.boundingBox;
		CGRect rtSprite = _sMissile.boundingBox;
		if(CGRectIntersectsRect(rtSprite, rectSprite))
		{
			[self removeMe];
			[_lParentLayer removeChild:myNode cleanup:YES];
			[_lParentLayer Exlplode:_sMissile.position];
			[_lParentLayer AmmoPackHit];
			break;
		}
    }
}


-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

- (void)onEnter
{
	[super onEnter];
}

- (void)onExit
{
	[super onExit];
}

-(void) removeMe
{
    [self removeFromParentAndCleanup:YES];
}

-(void) removeHitLabel:(CCLabelTTF*)label
{
    [label removeFromParentAndCleanup:YES];
}

- (void)dealloc
{
    [super dealloc];
}



@end
