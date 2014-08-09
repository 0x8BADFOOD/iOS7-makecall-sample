//
//  MDViewController.m
//  JBCall
//
//  Created by AMD on 8/2/14.
//  Copyright (c) 2014 MobileDev. All rights reserved.
//

#import "MDViewController.h"

#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#include <dlfcn.h>

@interface MDViewController ()

    @end

    @implementation MDViewController
    UITapGestureRecognizer *tapRecognizer;

    - (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];

    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];

    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
}
-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}
-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.tfNumberToCall resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onPlaceCall:(id)sender {

    NSString *numberToCall = [self.tfNumberToCall text];

    NSLog(@"Open CoreTelephony");
    void *ptrCoreTelephone = dlopen("/System/Library/Framework/CoreTelephony.framework/CoreTelephony", RTLD_LAZY);

    if (ptrCoreTelephone == nil){
        NSLog(@"ptrCoreTelephone is nil");
        return;
    }

    NSLog(@"Get CTCallDial from CoreTelephony");
    int (*pCTCallDial)(NSString*) = dlsym(ptrCoreTelephone, "CTCallDial");

    if (pCTCallDial != nil) {
        int error = pCTCallDial(numberToCall);
        NSLog(@"pCTCallDial error: %d", error);
    }
    NSLog(@"Close CoreTelephony");
    dlclose(ptrCoreTelephone);
}

- (IBAction)onStopCall:(id)sender {
    NSLog(@"onStopCall");
    void *ptrCoreTelephone = dlopen("/System/Library/Framework/CoreTelephony.framework/CoreTelephony", RTLD_LAZY);

    if (ptrCoreTelephone == nil){
        NSLog(@"ptrCoreTelephone is nil");
        return;
    }

    NSLog(@"Get CTCallListDisconnectAll from CoreTelephony");
    int (*pCTCallListDisconnectAll)() = dlsym(ptrCoreTelephone,
            "CTCallListDisconnectAll");
    if (pCTCallListDisconnectAll != nil) {
        int error = pCTCallListDisconnectAll();
        NSLog(@"pCTCallListDisconnectAll error: %d", error);
    }
    dlclose(ptrCoreTelephone);
}

- (IBAction)onShowMyNumber:(id)sender {
    NSString *myPhoneNumber = [self getMyNumber];
    UIAlertView *showAlert = [[UIAlertView alloc]
        initWithTitle:@"Your Phone Nmber:"
              message:myPhoneNumber
             delegate:nil
    cancelButtonTitle:@"OK"
    otherButtonTitles:nil];
    [showAlert show];
}

-(NSString*) getMyNumber {
    NSLog(@"Open CoreTelephony");
    void *lib = dlopen("/Symbols/System/Library/Framework/CoreTelephony.framework/CoreTelephony",RTLD_LAZY);
    NSLog(@"Get CTSettingCopyMyPhoneNumber from CoreTelephony");
    NSString* (*pCTSettingCopyMyPhoneNumber)() = dlsym(lib, "CTSettingCopyMyPhoneNumber");
    NSLog(@"Get CTSettingCopyMyPhoneNumber from CoreTelephony");

    if (pCTSettingCopyMyPhoneNumber == nil) {
        NSLog(@"pCTSettingCopyMyPhoneNumber is nil");
        return nil;
    }
    NSString* ownPhoneNumber = pCTSettingCopyMyPhoneNumber();
    dlclose(lib);
    return ownPhoneNumber;
}

@end
