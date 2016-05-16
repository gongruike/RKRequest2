// The MIT License (MIT)
//
// Copyright (c) 2016 Ruike Gong
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


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

