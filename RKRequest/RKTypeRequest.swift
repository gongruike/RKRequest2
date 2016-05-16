import UIKit
import Alamofire

// 为什么子类查不到父类的init的方法呢？是因为泛型的原因吗？

/*
    字符串请求
 */
public class RKStringRequest<T>: RKRequest<String, T> {
    
    public override func parseResponse() {
        aRequest?.responseString(completionHandler: { response -> Void in
            
            self.aResponse = response
            self.deliverResult()
        })
    }
    
}

/*
    NSData请求
 */
public class RKDataRequest<T>: RKRequest<NSData, T> {
    
    public override func parseResponse() {
        aRequest?.responseData(completionHandler: { response in
            
            self.aResponse = response
            self.deliverResult()
        })
    }

}

/*
    普通JSON请求
 */
public class RKJSONRequest<T>: RKRequest<AnyObject, T> {
    
    override public func parseResponse() {
        aRequest?.responseJSON(completionHandler: { response -> Void in
            
            self.aResponse = response
            self.deliverResult()
        })
    }    
}

