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
</style>
<body style="background:#EAEAEA;">
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script>
var w = 1000;
var h = 600;
var padding = 50;

var num=24;

var svg = d3.select("body")
    .append("svg")
    .attr("width", w)
    .attr("height",h)
	.append("g")
		.attr("transform", "translate(30,100)");;

//var scale = d3.scale.linear()
//    .domain([100, 500])
//    .range([10, 350]);	
	
//var dataset = [
//          [15], [25], [5], [50], [25], [45], [20], [2], [2], [50],
//		  [50], [2], [15], [100], [15], [45], [10], [2], [96], [25],
//          [2], [2], [2], [2]
//        ];
	


//d3.csv("merge.csv", function(d) {
//	dataset=d;
//  return {
//    cpu: +d.cpu, 
//    mem: +d.mem,
//    disk: +d.disk,
//   net_in: +d.net_in, // convert "net_in" column to number
//	net_in: +d.net_in
//  };
//}, function(error, rows) {
//  console.log(rows);
//});

//var dataset = []
var dataset;
d3.csv("./csv/merge.csv", function(dataset) {

var xScale = d3.scale.linear()
    .domain([0, num])
    .range([padding, w - padding*2]);
var yScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.net_in; })])
    .range([h - padding, padding]);

	var rScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d.net_in; })])
    .range([5, 100]);

svg.selectAll("circle")
    .data(dataset)
    .enter()
    .append("circle")
    .attr("cx", function(d,i) {
        return xScale(i);
    })
    .attr("cy", function(d) {
        return h-rScale(d.net_in)*5;
    })
    .attr("r", function(d) {
        return rScale(d.net_in);
    })	
	.attr("fill", function(d){ 
        return "rgb(60, " + d.net_in * 5 + ", 127)";
    })
    .attr("stroke", "orange")
	.on("click", function(){window.open("wholeGraph.jsp"),'window','width=900,height=650,scrollbars=yes,status=yes';});

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
				return h-rScale(d.net_in)*5;
			})
			.attr("r", function(d) {
				return rScale(d.net_in);
			})
			.attr("fill", function(d){ 
				return "rgb(60, " + d.net_in * 5 + ", 127)";
			})	
			.attr("stroke", "orange");
			
			//circle.exit().remove();
			})
        console.log(dataset)
		//redraw1()
    },5000)		
	
});

</script>