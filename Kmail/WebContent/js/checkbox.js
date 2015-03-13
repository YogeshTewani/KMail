// JavaScript Document

/*function funcSelectAll()
{
  
  for (var a=0; a < document.form1.chkMsgId.length; a++)
     document.form1.chkMsgId[a].checked = true;            
     
}

function funcDeselectAll()
{
  
  for (var a=0; a < document.form1.chkMsgId.length; a++)
     document.form1.chkMsgId[a].checked = false;            
     
}

function selectall(){
  var i=document.frm.elements.length;
  //var e=document.frm.elements;
  //var name=new Array();
  var value=new Array();
  var j=0;
  for(var k=0;k<i;k++)
  {
    if(document.frm.elements[k].name==fieldName)
    {
      if(document.frm.elements[k].checked==true){
        value[j]=document.frm.elements[k].value;
        j++;
      }
    }
  }
  checkSelect();
}*/

var fieldName='chkMsgId';

function selectCheck(obj)
{
 var i=document.frm.elements.length;
  for(var k=0;k<i;k++)
  {
    if(document.frm.elements[k].name==fieldName)
    {
      document.frm.elements[k].checked=obj;
    }
  }
  //selectall();
}

function selectallMe()
{
  if(document.frm.allCheck.checked==true)
  {
   selectCheck(true);
  }
  else
  {
    selectCheck(false);
  }
}


function checkSelect()
{
 var i=document.frm.elements.length;
 var berror=true;
  for(var k=0;k<i;k++)
  {
    if(document.frm.elements[k].name==fieldName)
    {
      if(document.frm.elements[k].checked==false)
      {
        berror=false;
        break;
      }
    }
  }
  if(berror==false)
  {
    document.frm.allCheck.checked=false;
  }
  else
  {
    document.frm.allCheck.checked=true;
  }
}


function deleteIt()
{
	//alert("This is DeleteIt");
	//var e1;
	var i=document.frm.elements.length;
	  //var e=document.frm.elements;
	  //var name=new Array();
	  var value1=new Array();
	  var j=0;
	  for(var k=0;k<i;k++)
	  {
		  //alert("for");
	    if(document.frm.elements[k].name==fieldName)
	    {
			//alert("fileName");
	      if(document.frm.elements[k].checked==true)
		  {
			  //alert("true");
			  //value1=document.frm.elements[k].value;
	        value1[j]=document.frm.elements[k].value;
	        j++;
	      }
	    }
	  }
	  //alert(value1);
	  //document.getElementById("dMsgId").value = value1;
	  document.getElementById("dMsgId").value = value1.join(";");
	  //e1=document.getElementById("dMsgId").value;
	  //alert(e1);
        
        document.delete1.action="DeleteHandler.jsp";
		document.delete1.submit();
}

function searchIt()
{
	document.search.action="Search.jsp";
	document.search.submit();
}

function update(boolean)
{
	if(boolean==true)
	{
		window.location="Profile.jsp";
		alert("Your data has been updated");
	}
	else
	{
		alert("error");
	}
}