Flyfire (Original by Dalton Cherry https://github.com/acmacalister/jetfire)
===========================================================================

WebSocket [RFC 6455](http://tools.ietf.org/html/rfc6455) client library for iOS and OSX.

Flyfire  is a conforming WebSocket ([RFC 6455](http://tools.ietf.org/html/rfc6455)) client library in Objective-C for iOS and OSX.

Flyfire  also has a Swift counter part here: [Starscream](https://github.com/daltoniam/starscream)

## Features

- Conforms to all of the base [Autobahn test suite](http://autobahn.ws/testsuite/).
- Nonblocking. Everything happens in the background, thanks to GCD.
- Simple delegate pattern design.
- TLS/WSS support.
- Simple concise codebase at just a few hundred LOC.

## Features add by my fork

- Client-Side PKCS #12 Certificate 

## Example ##

First thing is to import the header file. See the Installation instructions on how to add Flyfire  to your project.

```objc
#import "JFRWebSocket.h"
```

Once imported, you can open a connection to your WebSocket server. Note that `socket` is probably best as a property, so your delegate can stick around.

```objc
NSString *appFolderPath = [[NSBundle mainBundle] resourcePath];
NSString *pkcs12Path = [NSString stringWithFormat:@"%@/%@", appFolderPath, @"myCoolCertificate.p12"];

self.socket = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:@"wss://localhost:8080"] protocols:@[@"chat",@"superchat"]];
[self.socket loadClientCertificate:pkcs12Path password:@"MY_COOL_PASSWORD"];
self.socket.delegate = self;
[self.socket connect];
```

After you are connected, there are some delegate methods that we need to implement.

### websocketDidConnect

```objc
-(void)websocketDidConnect:(JFRWebSocket*)socket {
    NSLog(@"websocket is connected");
}
```

### websocketDidDisconnect

```objc
-(void)websocketDidDisconnect:(JFRWebSocket*)socket error:(NSError*)error {
    NSLog(@"websocket is disconnected: %@",[error localizedDescription]);
}
```

### websocketDidReceiveMessage

```objc
-(void)websocket:(JFRWebSocket*)socket didReceiveMessage:(NSString*)string {
    NSLog(@"got some text: %@",string);
}
```

### websocketDidReceiveData

```objc
-(void)websocket:(JFRWebSocket*)socket didReceiveData:(NSData*)data {
    NSLog(@"got some binary data: %d",data.length);
}
```

Or you can use blocks.

```objc
self.socket = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080"] protocols:@[@"chat",@"superchat"]];
//websocketDidConnect
socket.onConnect = ^{
    println("websocket is connected")
};
//websocketDidDisconnect
socket.onDisconnect = ^(NSError *error) { 
    NSLog(@"websocket is disconnected: %@",[error localizedDescription]);
};
//websocketDidReceiveMessage
socket.onText = ^(NSString *text) { 
    NSLog(@"got some text: %@",string);
};
//websocketDidReceiveData
socket.onData = ^(NSData *data) {
     NSLog(@"got some binary data: %d",data.length);
};
//you could do onPong as well.
[socket connect];
```

The delegate methods give you a simple way to handle data from the server, but how do you send data?

### writeData

```objc
[self.socket writeData:[NSData data]]; // write some NSData over the socket!
```

### writeString

The writeString method is the same as writeData, but sends text/string.

```objc
[self.socket writeString:@"Hi Server!"]; //example on how to write text over the socket!
```

### disconnect

```objc
[self.socket disconnect];
```

### isConnected

Returns if the socket is connected or not.

```objc
if(self.socket.isConnected) {
  // do cool stuff.
}
```

### Custom Headers

You can also override the default websocket headers with your own custom ones like so:

```objc
[self.socket setHeader:@"Sec-WebSocket-Protocol" forKey:@"someother protocols"];
[self.socket setHeader:@"Sec-WebSocket-Version" forKey:@"14"];
[self.socket setHeader:@"My-Awesome-Header" forKey:@"Everything is Awesome!"];
```

### Protocols

If you need to specify a protocol, simple add it to the init:

```objc
//chat and superchat are the example protocols here
self.socket = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080"] protocols:@[@"chat",@"superchat"]];
self.socket.delegate = self;
[self.socket connect];
```

### Self Signed SSL and VOIP

There are a couple of other properties that modify the stream:

```objc
//set this if you are planning on using the socket in a VOIP background setting (using the background VOIP service).
self.socket.voipEnabled = YES;

//set this you want to ignore SSL cert validation, so a self signed SSL certificate can be used.
self.socket.selfSignedSSL = YES;
```

### SSL Pinning

SSL Pinning is also supported in Flyfire . 

```objc
self.socket = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080"] protocols:@[@"chat",@"superchat"]];
NSData *data = ... //load your certificate from disk
so
self.socket.security = [[JFRSecurity alloc] initWithCerts:@[[[JFRSSLCert alloc] initWithData:data]] publicKeys:YES];
//self.socket.security = [[JFRSecurity alloc] initUsingPublicKeys:YES]; //uses the .cer files in your app's bundle
```
You load either a `NSData` blob of your certificate or you can use a `SecKeyRef` if you have a public key you want to use. The `usePublicKeys` bool is whether to use the certificates for validation or the public keys. The public keys will be extracted from the certificates automatically if `usePublicKeys` is choosen.

### Custom Queue

A custom queue can be specified when delegate methods are called. By default `dispatch_get_main_queue` is used, thus making all delegate methods calls run on the main thread. It is important to note that all WebSocket processing is done on a background thread, only the delegate method calls are changed when modifying the queue. The actual processing is always on a background thread and will not pause your app.

```objc
//create a custom queue
self.socket.queue = dispatch_queue_create("com.vluxe.jetfire.myapp", nil);
```

## Example Project

Check out the SimpleTest project in the examples directory to see how to setup a simple connection to a WebSocket server.

## Install ##

The recommended approach for installing Flyfire  is via the CocoaPods package manager (like most libraries).

## Requirements ##

Flyfire  requires at least iOS 5/OSX 10.7 or above.

## Dependencies ##
- Security.framework
- CFNetwork.framework

## TODOs

- [ ] Complete Docs
- [ ] Add Unit Tests

## License ##

Flyfire  is license under the Apache License.

## Contact ##

### Austin Cherry ###
* https://github.com/acmacalister
* http://twitter.com/acmacalister
* http://austincherry.me

### Dalton Cherry ###
* https://github.com/daltoniam
* http://twitter.com/daltoniam
* http://daltoniam.com
