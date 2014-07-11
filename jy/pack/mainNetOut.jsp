<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html>	
<head>
<title>Graph</title>

<script type="text/javascript" src="d3.v3.min.js"></script> 

<!-- Navigation -->

<style type="text/css">
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
  width: 100%;
  height: 100%;
}

/* Navigation */
.nytg-navBar {
  border-top: solid 2px #DDD;
  
#nytg-chartCanvas {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 10;
  width: 100%;
  height: 100%;
  overflow: hidden;
  
}
#nytg-chartCanvas svg {
  height: 100%;
  overflow: hidden;config/
	assets.yml
	settings.yml
}  

</style>
</head>

<body style="background:#EAEAEA;" onload="drawGraph();">		
<div class="nytg-navBar"></div>

<script>

var width = 500,
    height = 400;
	
var colorRange = d3.scale.linear()
			.domain([0, 100])
			.range(["#EAEAEA","purple"])

var canvas = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
	.append("g")
		.attr("transform", "translate(0,50)");

var pack = d3.layout.pack()
    .size([width, height-50])
	.padding(10);
	
function drawGraph(){
d3.json("./json/netOutUtil.json", function(data) {
var nodes = pack.nodes(data);
console.log(data);

var node = canvas.selectAll(".node")
		.data(nodes)
		.enter()
		.append("g")
			.attr("class","node")
			.attr("transform", function (d) {return "translate(" + d.x + "," + d.y + ")";});			
		
	node.append("circle")
		.attr("r", function(d){return d.r;})
		.style("fill", function(d) {if(d.children) {return "#EAEAEA";} else {return colorRange(d.r);}})
		.attr("stroke-width", "2")
		.attr("opacity", 0.85)
		.attr("gravity", 10)
		.attr("stroke", function (d) {return d.children ? "#EAEAEA" : "#ADADA";})
		.attr("stroke-width", "2")
		.on("mouseover", function(d){return d.children ? d3.select(this).style("fill", "#EAEAEA") : d3.select(this).style("fill", "orange");})
		.on("mouseout", function(d){return d.children ? d3.select(this).style("fill", "#EAEAEA") : d3.select(this).style("fill", colorRange(d.r));})
		.on("click", function(){window.open("wholeGraph.jsp"),'window','width=900,height=650,scrollbars=yes,status=yes';});

	node.append("text")
		.text(function (d) {return d.children ? "" : d.name; });	
})
setTimeout(drawGraph, 5000);
d3.selectAll(".node").remove();	
}


</script>

</body>
</html>