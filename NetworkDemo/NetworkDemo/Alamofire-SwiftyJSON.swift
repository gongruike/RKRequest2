import Foundation

import Alamofire
import SwiftyJSON

// MARK: - Request for Swift JSON

extension Request {
    
    /**
        Adds a handler to be called once the request has finished.
        
        :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
        
        :returns: The request.
    */
    public func responseSwiftyJSON(completionHandler: Response<SwiftyJSON.JSON, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.SwiftyJSONResponseSerializer(), completionHandler: completionHandler)
    }
    
    
    /**
        Creates a response serializer that returns a SwiftyJSON.JSON object constructed from the response data using
        `SwiftyJSON` with the specified reading options.
        
        - parameter options: The JSON serialization reading options. `.AllowFragments` by default.
        
        - returns: A SwiftyJSON.JSON object response serializer.
    */
    public static func SwiftyJSONResponseSerializer() -> ResponseSerializer<SwiftyJSON.JSON, NSError> {
        return ResponseSerializer { _, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            if let response = response where response.statusCode == 204 { return .Success(SwiftyJSON.JSON.null) }
            
            guard let validData = data where validData.length > 0 else {
                let failureReason = "JSON could not be serialized. Input data was nil or zero length."
                let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let JSON = SwiftyJSON.JSON(data: validData)
            if let error = JSON.error {
                return .Failure(error)
            }
            
            return .Success(JSON)
        }
    }
}


