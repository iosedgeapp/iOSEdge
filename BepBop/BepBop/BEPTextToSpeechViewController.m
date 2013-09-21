//
//  BEPTextToSpeechViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPTextToSpeechViewController.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, BEPReadingState)
{
    BEPReadingStateStarted,
    BEPReadingStateStopped,
    BEPReadingStatePaused,
    BEPReadingStateResumed
};

@interface BEPTextToSpeechViewController () <AVSpeechSynthesizerDelegate>

@property IBOutlet UILabel*            bodyLabel;
@property IBOutlet UIBarButtonItem*    startStopButton;
@property IBOutlet UISegmentedControl* rateControl;
@property IBOutlet UISlider*           pitchSlider;
@property IBOutlet UISlider*           volumeSlider;
@property IBOutlet UIBarButtonItem*    pauseResumeButton;

@property AVSpeechSynthesizer* synthesizer;

@end

@implementation BEPTextToSpeechViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title       = NSLocalizedString(@"Text to Speech", nil);
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
        self.synthesizer.delegate = self;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

#pragma mark - Actions

- (IBAction) startSpeaking:(id)sender
{
    AVSpeechUtterance* utterance = [AVSpeechUtterance speechUtteranceWithString:self.bodyLabel.text];

    utterance.voice  = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.volume = self.volumeSlider.value;
    utterance.pitchMultiplier = self.pitchSlider.value;

    CGFloat rate = AVSpeechUtteranceDefaultSpeechRate;
    switch (self.rateControl.selectedSegmentIndex)
    {
        case 0:
            rate = AVSpeechUtteranceMinimumSpeechRate;
            break;
        case 1:
            rate = AVSpeechUtteranceDefaultSpeechRate;
            break;
        case 2:
            rate = AVSpeechUtteranceMaximumSpeechRate;
            break;
        default:
            break;
    }
    utterance.rate = rate;

    [self.synthesizer speakUtterance:utterance];
}

- (void) stopSpeaking:(id)sender
{
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (IBAction) pauseSpeaking:(id)sender
{
    [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void) resumeSpeaking:(id)sender
{
    [self.synthesizer continueSpeaking];
}

#pragma mark - AVSpeechSynthesizerDelegate

- (void) speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance
{
    [self setViewForState:BEPReadingStateStarted];
}

- (void) speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance
{
    [self setViewForState:BEPReadingStatePaused];
}

- (void) speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance
{
    [self setViewForState:BEPReadingStateResumed];
}

- (void) speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance
{
    [self setViewForState:BEPReadingStateStopped];
}

- (void) speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance
{
    [self setViewForState:BEPReadingStateStopped];
}

#pragma mark - Internal

- (void) setViewForState:(BEPReadingState)state
{
    switch (state)
    {
        case BEPReadingStateStarted:
            [self setStartStopButtonToStart:NO];
            [self setPauseResumeButtonToPause:YES];
            self.rateControl.enabled       = NO;
            self.pitchSlider.enabled       = NO;
            self.volumeSlider.enabled      = NO;
            self.pauseResumeButton.enabled = YES;
            break;
        case BEPReadingStateStopped:
            [self setStartStopButtonToStart:YES];
            [self setPauseResumeButtonToPause:YES];
            self.rateControl.enabled       = YES;
            self.pitchSlider.enabled       = YES;
            self.volumeSlider.enabled      = YES;
            self.pauseResumeButton.enabled = NO;
            break;
        case BEPReadingStatePaused:
            [self setPauseResumeButtonToPause:NO];
            break;
        case BEPReadingStateResumed:
            [self setPauseResumeButtonToPause:YES];
            break;
        default:
            break;
    }
}

- (void) setPauseResumeButtonToPause:(BOOL)paused
{
    if (paused)
    {
        self.pauseResumeButton.title = NSLocalizedString(@"Pause", nil);
        [self.pauseResumeButton setAction:@selector(pauseSpeaking:)];
    }
    else
    {
        self.pauseResumeButton.title = NSLocalizedString(@"Resume", nil);
        [self.pauseResumeButton setAction:@selector(resumeSpeaking:)];
    }
}

- (void) setStartStopButtonToStart:(BOOL)start
{
    if (start)
    {
        self.startStopButton.title = NSLocalizedString(@"Start", nil);
        [self.startStopButton setAction:@selector(startSpeaking:)];
    }
    else
    {
        self.startStopButton.title = NSLocalizedString(@"Stop", nil);
        [self.startStopButton setAction:@selector(stopSpeaking:)];
    }
}

@end
