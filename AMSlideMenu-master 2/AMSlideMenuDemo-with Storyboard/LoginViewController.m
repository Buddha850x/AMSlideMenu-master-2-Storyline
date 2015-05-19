//
//  LoginViewController.m
//  AMSlideMenu
//
//  Created by Jacky Zou on 2/27/15.
//  Copyright (c) 2015 Artur Mkrtchyan. All rights reserved.
//

#import "LoginViewController.h"
#import "URLRequest.h"
@interface LoginViewController ()<NSXMLParserDelegate>
{
    NSXMLParser *soapParser;
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;
    NSMutableDictionary *item;
    NSTimer *timer;
    int remainingCounts;
    Reachability *internetReachableFoo;
    NSString *lastName;
    NSString *fullName;
   
}



@end

@implementation LoginViewController

BOOL shouldLogin = NO;
BOOL internetConnection = YES;

-(id)init
{
    if ([super init])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testInternetConnection];
}
-(void)username:(id)sender
{
    
}
-(void)password:(id)sender
{
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"success"])
    {
        // Get reference to the destination view controller
        
        
    }
    
    
    
}

- (void)testInternetConnection
{
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    NetworkStatus netStatus = [self.internetReachability currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable: {internetConnection = NO;
            
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Internet Connection!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        
            
        case ReachableViaWWAN: internetConnection = YES;

        
            break;
    
        case ReachableViaWiFi: internetConnection = YES;

                      break;
        
    }

    
}
-(IBAction)Login:(id)sender
{
    shouldLogin= NO;
    if (([self.username.text length] == 0) ||([self.password.text length] == 0) )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a username and a password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"%@",uniqueIdentifier);

    
    //Construct the soapMessasge
    if(internetConnection)
    {
    NSString *soapMsg =[NSString stringWithFormat:
                        
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        
                        "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        
                        "<Body>"
                        
                        "<Check xmlns=\"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp\">"
                        
                        "<UserName>%@</UserName>"
                  
                        "<Password>%@</Password>"
                        
                        "<DeviceID>%@</DeviceID>"
                        
                        "<OperationType>%@</OperationType>"
                        
                        "</Check>"
                        
                        "</Body>"
                        
                        "</Envelope>",self.username.text,self.password.text,uniqueIdentifier,@"Schedule"];
    
    NSLog(@"soap: %@",soapMsg);
    //Create the NSURL
    NSURL *url = [NSURL URLWithString:@"http://fmp.rutgersprep.org/websvcmgr.php?wsdl@service=RPSScheduling"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long) [soapMsg length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //Set the SOAP Action
    [theRequest addValue: @"http://fmp.rutgersprep.org/RutgersPrepStudentsforapp/Check" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //make sure it's a POST
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    URLRequest *urlRequest = [[URLRequest alloc] initWithRequest:theRequest];
    
    
    
    [urlRequest startWithCompletion:^(URLRequest *request, NSData *data, BOOL success) {
        if (success)
        {
            
            errorParsing=YES;
            //create the NSXMLParser and initialize it with the data received
            soapParser = [[NSXMLParser alloc] initWithData:data];
            
            NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", strData);
            //set the delegate
            
            [soapParser setDelegate:self];
            // You may need to turn some of these on depending on the type of XML file you are parsing
            [soapParser setShouldProcessNamespaces:YES];
            [soapParser setShouldReportNamespacePrefixes:NO];
            [soapParser setShouldResolveExternalEntities:NO];
            [soapParser parse];


        }
        else
        {
            NSLog(@"error  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
        }
    
     
    }];
    }
    
   /* else{
        //login without internet
  
        
        NSString *filePathForUsername = [NSHomeDirectory()stringByAppendingPathComponent:@"username.txt"];
        NSString *filePathForPassword = [NSHomeDirectory()stringByAppendingPathComponent:@"password.txt"];
        NSString *filePathForStudentID = [NSHomeDirectory()stringByAppendingPathComponent:@"studentID.txt"];
        
        //sets string to text in file
        NSString *fileContentsUsername = [NSString stringWithContentsOfFile:filePathForUsername encoding:NSUTF8StringEncoding error:nil];
        NSString *fileContentsPassword = [NSString stringWithContentsOfFile:filePathForPassword encoding:NSUTF8StringEncoding error:nil];
        NSString *fileContentsStudentID = [NSString stringWithContentsOfFile:filePathForStudentID encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"Username is: %@",fileContentsUsername);
        NSLog(@"Password is: %@",fileContentsPassword);
        NSLog(@"StudentID is: %@",fileContentsStudentID);

        
        if([self.username.text isEqualToString:fileContentsUsername] && [self.password.text isEqualToString:fileContentsPassword] )
        {
            
            shouldLogin=true;
            [self performSegueWithIdentifier:@"success" sender:self];
        }
        
    }
  */
    
}

- (IBAction)signUp:(id)sender {
    shouldLogin=true;
     [self performSegueWithIdentifier:@"GoSignUp" sender:self];
}

- (IBAction)Pop:(id)sender {
    
    [self performSegueWithIdentifier:@"dropModal" sender:self];
    
}

#pragma marks delegates
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"***data found and parsing started***");
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"***Parsing Finished***");
}
/*
 This method is called if an error occurs
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %li", (long)[parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    errorParsing=YES;
}

/*
 When the parser find characters, they are added to your variable "ElementValue".
 
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
 [ElementValue appendString:string];
 NSLog(@"%@", ElementValue);
 
 }
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement = [elementName copy];
    ElementValue = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"CheckResponse"]) {
        item = [[NSMutableDictionary alloc] init];
        
    }
    NSLog(@"%@",currentElement);
}
/*
 When the parser find characters, they are added to your variable "ElementValue".
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [ElementValue appendString:string];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender{
    if(shouldLogin)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"CheckResponse"]) {
        
        NSString *deviceID = ElementValue;
        [deviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [deviceID stringByReplacingOccurrencesOfString:@" "withString:@""];
        long deviceIDlength = (unsigned long)[deviceID length];
        NSLog(@"This the length of Device ID: %lu", (unsigned long)[deviceID length]);
        
        NSLog(@"%@",[NSString stringWithFormat:@"Result: %@", ElementValue]);
        
         NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        
        NSLog(@"%@", uniqueIdentifier);
       
        if (deviceIDlength > 5)
        {
            //success
             shouldLogin=true;
            [self performSegueWithIdentifier:@"success" sender:self];
            
            
            if(![deviceID isEqualToString:uniqueIdentifier])
            {
                //device ID incorrect
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"You are using a different Device to login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];

                
            }
          
        }
        else{
            shouldLogin = false;
            //username password incorrect
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failure" message:@"Your Username/Password is incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
          

            
        }
        
    /*
        if((unsigned long)[deviceID length] == 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failure" message:@"Your Username/Password is incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            shouldLogin = false;
            [alert show];

        }
         if ((![ElementValue isEqualToString: uniqueIdentifier])&& !((unsigned long)[deviceID length] == 3))
        {
            shouldLogin=true;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"You are using a different Device to login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
            
            
            [self performSegueWithIdentifier:@"success" sender:self];
 
            return;

        }
        if( !((unsigned long)[deviceID length] == 3))
        {
            shouldLogin=true;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"You are login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
            
            
            [self performSegueWithIdentifier:@"success" sender:self];
            
            
            
            return;

        }
     */
            
            
            
    }
    
    
    else
    {
        [item setObject:ElementValue forKey:elementName];
        
    }
    
}

/*-(void)readFile {
    //This is the filePath
    NSString *filePathForUsername = [NSHomeDirectory()stringByAppendingPathComponent:@"username.txt"];
    NSString *filePathForPassword = [NSHomeDirectory()stringByAppendingPathComponent:@"password.txt"];
    NSString *filePathForStudentID = [NSHomeDirectory()stringByAppendingPathComponent:@"studentID.txt"];
    NSString *filePathForStudentFullName = [NSHomeDirectory()stringByAppendingPathComponent:@"fullName.txt"];
    
    
    //sets string to text in file
    NSString *fileContentsUsername = [NSString stringWithContentsOfFile:filePathForUsername encoding:NSUTF8StringEncoding error:nil];
    NSString *fileContentsPassword = [NSString stringWithContentsOfFile:filePathForPassword encoding:NSUTF8StringEncoding error:nil];
    NSString *fileContentsStudentID = [NSString stringWithContentsOfFile:filePathForStudentID encoding:NSUTF8StringEncoding error:nil];
    NSString *fileContentsFullName = [NSString stringWithContentsOfFile:filePathForStudentFullName encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"Username is: %@",fileContentsUsername);
    NSLog(@"Password is: %@",fileContentsPassword);
    NSLog(@"StudentID is: %@",fileContentsStudentID);
    NSLog(@"The student's full name is: %@", fileContentsFullName);
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end