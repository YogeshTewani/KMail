// JavaScript Document

function Trim(TRIM_VALUE)
{
	if(TRIM_VALUE.length<0)
		return "";
	TRIM_VALUE=RTrim(TRIM_VALUE);
	TRIM_VALUE=LTrim(TRIM_VALUE);
	
	if(TRIM_VALUE=="")
		return "";
	else
	{
		return TRIM_VALUE;
	}	
}

function RTrim(VALUE)
{
	var s_space = String.fromCharCode(32);
	var s_r= String.fromCharCode(13);
	var s_n= String.fromCharCode(10);
	var s_t= String.fromCharCode(9);
	
	var v_length=VALUE.length;
	var strTemp="";
	
	if(v_length<0)
		return "";
		
	iTemp=v_length-1;
		
	while(iTemp>-1)
	{
		if(VALUE.charAt(iTemp) == s_space || VALUE.charAt(iTemp) == s_r || VALUE.charAt(iTemp) == s_n || VALUE.charAt(iTemp) == s_t)
		{
			
		}
		else
		{
			strTemp=VALUE.substring(0,iTemp+1);
			break;
		}
		length=length-1;
	}
	return strTemp;
}

function LTrim(VALUE)
{
	var s_space = String.fromCharCode(32);
	var s_r= String.fromCharCode(13);
	var s_n= String.fromCharCode(10);
	var s_t= String.fromCharCode(9);
	
	var v_length=VALUE.length;
	var strTemp="";
	
	if(v_length<1)
		return "";
	
	iTemp=0;
	while(iTemp < v_length)
	{
		if(VALUE.charAt(iTemp) == s_space || VALUE.charAt(iTemp) == s_r || VALUE.charAt(iTemp) == s_n || VALUE.charAt(iTemp) == s_t)
		{
			
		}
		else
		{
			strTemp=VALUE.substring(iTemp,v_length);
			break;
		}
		iTemp=iTemp+1;
	}
	return strTemp;
}


