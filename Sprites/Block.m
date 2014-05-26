//
//  MyCocos2DClass.m
//  Sprites
//
//  Created by jeremy wall on 8/20/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//



#import "Block.h"


@implementation Block

@synthesize dBulletVelocity, Blk, myLayer;


-(id) initWithLayer:(Layer2 * )layer Velocity:(float)vel

{
	self = [super init];
	if (self) {
		self.dBulletVelocity = vel;
		self.myLayer = layer;
		[layer addChild:self];
		
		self.Blk = [CCSprite spriteWithFile:@"block3.png"];
		[self.Blk setColor:ccc3([self getRandomNumberBetween:0 to:255],
								[self getRandomNumberBetween:0 to:255],
								[self getRandomNumberBetween:0 to:255])];
		int ran = [self getRandomNumberBetween:0 to:540];
		Blk.position = ccp(ran, 310);
		
		[self addChild:Blk];
		[self StartMove:ran];
		[self schedule:@selector(ShieldCollisionTimer:) interval:.1];
	}
	return self;
}

-(void) ShieldCollisionTimer:(ccTime)delta
{
	
	for (CCSprite *Sprite in myLayer.Batch.descendants)
	{
		CGRect Block = Blk.boundingBox;
		CGRect rectSprite = Sprite.boundingBox;
		if(CGRectIntersectsRect(Block, rectSprite))
		{
			[myLayer Exlplode:Sprite.position];
			[[myLayer Batch] removeChild:Sprite cleanup:YES];
			[self removeMe];
			[myLayer SheildHit];
			if (myLayer.Batch.descendants.count == 0)
			{
				[myLayer GameOver:@"Game Over"];
			}
		}
	}
}


-(void)StartMove:(int)Random{

	[Blk runAction:[CCRotateBy actionWithDuration:dBulletVelocity angle:720]];
	[Blk runAction:
	[CCRepeatForever actionWithAction:
	[CCSequence actions:
	[CCMoveTo actionWithDuration:dBulletVelocity position:ccp(Random, -50)],
	//[CCMoveBy actionWithDuration:2 position:ccp(0, -100) ],
	[CCCallFuncND actionWithTarget:self selector:@selector(removeMe) data:Blk],nil]]];

}

-(int)getRandomNumberBetween:(int)from to:(int)to {
	
    return (int)from + arc4random() % (to-from+1);
}

- (void)onEnter
{
    [myLayer.aBlock addObject:self];
    //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

//onExit
- (void)onExit
{
	[myLayer.aBlock removeObject:self];
	//[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

-(void) removeMe
{
    [self removeFromParentAndCleanup:YES];
}

-(BOOL)containsTouch:(UITouch *)touch {
    CGRect r=[Blk textureRect];
    CGPoint p=[Blk convertTouchToNodeSpace:touch];
    return CGRectContainsPoint(r, p );
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (![self containsTouch:touch]) return NO;
	//[myLayer BlockHit:Blk.position];
	//[self removeMe];
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}


@end
