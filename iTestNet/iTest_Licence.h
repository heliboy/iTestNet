//--------------------------------------------------------->
//  iTestnet_Licence.h
//  iTestnet
//
//  Created by David Owens on 08/08/2012.
//  Copyright 2013 Radio Planning Tools. All rights reserved.
//--------------------------------------------------------->

//<------------------------------------------------------------------------->
// API keys for your iPhone App, Application Name, iTestnet Dashboard
//<------------------------------------------------------------------------->
#pragma mark ---> licence structure start <---
#define ITEST_CUSTOMER_ID          @"11FF7B45"                                          //CustomerID
#define ITEST_PASSWORD             @"D2FF4A11"                                          //password
#define ITEST_DASHBOARD            @"405378CD"                                          //Dashboard report
#define ITEST_COVERAGE             @"F4436788"                                          //Coverage overlay
#define ITEST_APPLICATION_ID       @"bd645b59-0cd4-46f1-806b-6399fbd75766"              //ApplicationID
#define ITEST_SECRET_ID            @"rNkC4dtxBGV3Bd//iSCEW1EJgG2WTW8tmHFBfUGiP3Y="      //Secret
#define ITEST_BASE_URL             @"http://www.itestnet.co.uk/scripts"                 //build the base url
#define ITEST_MAP_URL              @"http://www.itestnet.co.uk/scripts"                 //Base Map Path
#define ITEST_DASHBOARD_URL        @"/mt3000_data_json.php"                             //Dashboard
#define ITEST_AGENTS_URL           @"/postAgentID.php"                                  //Agents
#define ITEST_RESULTS_URL          @"/postResults.php"                                  //Results
#define ITEST_HTTP_GET_METHOD      @"GET"                                               //
#define ITEST_HTTP_PUT_METHOD      @"PUT"                                               //
#pragma mark ---> licence structure finish <---

//http://www.radioplanningtools.com/mobile/planB/mt3000_data_json.php?startdate=2013%2F02%2F03%2000%3A00&finishdate=2013%2F07%2F31%2023%3A59

//http://www.radioplanningtools.com/mobile/planB/scripts/postXYZ.php?userid=0001&obdvin=1M8GDM9A_KP0427&lastx=0.0&lasty=2.0&lastz=1.0&speed=25&swvr=1.23&rssi=-85&lat=54.4009&lon=-1.344
//JSON update database function for iPhone G-Force App
//http://www.radioplanningtools.com/mobile/planB/update_asdb.php?userid=0041&timestamp=2013%2F02%2F03%2000%3A00&obdvin=1M8GDM9A_KP0427&lastx=0.0&lasty=2.0&lastz=1.0&speed=25&swvr=1.23&rssi=-85&lat=54.4009&lon=-1.344
/*
 {
 "startdate": "2013-02-03 00:00",
 "finishdate": "2013-08-31 23:59",
 "customer": "PlanB",
 "success": 1,
 "records": [
 {
 "msgid": "1",
 "userid": "1",
 "timestamp": "2013-07-30 23:14:00",
 "obdvin": "1M8GDM9A_KP0427",
 "lastx": "0.0",
 "lasty": "2.0",
 "lastz": "%@0",
 "speed": "15",
 "swvr": "1.23",
 "rssi": "-85",
 "latitude": "51.4009",
 "longitude": "1.3235"
 }
*/
