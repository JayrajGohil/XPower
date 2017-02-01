//
//  Constants.swift
//  XPower
//
//  Created by Software Merchant on 1/24/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

struct AppDefault {
    static let AppName = "XPower"
    static let SelectSchool = "Select School"
    static let KeepLogIn = "keepLogIn"
    static let Username = "Username"
    static let SchoolName = "SchoolName"
}

struct Menu {
    static let Home = "Home"
    static let Points = "Points"
    static let Score = "Score"
    static let Friends = "Friends"
    static let Settings = "Settings"
    static let Logout = "Logout"
}

struct API {
    static let UrlHost = "http://www.consoaring.com"
    static let UrlLogin = "/UserService.svc/userauthentication"
    static let UrlForgotPassword = "/UserService.svc/resetpassword"
    static let UrlSignup = "/UserService.svc/CreateUserAccount"
    
    static let UrlDailyPoint = "/PointService.svc/dailypoints"
    static let UrlTotalSchoolPoint = "/PointService.svc/totalschoolpoints"
    static let UrlPointList = "/PointService.svc/pointslistarray"
    static let UrlPointTable = "/PointService.svc/pointstable"
    static let UrlPointFavorite = "/PointService.svc/getfavorites"
    static let UrlPointRecentDeed = "/PointService.svc/getrecentdeeds"
    static let UrlPointAddDeed = "/PointService.svc/adddeeds"
    
    static let UrlFriendRequestList = "/UserService.svc/getfriendrequests"
    static let UrlFriendAdd = "/UserService.svc/addfriendrequest"
    static let UrlFriendStatus = "/UserService.svc/respondfriendrequest"
}

struct SecureKey {
    static let Key = "secret0key000000"
    static let Iv = "0000000000000000"
}

struct School {
    static let HaverfordName = "Haverford"
    static let AgnesIrwinName = "Agnes Irwin"
    
    static let Param_AgnesIrwinSchool = "Agnes Irwin School"
    
    static let HaverfordEmail = "@haverford.org"
    static let AgnesIrwinEmail = "@agnesirwin.org"
}

struct SignUp {
    static let Success = "Created User Account for user"
}
