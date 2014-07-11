<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html>
<head>
<title></title>

<script type="text/javascript" src="d3.v3.min.js"></script> 

<!-- Navigation -->

<style type="text/css">

#time{
font-size: 18px;
line-height:0.3;
vertical-align: middle;
font-family:"Adobe Fan Heiti Std B",Georgia,Serif;
float: right;
margin: 0 40px ;
}

/* Structure */
.nytg {
  font-family: Arial;
}

#nytg-chartFrame{
  -webkit-transition: height ease-in-out 1s;  
  -moz-transition: height ease-in-out 1s;    
  -o-transition: height ease-in-out 1s;    
  -ms-transition: height ease-in-out 1s;        
}

#nytg-chart {
  position: relative;

}

/* Navigation */
.nytg-navBar {
  border-top: solid 1px #DDD;
  padding: 15px 0 0;
  margin: 0 10px;
}

.nytg-navigation {
  
}
.nytg-navigation li {
  color: #999;
  font-size: 14px;
  cursor: pointer;
  float: right;
  padding: 10px 18px;
  border-top: solid 1px #CCC;
  border-bottom: solid 1px #CCC;
  border-left: solid 1px #CCC;
  background: #f9f9f9;
  text-decoration: none;
  margin: 0 0;
}

.nytg-navigation li:first-of-type{
  border-radius: 4px 0 0 4px;
}
.nytg-navigation li:last-of-type{

  border-right: solid 1px #CCC;
  border-radius: 0 4px 4px 0;
}
.nytg-navigation li.selected {
  color: #000;
  background: #e9e9e9;
  border-color: #AAA;
  box-shadow: inset 0px 0px 4px rgba(0,0,0,0.2);
}
</style>
</head>

<body style="background:#EAEAEA;" onload="updateTime();">		


<li id="time"> <p><b>hello</b></p> 		
	<script type="text/javascript">	
<!--
	function updateTime(){
	var currentDate = new Date();
	var day = currentDate.getDate();
	var month = currentDate.getMonth() + 1;
	var year = currentDate.getFullYear();
	var currentTime = new Date();
	var hours = currentTime.getHours();
	var minutes = currentTime.getMinutes();
	var seconds = currentTime.getSeconds();
    		  
    if (minutes < 10)
	minutes = "0" + minutes

	var suffix = "AM";
	if (hours >= 12) {
	suffix = "PM";
	hours = hours - 12;
	}
	if (hours == 0) {
	hours = 12;
	}	

	var canvas = d3.select("body");

	var time = canvas.select("p")
    		  .text(hours + ":" + minutes + ":" + seconds + " " + suffix + " " + day + "/" + month + "/" + year)
    		  .style("color", "Black")
			  .style("font-weight","bold")
			  .style("font-family","Adobe Fan Heiti Std B");			  
	
	setTimeout(updateTime,5000);		
	}	
</script>	
</li>

</body>
</html>