// Ajax

//Ajax call 
var ajaxRequest;  	// The variable that makes Ajax possible!
function createRequest()
{
	
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
		return ajaxRequest;
	}
	catch (e)
	{
		// Internet Explorer Browsers
   		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			return ajaxRequest;
   		}
		catch (e) 
		{
      		try
			{
         			ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					return ajaxRequest;
      		}
			catch (e)
			{
        			 // Something went wrong
         			alert("Your browser broke!");
         			return false;
      		}
   		}
 	}
}


//To validate User Id on keyPress
function validateUserId() 
{
	//alert("validating");
   //if(document.getElementById("userId").value.length<5)
   //{
	 //  alert("length less");
	 //  document.getElementById("userIdMessage").style.color = "red"
	   //document.getElementById("userIdMessage").innerHTML='UserId should be atleast 5 characters long';
  //}
   //else
   //{
	   //alert("Inside");
	   //var xmlHttp=createRequest();
	   createRequest()
	   //alert(ajaxRequest);
   		
		//alert("get");
   		
   			var target = document.getElementById("userId");
   			var url = "CheckUserIdAvailability.jsp?userId=" + escape(target.value);
			//alert(target.value);
			//alert(ajaxRequest);
   		ajaxRequest.open("GET", url, true);
		//alert(ajaxRequest);
   		ajaxRequest.send(null);
		//alert("ji");
		
		// Here processRequest() is the callback function.
   		ajaxRequest.onreadystatechange = processRequest;
   //}
   
}


function processRequest() 
{
	//alert("process");//&& ajaxRequest.status == 200
   if (ajaxRequest.readyState == 4) 
   {
	   //alert("prcess1");
         //alert("200");
		 var message = ajaxRequest.responseText;
		 //alert(message);
		 var show=message.split(":");
		 //alert(show[1].trim());
		 document.getElementById("userIdMessage").innerHTML=show[0];
		 
		 document.getElementById("userIdStatus").value=show[1];
	
   }

}