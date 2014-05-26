//
//  HelloWorldLayer.m
//  Sprites
//
//  Created by jeremy wall on 4/17/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


// Import the interfaces
#import "GameOver.h"
#import "Layer2.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

// HelloWorldLayer implementation
@implementation GameOver

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value

    if ((self = [super initWithColor:ccc4(0,0,255,255)])) {
        
      [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
		
		
        s3 = [CCSprite spriteWithFile:@"projectile.png"];
        s3.position = ccp(s3.contentSize.width/2, 100);
        [self addChild:s3];
        
        player = [CCSprite spriteWithFile:@"player-hd.png"];
		player.color = ccMAGENTA;
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
        movableSprites = [[NSMutableArray alloc] init];
        [movableSprites addObject:player];
		[self addChild:player z:2];
         
       boss = [CCSprite spriteWithFile:@"player-hd.png"];
        boss.position = ccp(100,100);
        movableSprites2 = [[NSMutableArray alloc] init];
        [movableSprites2 addObject:boss];
		boss.flipX = 180;
        [self addChild:boss];
        
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithString:@"onBack" target:self selector:@selector(onPlay:)];
        Back = [CCMenu menuWithItems: menuItem1, nil];
		Back.position = ccp(400, 50);
        [self addChild:Back];
        
		if (snow.visible == NO){
            snow = [CCParticleSnow node];
            snow.startSize = 3;
            snow.speed = 100;
            snow.texture = [[CCTextureCache sharedTextureCache] addImage:@"64px-Badge_Placeholder.png"];
            [self addChild:snow];
		}
		
        if (emitter.visible == NO){
            emitter = [CCParticleFireworks node];
            emitter.rotation = -90;
            emitter.startSize = 3;
            emitter.speed = 100;
            emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"64px-Badge_Placeholder.png"];
			emitter.position = ccp(player.position.x, player.position.y - 90);
            [player addChild:emitter];
		}
    }
    return self;
    
}

- (BOOL)ccTouchBegan:(UITouch *)touches withEvent:(UIEvent *)event{
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"barreta_m9-Dion_Stapper-1010051237.mp3"];
		
	CGPoint touchLocation = [self convertTouchToNodeSpace:touches];
    [self selectSpriteForTouch:touchLocation];

	if (CGRectContainsPoint(boss.boundingBox, touchLocation)) {
		
		id cleanupAction2 = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupSprite:) data:boss];
		[boss runAction:cleanupAction2];
	}
        CCSprite *shipLaser = [CCSprite spriteWithFile:@"projectile.png"];
        shipLaser.visible = YES;
		shipLaser.position = ccp(player.position.x, player.position.y/2);
        [player addChild:shipLaser z:1];
        //[shipLaser runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.5f position:ccp(boss.position.x, boss.position.y - 90)], nil]];
		id action1 = [CCMoveTo actionWithDuration:.5f position:ccp(boss.position.x, boss.position.y - 90)] ; // the action it sounds like you have written above.
		id cleanupAction = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupSprite:) data:shipLaser];
		id seq = [CCSequence actions:action1, cleanupAction, nil];
		[shipLaser runAction:seq];
	
	
    return  TRUE;
}


- (void) cleanupSprite:(CCSprite*)inSprite
{
    // call your destroy particles
    [self removeChild:inSprite cleanup:YES];
	}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    
    for (CCSprite *sprite in movableSprites2) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    
    
    if (newSprite != selSprite) {
        [selSprite stopAllActions];
        selSprite = newSprite;
    }
}


- (void)panForTranslation:(CGPoint)translation {
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
        
    }
}

- (BOOL)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
	
	Boom = [CCParticleExplosion node];
	Boom.startSize = 1;
	Boom.life = 1.0f;
	Boom.lifeVar = 1;
	Boom.gravity = ccp(0,0);
	Boom.duration = 0.1f;
	Boom.tangentialAccel = 0;
	Boom.tangentialAccelVar = 0;
	Boom.speed = 100;
	Boom.texture = [[CCTextureCache sharedTextureCache] addImage:@"64px-Badge_Placeholder.png"];
	Boom.position = touchLocation;
	[self addChild:Boom];
	
	
	
	return TRUE;

}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
    
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        [self selectSpriteForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    }
    
    
}


- (void)onBack:(id)sender
{
	NSLog(@"on play");
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Layer2 scene] ]];
	
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
   }
#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
