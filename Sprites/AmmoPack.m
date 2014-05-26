//
//  MyCocos2DClass.m
//  Sprites
//
//  Created by jeremy wall on 8/20/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import "AmmoPack.h"

///Bullet packs
#define kBulletPack1  5
#define kBulletPack2  10
#define kBulletPack3  100

@implementation AmmoPack
@synthesize dAmmoVelocity, ammo, ParentLayer;


-(id) initWithLayer:(Layer2 *)layer Velocity:(float)Velocity

{
	self = [super init];
	if (self)
	{
		self.ParentLayer = layer;
		[layer addChild:self];
		self.dAmmoVelocity = Velocity;
		self.ammo = [CCSprite spriteWithFile:@"Ammo_Pack.png"];
		int random = [self getRandomNumberBetween:0 to:540];
		ammo.position = ccp(random, 310);
		[self addChild:ammo];
		[self StartMove:random];
		
	}
	return self;
}

-(void) StartMove:(int)Random
{

	ccBezierConfig bezier;
	bezier.controlPoint_1 = ccp(30, 100);
	bezier.controlPoint_2 = ccp(100, -50/2);
	bezier.endPosition = ccp(100,0);
	
	id bezierForward = [CCBezierBy actionWithDuration:3 bezier:bezier];
	
	[ammo runAction:
	[CCRepeatForever actionWithAction:
	[CCSequence actions:
	 
	[CCMoveTo actionWithDuration:dAmmoVelocity - 1 position:ccp(Random,0)],
	 bezierForward,
	[CCCallFuncND actionWithTarget:self selector:@selector(removeMe) data:ammo], nil]]];
   
}


-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

- (void)onEnter
{
	[ParentLayer.aAmmoPacks addObject:self];
    [super onEnter];
}

//onExit
- (void)onExit
{
	[ParentLayer.aAmmoPacks removeObject:self];
	[ParentLayer AmmoPackHit];
    [super onExit];
}

-(void) removeMe
{
    [self removeFromParentAndCleanup:YES];
}

-(BOOL)containsTouch:(UITouch *)touch
{
	return true;
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (![self containsTouch:touch])return NO;
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
