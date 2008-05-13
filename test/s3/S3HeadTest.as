package s3 {
  
  import flexunit.framework.TestCase;
  import flexunit.framework.TestSuite;
  
  import org.httpclient.*;
  import org.httpclient.http.*;
  import org.httpclient.events.*;
  
  import com.adobe.net.*;
  
  import flash.utils.ByteArray;
  import flash.events.Event;
  
  public class S3HeadTest extends TestCase {
    
    public function S3HeadTest(methodName:String):void {
      super(methodName);
    }
    
    public static function suite():TestSuite {      
      var ts:TestSuite = new TestSuite();
      ts.addTest(new S3HeadTest("testHead"));
      return ts;
    }
        
    /**
     * Test head.
     */
    public function testHead():void {
      var client:HttpClient = new HttpClient();
            
      var uri:URI = new URI("http://http-test.s3.amazonaws.com/test.png");
      
      var request:HttpRequest = new Head();
      var response:HttpResponse = null;
      
      client.listener.onComplete = addAsync(function():void {
        assertNotNull(response);        
        assertTrue(response.header.length > 0);
         
      }, 20 * 1000);
      
      client.listener.onStatus = function(r:HttpResponse):void {
        response = r;
        assertTrue(response.isSuccess);
      };
      
      client.listener.onError = function(error:Error):void {
        fail(error.message);
      };
      
      client.request(uri, request);
      
    }
    
  }
  
}