//
//  Date format.swift
//  NYC CribCheck
//
//  Created by C4Q on 3/4/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation

struct DateFormatHelper {
    private init(){}
    static let formatter = DateFormatHelper()
    public func formateDate(from date: String,
                            inputDateFormat inputFormat: String,
                            outputDateFormat outputFormat: String) -> String {
        //for this app
        let date = date.replacingOccurrences(of: ".000", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date1!)
    }
}
/*
 ______________Date Format_______________inputFormat / outputFormat__
 ||-----------------------------------------------------------------||
 || Thursday, Oct 12, 2017             | "EEEE, MMM d, yyyy"        ||
 || 10/12/2017                         | "MM/dd/yyyy"               ||
 || 10-12-2017 09:48                   | "MM-dd-yyyy HH:mm"         ||
 || Oct 12, 9:48 AM                    | "MMM d, h:mm a"            ||
 || October 2017                       | "MMMM yyyy"                ||
 || Oct 12, 2017                       | "MMM d, yyyy"              ||
 || Thu, 12 Oct 2017 09:48:59 +0000    | "E, d MMM yyyy HH:mm:ss Z" ||
 || 2017-10-12T09:48:59+0000           | "yyyy-MM-dd'T'HH:mm:ssZ"   ||
 || 12.10.17                           | "dd.MM.yy"                 ||
 --------------------------------------------------------------------
 */

