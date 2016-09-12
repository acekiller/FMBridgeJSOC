# FMBridgeJSOC
FMBridgeJSOC 是一个针对UIWebView的 javascript 与 objc之间进行数据交互的简单简单实现，使用简单，只需将允许js调用的方法，注册到其中，那么就可以在js中随意调用方法了.

FMBridgeJSOC采用了Category的方式在UIWebView上实现的。所有基于UIWebView注册的方法都将被绑定在web的window上。

使用说明：
工程采用的pod管理方式，使用的时候只需
pod  'FMBridgeJSOC'
方式引入然后执行pod更新即可。
注册供js调用的方法是只需要调用UIWebView的
- (void)registerJSCallSelector:(SEL)aSelector withTarget:(id)target
方法将方法实现注册到web中。其中的aSelector为方法的实现SEL。target为此方法的的实现对象。

网页中调用，参考sdk中的test.html

详细的使用参考本实例吧。

