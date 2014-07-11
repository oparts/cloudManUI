<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<html>
<head>
<title>Virtual Machines</title>
<script type="text/javascript" src="d3.v3.min.js"></script> 

<style>
.link {
  fill: none;
  opacity: 0.45;
  stroke: #666;
  stroke-width: 1.5px;
}

#Composite {
  fill: red;
}

#Concurrent {
  fill: orange;
}

#Distributed {
  fill: steelblue;
}

.link.Composite {
  stroke: red;
}

.link.Concurrent {
  stroke: orange;
}

.link.Distributed {
  stroke: steelblue;
}

.link.Request {
  stroke-dasharray: 0,2 1;
}

#container {
		margin:2%;
		padding:20px;
		border:2px solid #d0d0d0;
		border-radius: 5px;
	}
	
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
div.tooltip {   
  position: absolute;           
  text-align: left;    
  line-height:1.8;
  vertical-align: middle;
  width: 150px;                  
  height: 130px;                 
  padding: 10px;             
  font: 13px sans-serif;  
  font-weight: bold;
  background: steelblue;   
  border: 0px;      
  border-radius: 8px;           
  pointer-events: none;   
  float: left;  
  color: white;
}
	
</style>
</head>

<body style="background:#EAEAEA;">

<script>

var width = 1500,
    height = 650;

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);
    
var div = d3.select("body").append("div")   
    .attr("class", "tooltip")               
    .style("opacity", 0);
	
var radius = d3.scale.linear()
	.domain([0, 100])
	.range([5, 100]);	
	
d3.json("./json/wholeGraph.json", function(error, graph) {

var nodes = {};

var link = svg.selectAll(".link")
      .data(graph.links)
      .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });


// Compute the distinct nodes from the links.
graph.links.forEach(function(link) {
  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
});

var force = d3.layout.force()
    .nodes(d3.values(nodes))
    .links(graph.links)
    .size([width, height])
    .linkDistance(100)
    .charge(-2000)
    .on("tick", tick)
    .start();

// Per-type markers, as they don't inherit styles.
svg.append("defs").selectAll("marker")
    .data(["Composite","Concurrent","Distributed","Request"])
  .enter().append("marker")
    .attr("id", function(d) { return d; })
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
	.attr("opacity", 0.95)	
  .append("path")
    .attr("d", "M0,-5L10,0L0,5");

var path = svg.append("g").selectAll("path")
    .data(force.links())
  .enter().append("path")
    .attr("class", function(d) { return "link " + d.type; })
    .attr("marker-end", function(d) { return "url(#" + d.type + ")"; });

var circle = svg.append("g").selectAll("circle")
    .data(force.nodes())
  .enter().append("circle")
    .attr("r", 7)
	.style("fill", "white")
	.attr("stroke", "black")
	.attr("stroke-width", "2")
	.on("mouseover", function(d) { 
            div.transition()        
                .duration(200)      
                .style("opacity", .9)
				.style("visibility", "visible");      
            div.html(information("./csv/" +d.name+".csv"))
                .style("left", (d3.event.pageX+20) + "px")     
                .style("top", (d3.event.pageY - 100) + "px");   
			d3.select(this).style("fill", "steelblue");
            })    				
    .on("mouseout", function(){
			d3.select(this).style("fill", "white");
			return div.style("visibility", "hidden");
			})
    .call(force.drag);

var text = svg.append("g").selectAll("text")
    .data(force.nodes())
  .enter().append("text")
  	 .style("font-family","Arial Unicode MS") 
    .attr("x", 8)
    .attr("y", "1.21em")
    .text(function(d) { return d.name; });

// Use elliptical arc path segments to doubly-encode directionality.
function tick() {
  path.attr("d", linkArc);
  circle.attr("transform", transform);
  text.attr("transform", transform);
}

function linkArc(d) {
  var dx = d.target.x  - d.source.x,
      dy = d.target.y - d.source.y,
      dr = Math.sqrt(dx * dx + dy * dy);
  return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
}

function transform(d) {
  return "translate(" + d.x  + "," + d.y   + ")";
}

function information(csvFileName)
{
  d3.csv(csvFileName, function(info) {
  
  var text = div.append("g").selectAll("text")
    .data(info)
  .enter().append("text")
	.html(function(d) {
		if( (d.name.valueOf() == new String("type").valueOf()) || (d.name.valueOf() == new String("ip").valueOf()) || (d.name.valueOf() == new String("group").valueOf()))
			return d.name + " : " + d.value + "<br/>";		
		
		else if((d.name.valueOf() == new String("net_in").valueOf()) || (d.name.valueOf() == new String("net_out").valueOf()))
			return d.name + " : " + d.value + " bps " + "<br/>";
			
		else		
			return d.name + " : " + d.value + " % " + "<br/>"; 
	});
})
}	
})	
</script>		
</body>
</html>
