<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoundBar.aspx.cs" Inherits="newUPSIDE.RoundBar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript" src="https://d3js.org/d3.v4.min.js"></script>

        <style>
        .arc text {
            font: 16px arial;
            text-anchor: middle;
        }

        .arc path {
            stroke: #fff;
        }

        .title {
            font: 20px arial;
            fill: darkblue;
            font-weight: bold;
        }
    </style>
    <style>
        .line {
            fill: none;
            stroke: green;
            stroke-width: 5px;
        }
    </style>
        <style>
        .bar {
            fill: blue;
        }


        .highlight {
            fill: red;
        }

        .title {
            fill: blue;
            font-weight: bold;
        }

        svg rect {
            fill: gray;
        }

        svg text {
            fill: black;
            font: 12px sans-serif;
            text-anchor: end;
        }
    </style>

    <title> Multi-graphic display </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

        <form id="form1" runat="server">
        <div id="All">
            <div id="header">
                <h2>Multi-graphic display.</h2>
            </div>
            <!--div id="main"-->
 
            
            <div id="4">
                <p>The first graph.</p>
                <svg width="500" height="500" id="svg4"></svg>
                    <script>
                        var svg4 = d3.select("#svg4");
                        //var margin = 200;
                        var margin4 = 200;
                        var width4 = svg4.attr("width") - margin4;
                        var height4 = svg4.attr("height") - margin4;

                        //svg4.append("text")
                        //.attr("transform", "translate(100,0)")
                        //.attr("x", 50).attr("y", 50)
                        //.attr("font-size", "20px")
                        //.attr("class", "title")
                        //.text("Round_Time bar chart");

                        var x = d3.scaleBand().range([0, width4]).padding(0.4),
                            y = d3.scaleLinear().range([height4, 0]);         //range([300,0])

                        var g = svg4.append("g")
                            .attr("transform", "translate(" + 100 + "," + 100 + ")");



                        //read json file for data
                        d3.json("testbar.json", function (error, data2) {
                            //d3.csv("morleybar.csv", function (error, data2) {

                            if (error) {
                                throw error;
                            }

                            //importment! 解决数据超出数量级的问题
                            //将数据文件中的timeuse字段的值转换成数字类型
                            data2.forEach(function (d) {
                                d.round = d.round;
                                d.timeuse = +d.timeuse;                 //if no "+" , it shows wrong graph
                                console.log(d.round, d.timeuse);                 //print to the "Output" window of the IDE
                            });

                            x.domain(data2.map(function (d) { return d.round; }));
                            y.domain([0, d3.max(data2, function (d) { return d.timeuse; })]);
                            g.append("g")
                                .attr("transform", "translate(0," + height4 + ")")
                                .call(d3.axisBottom(x))
                                .append("text")
                                .attr("y", height4 - 250)
                                .attr("x", width4 - 100)
                                .attr("text-anchor", "end")
                                .attr("font-size", "18px")
                                .attr("stroke", "blue")
                                .text("Round");

                            g.append("g")
                                .append("text")
                                .attr("transform", "rotate(-90)")
                                .attr("y", 6)
                                .attr("dy", "-5.1em")
                                .attr("text-anchor", "end")
                                .attr("font-size", "18px")
                                .attr("stroke", "blue")
                                .text("TimeUse");

                            g.append("g")
                                .attr("transform", "translate(0, 0)")
                                .call(d3.axisLeft(y));

                            g.selectAll(".bar")
                                .data(data2)
                                .enter()
                                .append("rect")
                                .attr("class", "bar")
                                .on("mouseover", onMouseOver)
                                .on("mouseout", onMouseOut)
                                .attr("x", function (d) { return x(d.round); })
                                .attr("y", function (d) { return y(d.timeuse); })
                                .attr("width", x.bandwidth()).transition()
                                .ease(d3.easeLinear).duration(200)
                                .delay(function (d, i) {
                                    return i * 25;
                                })
                                .attr("height", function (d) { return height4 - y(d.timeuse); });
                        });


                        function onMouseOver(d, i) {
                            d3.select(this)
                                .attr('class', 'highlight');

                            d3.select(this)
                                .transition()
                                .duration(200)
                                .attr('width', x.bandwidth() + 5)
                                .attr("y", function (d) { return y(d.timeuse) - 10; })
                                .attr("height", function (d) { return height4 - y(d.timeuse) + 10; });

                            g.append("text")
                                .attr('class', 'val')
                                .attr('x', function () {
                                    return x(d.round);
                                })

                                .attr('y', function () {
                                    return y(d.value) - 10;
                                })
                        }

                        function onMouseOut(d, i) {

                            d3.select(this)
                                .attr('class', 'bar');

                            d3.select(this)
                                .transition()
                                .duration(200)
                                .attr('width', x.bandwidth())
                                .attr("y", function (d) { return y(d.timeuse); })
                                .attr("height", function (d) { return height4 - y(d.timeuse); });

                            d3.selectAll('.val')
                                .remove()
                        }
                    </script>
           </div>

            
            
            
            <div id="First">
                    <p>The second graph.</p>
                    <svg width="400" height="400" id="svg1"></svg>
                    <script>
                        var svg1 = d3.select("#svg1"),
                            width1 = svg1.attr("width"),
                            height1 = svg1.attr("height"),
                            radius = Math.min(width1, height1) / 2 - 30;

                        var g = svg1.append("g")
                            .attr("transform", "translate(" + width1 / 2 + "," + height1 / 2 + ")");

                        var color = d3.scaleOrdinal([
                            '#93C69F', '#ED8586', '#FDE3E3', '#F4DAAF', '#F9D652', '#8BA2D4', '#8B86C5', '#C9DEF2'
                        ]);
                        //var color = d3.scaleOrdinal(['gray', 'green', 'brown', 'orange']);

                        var pie = d3.pie().value(function (d) {
                            //return d.percent;                        // for populations.csv
                            return d.timeuse;
                        });

                        var path = d3.arc()
                            .outerRadius(radius - 10).innerRadius(0);

                        var label = d3.arc()
                            .outerRadius(radius).innerRadius(radius - 150);

                        //d3.csv("data.csv", function (error, data) {
                        //d3.csv("populations.csv", function(error, data) {    //for populations.csv
                        d3.json("testbar.json", function (error, data) {
                            if (error) {
                                throw error;
                            }

                            var arc = g.selectAll(".arc")
                                .data(pie(data))
                                .enter()
                                .append("g")
                                .attr("class", "arc");

                            arc.append("path")
                                .attr("d", path)
                                //.attr("fill", function(d) { return color(d.data.states); });    //for populations.csv
                                .attr("fill", function (d) { return color(d.data.round); });

                            console.log(arc)

                            arc.append("text").attr("transform", function (d) {
                                return "translate(" + label.centroid(d) + ")";
                            })
                                //.text(function(d) { return d.data.states; });                     //for populations.csv
                                .text(function (d) { return d.data.timeuse; });
                        });

                        svg1.append("g")
                            .attr("transform", "translate(" + (width1 / 2 + 100) + "," + 20 + ")")
                            // .append("text").text("The size of Australia's states")           // for populations.csv
                            .append("text").text("The time used in rounds")
                            .attr("class", "title")
                    </script>
                </div>

                <div id="Second">
                    <p>The third graph.</p>
                    <svg width="400" height="400" id="svg2"></svg>
                    <script>
                        var svg2 = d3.select("#svg2");   //!!! important
                        svg2.append("circle")
                            .attr("cx", 200)
                            .attr("cy", 200)
                            .attr("r", 150)
                            .attr("fill", "blue");
                    </script>
                </div>


                <div id="Third">
                    <p>The fourth graph.</p>
                    <svg width="480" height="250" id="svg3"></svg>
                        <script>
                            // set the dimensions and margins of the graph
                            var margin = { top: 20, right: 20, bottom: 30, left: 50 },
                                width3 = 480 - margin.left - margin.right,
                                height3 = 250 - margin.top - margin.bottom;

                            // set the ranges
                            var x = d3.scaleLinear().range([0, width3]);    //OK
                            var y = d3.scaleLinear().range([height3, 0]);

                            // define the line
                            var valueline = d3.line()
                                .x(function (d) { return x(d.round); })
                                .y(function (d) { return y(d.timeuse); });

                            var svg3 = d3.select("body").append("svg")
                                .attr("width", width3 + margin.left + margin.right)
                                .attr("height", height3 + margin.top + margin.bottom)
                                .append("g").attr("transform",
                                    "translate(" + margin.left + "," + margin.top + ")");

                            // Get the data
                            d3.json("testbar.json", function (error, data) {
                                if (error) throw error;
                                // format the data
                                data.forEach(function (d) {
                                    d.Round = d.round;
                                    d.TimeUse = +d.timeuse;
                                });

                                // Scale the range of the data
                                x.domain(d3.extent(data, function (d) { return d.round; }));
                                y.domain([0, d3.max(data, function (d) { return d.timeuse; })]);



                                // Add the valueline path.
                                svg3.append("path")
                                    .data([data])
                                    .attr("class", "line")
                                    .attr("d", valueline);
                                // Add the X Axis
                                svg3.append("g")
                                    //.attr("transform", "translate(0," + height + ")")
                                    .attr("transform", "translate(" + 0 + "," + height3 + ")")      //500-20-30=450
                                    .call(d3.axisBottom(x))
                                    .append("text")
                                    //.attr("y", height -20)       //  height -250  ????
                                    .attr("x", width3 - 200)        // width - 100
                                    .attr("text-anchor", "end")
                                    .attr("font-size", "18px")
                                    .attr("stroke", "blue")
                                    .text("Round");


                                // Add the Y Axis
                                svg3.append("g")
                                    .call(d3.axisLeft(y))
                                    .append("text")
                                    .attr("transform", "rotate(-90)")
                                    //  .attr("transform", "translate(" + width + "," + height + ")")      //500-20-30=450
                                    .attr("y", 20)
                                    // .attr("dy", "-5.1em")
                                    .attr("text-anchor", "end")
                                    .attr("font-size", "18px")
                                    .attr("stroke", "blue")
                                    .text("TimeUse");

                            });
                        </script>

                </div>


            <!--/div-->
            <!--div id="footer">
                <h2>This is the footer for the demo.</h2>
            </!--div-->


        
        </div>
    </form>


</asp:Content>
