//
//  MyCocos2DClass.m
//  Sprites
//
//  Created by jeremy wall on 5/10/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import "Layer2.h"
#import "GameOver.h"
#import "Block.h"
#import "AmmoPack.h"
#import "Missile.h"

#define numOfBullets  100

@implementation Layer2

@synthesize Batch = _Batch, aBlock = _aBlock, aAmmoPacks = _aAmmoPacks, iScore = _iScore;
@synthesize iBulletCount = _iBulletCount, aBulletUpgrade = _aBulletUpgrade;


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Layer2 *layer = [Layer2 node];
	[scene addChild: layer];
	return scene;
}

-(id) init

{

	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	
    if ((self = [super initWithColor:ccc4(0,0,255,155)]))
	{
		[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	 		
		
		winSize = [CCDirector sharedDirector].winSize;
		
		[self PreLoadSounds];
		[self StartTimers];
	
		///Bullets left label
		lblAmmo =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%s%d", "Ammo X",numOfBullets] fontName:@"Arial" fontSize:20];
		lblAmmo.position=ccp(500, 10); lblAmmo.color=ccc3(245, 222, 179);
		nShotsLeft = numOfBullets;
		[self addChild:lblAmmo];
		
		lblScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", _iScore] fontName:@"Arial" fontSize:20];
		lblScore.position=ccp(winSize.width - 30, 300);
		[self addChild:lblScore] ;
	
		///Menu label
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithString:@"| |" target:self selector:@selector(onPlay:)];
		menu = [CCMenu menuWithItems: menuItem1, nil];
		menu.position = ccp(20, 300);
		[self addChild:menu];
		
		snow = [CCParticleSnow node];
		snow.startSize = 3;
		snow.angleVar = 1;
		snow.speed = 125;
		snow.texture = [[CCTextureCache sharedTextureCache] addImage:@"Stars.png"];
		[self addChild:snow];
		
		[self CreateSheilds];
		
		_aBlock = [[NSMutableArray alloc]init];
		_aAmmoPacks = [[NSMutableArray alloc]init];
		_aBulletUpgrade = [[NSMutableArray alloc]init];
		_iBulletCount = 3;
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"ExplodingRing" ofType:@"plist"];
		dExplosion = [NSDictionary dictionaryWithContentsOfFile:path];
		explosion = [[[CCParticleSystemQuad alloc] initWithDictionary:dExplosion] retain];
		[self addChild:explosion];
		
	
    }
    return self;
    
}

- (void) onPlay:(id)sender

{
	[[CCDirector sharedDirector]
	 replaceScene:[CCTransitionFlipX transitionWithDuration:.5
													  scene:[IntroLayer scene]]];
}

-(void) BulletUpgradeTimer:(ccTime)delta
{
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"Shot.mp3"];
	CCSprite *Upgrade = [CCSprite spriteWithFile:@"BulletUpgrade.png"];
	
	[self addChild:Upgrade];
	[Upgrade runAction:
	[CCRepeatForever actionWithAction:
	[CCSequence actions:
	[CCMoveTo actionWithDuration:1 position:ccp([self getRandomNumberBetween:0 to:500], 330)],
	[CCCallFuncND actionWithTarget:self selector:@selector(removeMe:) data:Upgrade],nil]]];
	[self unschedule:@selector(BulletUpgradeTimer:)];
	
}

-(void) BulletTimer:(ccTime)delta
{

	[[SimpleAudioEngine sharedEngine] playEffect:@"Shot.mp3"];
	[[Block alloc]initWithLayer:self Velocity:[self getRandomNumberBetween:2.5 to:3]];
	[self unschedule:@selector(BulletTimer:)];
	[self schedule:@selector(BulletTimer:) interval: [self getRandomNumberBetween:.7 to:2]];
	
}

-(void) AmmoPackTimer:(ccTime)delta
{
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"Shot.mp3"];
	[[AmmoPack alloc]initWithLayer:self Velocity:[self getRandomNumberBetween:2 to:3]];
	[self unschedule:@selector(AmmoPackTimer:)];
	[self schedule:@selector(AmmoPackTimer:) interval: [self getRandomNumberBetween:1 to:10]];
	
}


- (void) CreateSheilds
{

	spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"Blocks.png"];
	for(int i = 0; i < 8; ++i)
	{
		CCSprite *sprite = [CCSprite spriteWithFile:@"Blocks.png"];
		float offsetFraction = ((float)(i+1))/(9);
		CGPoint spriteOffset = ccp(winSize.width*offsetFraction, winSize.height/8);
		sprite.position = spriteOffset;
		[spriteBatch addChild:sprite z:1 tag:i];
	}
	[super addChild:spriteBatch];
	_Batch = spriteBatch;
	
}

-(void) BlockHit:(int)Tag
{
	_iScore += 10;
	[lblScore setString:[NSString stringWithFormat:@"%i", _iScore]];
}


-(void) AmmoPackHit
{
	nShotsLeft += 10;
	[lblAmmo setString:[NSString stringWithFormat:@"%i", nShotsLeft]];
}

-(void) SheildHit
{
	//_iBulletCount = 1;
}


- (BOOL) ccTouchBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
	if(nShotsLeft != 0)
	{
		nShotsLeft -- ;
		CGPoint touchLocation = [self convertTouchToNodeSpace:touches];
		[[SimpleAudioEngine sharedEngine] playEffect:@"TouchSound.mp3"];
		for(int i = 0; i < _iBulletCount; ++i)
		{
			int offset = i * 10;
			[[Missile alloc]initWithLayer:self StartPoint:ccp(touchLocation.x + offset, touchLocation.y)];
		}
	}
	else
	{
		
	[self GameOver:@"Out of Ammo"];
	
	}
	return  TRUE;
}

-(void) Exlplode:(CGPoint)Location
{
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"Collision.mp3"];
	[explosion resetSystem];
	explosion.position = Location;
	//lblScore.string = [NSString stringWithFormat:@"%i", _iScore];
	
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

}


-(int) getRandomNumberBetween:(int)from to:(int)to {
	
    return (int)from + arc4random() % (to-from+1);
}


-(void) PreLoadSounds
{
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"TouchSound.mp3"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"Shot.mp3"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"Collision.mp3"];

}

-(void) removeMe:(CCSprite*)remove
{
    [remove removeFromParentAndCleanup:YES];
}

-(void) StartTimers
{
	[self schedule:@selector(BulletTimer:) interval:2];
	[self schedule:@selector(AmmoPackTimer:) interval:2];
	[self schedule:@selector(BulletUpgradeTimer:) interval:5];
}

-(void) GameOver:(NSString*)message
{
	lblLose =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", message] fontName:@"Arial" fontSize:30];
	lblLose.position=ccp(540/2, 320/2);
	lblLose.color=ccc3(245, 222, 179);
	lblAmmo.string = @"";
	[self addChild:lblLose];
	[self unschedule:@selector(AmmoPackTimer:)];
	[self unschedule:@selector(BulletTimer:)];
	
}


@end
