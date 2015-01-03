JBCall - sample app for calls on JB iOS7
=======

###  [For Jailbroken devices only!]

This is test iOS application which allows you to make calls.

# How to use?

* Sync repository
* Build without code signature
* Find path where Xcode placed binaries:
```
$ls -la ~/Library/Developer/Xcode/DerivedData/ | grep JBCall
```
* Correct following vars in install script [**install_app.sh**]:
    * PASSWD='**mypass**'
    * IP='**10.231.65.56**'
    * PROFILE_NAME='iPhone Developer: FirstName  SecondName (XXXXXXXXXX)'
    * APP_ON_MAC="/Users/**username**/Library/Developer/Xcode/DerivedData/**JBCall-cktasembftvbmqaaiiunvljdwocs**/Build/Products/Debug-iphoneos/JBCall.app"
```
#To find name of folder with binaries:
$ls -la ~/Library/Developer/Xcode/DerivedData/ | grep JBCall
```
  To find profile name check your keychain records
* Make scripts runable:
```
$chmod +x ./install_app.sh
$chmod +x ./remove_app.sh
```
* Install app:
```
$./install_app.sh
```

#### To use scripts you need **sshpass** tool installed.
To install it use command:
```
$sudo apt-get install sshpass
```


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/0x8BADFOOD/ios7-makecall-sample/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

