<html>
<head>
<title>JavaScript - Select All checkbox in form</title>
<script>
var fieldName='chkMsgId';

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
}
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
  selectall();
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
</script>
</head>

<body>
<form name="frm">
select all :<input type="checkbox" name="allCheck" onClick="selectallMe()">
<hr><br>
1  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
2  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
3  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
4  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
5  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
6  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
7  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
8  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
9  :<input type="checkbox" name="chkName" onClick="selectall()"><br>
10 :<input type="checkbox" name="chkName" onClick="selectall()"><br>
</form>
</body>
</html>