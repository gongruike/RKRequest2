# RKRequest
### A request library based on Alamofire that similar to Volley

这是一个基于Alamofire的iOS网络库，用法类似于安卓的网络框架Volley，每一个请求都是一个对象实例，具体用法请看下面的的介绍或者NetworkDemo工程
### Usage

例如你需要从服务器获取用户的个人信息，这就是一个Profile的请求。

首先你要定义一个继承于RKRequest的子类ProfileRequest，这个类用来负责获取个人信息profile，之后重写parseData和parseResponse(_)方法(有时也需要重写init方法)，如下

	class Profile {
	    // Data
	}
	
	class ProfileRequest: RKRequest<ResponseType, Profile> {
	    
	    override func parseData() {
	        //
	    }
	
	    override func parseResponse(response: RKResponse) -> RKResult {
	        //
	    }
	
	}

parseData方法负责将返回的数据解析成对应的数据格式即ResponseType，例如JSON，XML、String等

parseResponse方法则负责将parseData得到的数据进一步解析成一个Profile的实例对象

最后实例化并添加到一个RKRequestQueue中

	let request = ProfileRequest { result in
	    switch result {
	    case .Success(let profile):
	        // Success
	    case .Failure(let error):
	        // Error
	    }
	}
	someRequestQueue.startRequest(request)

这种写法利用了Alamofire.Result的优势，或成功或失败，不需要做nil判断

### Work With SwiftyJSON
如果你的数据格式都是JSON，则可以使用SwiftyJSON，封装一个请求对象的基类

	class BaseSwiftyJSONRequest<T>: RKRequest<SwiftyJSON.JSON, T> {
	    
	    override func parseData() {
	        // 将返回的数据解析成SwiftyJSON.JSON
	    }
	}

其他的请求只需要继承于BaseSwiftyJSONRequest，并重写parseResponse方法即可

	class ProfileRequest: BaseSwiftyJSONRequest<Profile> {
	    
	    override func parseResponse(response: RKResponse) -> RKResult {
	        //
	    }
	}



### Thanks To
#### [Alamofire](https://github.com/Alamofire/Alamofire)
#### [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
#### [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)


