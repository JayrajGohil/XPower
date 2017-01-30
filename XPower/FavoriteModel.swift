//
//	RootClass.swift
//
//	Create by Software Merchant on 30/1/2017
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class FavoriteModel : NSObject, NSCoding{

    
	var favorite : String!


    public func encode(with aCoder: NSCoder) {
        if favorite != nil{
            aCoder.encode(favorite, forKey: "favorite")
        }
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		favorite = dictionary["favorite"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if favorite != nil{
			dictionary["favorite"] = favorite
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         favorite = aDecoder.decodeObject(forKey: "favorite") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if favorite != nil{
			aCoder.encode(favorite, forKey: "favorite")
		}

	}

}
