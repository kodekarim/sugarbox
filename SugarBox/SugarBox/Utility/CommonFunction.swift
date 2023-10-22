//
//  CommonFunction.swift
//  SugarBox
//
//  Created by abdul karim on 22/10/23.
//

import Foundation

func getImageLink(assets:[Assets]?) -> URL? {
    let filterJPG = assets?.filter{ $0.sourcePath?.hasSuffix(".jpg") == true }
    let imageURLSuffix = filterJPG?.first?.sourcePath ?? ""
    
    let imageURLString = APIConstants.imageBaseURL + imageURLSuffix
    return URL.init(string: imageURLString)
}

