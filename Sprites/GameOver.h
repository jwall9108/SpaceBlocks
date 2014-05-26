//
//  HelloWorldLayer.h
//  Sprites
//
//  Created by jeremy wall on 4/17/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface GameOver : CCLayerColor
{
    CCSprite* s3;
    CCSprite* player;
	    CCSprite * selSprite;
	    CCSprite * boss;
    CCParticleSystem *emitter;
	CCParticleSystem *snow;
	CCParticleSystem *Boom;

	CCMenuItem *Back;
	
    NSMutableArray * movableSprites;
    NSMutableArray * movableSprites2;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(BOOL) ccTouchBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)onBack:(id)sender;



@end
