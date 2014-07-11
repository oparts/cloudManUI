<style>
.axis path, .axis line {
    fill: none;
    stroke: black;
    shape-rendering: crispEdges;
}
.axis text {
    font-family: sans-serif;
    font-size: 11px;
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
<body style="background:#EAEAEA;">

<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script>
var w = 1500;
var h = 600;
var padding = 10;
var num=100;

var svg = d3.select("body")
    .append("svg")
    .attr("width", w)
    .attr("height",h)
	.append("g")
		.attr("transform", "translate(30,0)");
		
var div = d3.select("body").append("div")   
    .attr("class", "tooltip")               
    .style("opacity", 0);

var dataset;
d3.csv("./csv/merge.csv", function(dataset) {

var cpuScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.cpu; })])
    .range([1, 100]);

var memScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.mem; })])
    .range([1, 10]);

var diskScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.disk; })])
    .range([1, 10]);

var netinScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.net_in; })])
  //  .domain([0,500])
    .range([1, 10]);

var netoutScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.net_out; })])
   // .domain([0,500])
     .range([1, 10]);


var xScale = d3.scale.linear()
    .domain([0, num])
    .range([padding, w - padding*2]);
var yScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out); })])
  //  .domain([0,10000])
   // .range([h - padding, padding]);
    .range([100,0])

var rScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out); })])
  //  .domain([0,1000])
    .range([5, 50]);


svg.selectAll("circle")
    .data(dataset)
    .enter()
    .append("circle")
    .attr("cx", function(d,i) {
        return xScale(i);
    })
    .attr("cy", function(d) {
        return h-rScale(cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out))*4;
    })
    .attr("r", function(d) {
        return rScale(cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out));
    })	
    .attr("fill", "greenyellow")
//	.attr("fill", function(d){ 
//        return "rgb(60, " + d.cpu * 15 + ", 127)";
//    })
    .attr("stroke", "orange")
	.on("click", function(d){
		if(d.group == 1)
		return window.open("index2.jsp"),'_blank','left=900,top=100,width=600,height=450,scrollbars=yes,status=yes'
		else
		return window.open("index3.jsp"),'_blank','left=900,top=100,width=600,height=450,scrollbars=yes,status=yes'; 
	})
	.on("mouseover", function(d) {      
            div.transition()        
                .duration(200)      
                .style("opacity", .9);      
            div.html(information("./csv/" +d.ip+".csv"))
                .style("left", (d3.event.pageX+20) + "px")     
                .style("top", (d3.event.pageY - 100) + "px");   
            })    				
	;
	


    setInterval(function(){
        //dataset.push(dataset.shift())
		d3.csv("./csv/merge.csv", function(dataset){
		
			svg.selectAll("circle")
			.data(dataset)
		    //.enter()
			//.append("circle")

			.transition()
			.duration(5000)
		//	.ease("circle")
			.attr("cx", function(d,i) {
				return xScale(i);
			})
			.attr("cy", function(d) {
				return h-rScale(cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out))*4;
			})
			.attr("r", function(d) {
				return  rScale(cpuScale(d.cpu)+memScale(d.mem)+diskScale(d.mem)+netinScale(d.net_in)+netoutScale(d.net_out));
			})
			.attr("fill", "greenyellow")
		//	.attr("fill", function(d){ 
		//		return "rgb(60, " + d.cpu * 5 + ", 127)";
		//	})	
			.attr("stroke", "orange");
			
			//circle.exit().remove();
			})
        console.log(dataset)
		//redraw1()
    },5000)

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
});

</script>
</body>
</html>
