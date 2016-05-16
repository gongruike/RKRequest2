# RKRequest
### A request library based on Alamofire that similar to Volley

用法类似于Volley，每一个请求都是一个对象实例，

例如你有一个Profile的请求，首先你要定义一个ProfileRequest，之后重写parseResponse和doParse方法(有时也需要重写init方法)，如下

	class Profile {
	    // Data
	}
	
	class ProfileRequest: RKRequest<ResponseType, Profile> {
	    
	    override func parseResponse() {
	        //
	    }
	
	    override func doParse() -> RKResult {
	        //
	    }
	
	}

parseResponse方法负责将服务器返回的数据解析成对应的数据格式即ResponseType，例如JSON，XML，String等

doParse方法则负责将parseResponse得到的数据进一步解析成一个Profile的实例对象

最后实例化并添加到一个RKRequestQueue中，

	let request = ProfileRequest { response in
	    switch response {
	    case .Success(let result):
	        // Success
	    case .Failure(let error):
	        // Error
	    }
	}
	someRequestQueue.startRequest(request)


如果你的数据都是JSON格式，并在应用中使用SwiftyJSON，则可以封装一个请求对象的基类

	class JSONRequest<T>: RKRequest<SwiftyJSON.JSON, T> {
	    
	    override func parseResponse() {
	        // 将返回的数据解析成SwiftyJSON.JSON
	    }
	}

其他的请求只需要继承于JSONRequest，并重写doParse方法即可

	class ProfileRequest: JSONRequest<Profile> {
	    
	    override func doParse() -> RKResult {
	        //
	    }
	}



