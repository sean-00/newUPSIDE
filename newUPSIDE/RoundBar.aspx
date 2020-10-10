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

        .line {
            fill: none;
            stroke: green;
            stroke-width: 5px;
        }

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
        <!--div-- id="All"-->
            
            
            <div id="header">
                <!--h2>Multi-graphic display.</!--h2-->
            </div>
 

        <div id="A">                              
            <p>Grahp 1</p>
            <svg width ="500" height ="500" id ="svg4"></svg>
            <script>

                var svg4 = d3.select("#svg4");
                var margin = 200;
                var width = svg4.attr("width") - margin;
                var height = svg4.attr("height") - margin;

                svg4.append("text")
                    .attr("transform", "translate(100,0)")
                    .attr("x", 150)
                    .attr("y", 50)
                    .attr("font-size", "20px")
                    .attr("class", "title")
                    .text("Round_Time bar chart");

                var x1 = d3.scaleBand().range([0, width]).padding(0.4),                 //
                    y1 = d3.scaleLinear().range([height, 0]);         //range([300,0])           //

                var g = svg4.append("g")
                    .attr("transform", "translate(" + 100 + "," + 100 + ")");

                //read json file for data
                d3.json("testbar.json", function (error, data2) {

                    if (error) {
                        throw error;
                    }

                    //将数据文件中的timeuse字段的值转换成数字类型
                    data2.forEach(function (d) {
                        d.round = d.round;
                        d.timeuse = +d.timeuse;
                        console.log(d.round, d.timeuse);        //print to the "Output" window of the IDE
                    });

                    x1.domain(data2.map(function (d) { return d.round; }));                     //
                    y1.domain([0, d3.max(data2, function (d) { return d.timeuse; })]);          //


                    g.append("g")
                        .attr("transform", "translate(0," + height + ")")
                        .call(d3.axisBottom(x1))                                        //
                        .append("text")
                        .attr("y", height - 250)
                        .attr("x", width - 100)
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
                        .call(d3.axisLeft(y1));                                 //

                    g.selectAll(".bar")
                        .data(data2)
                        .enter()
                        .append("rect")
                        .attr("class", "bar")
                        .on("mouseover", onMouseOver)
                        .on("mouseout", onMouseOut)
                        .attr("x", function (d) { return x1(d.round); })                //
                        .attr("y", function (d) { return y1(d.timeuse); })              //
                        .attr("width", x1.bandwidth()).transition()                     //
                        .ease(d3.easeLinear).duration(200)
                        .delay(function (d, i) { return i * 25; })
                        .attr("height", function (d) { return height - y1(d.timeuse); });       //
                });
                console.log("x.bandwidth()=", x.bandwidth());

                function onMouseOver(d, i) {
                    d3.select(this)
                        .attr('class', 'highlight');

                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('width', x1.bandwidth() + 5)                              //
                        .attr("y", function (d) { return y1(d.timeuse) - 10; })         //
                        .attr("height", function (d) { return height - y1(d.timeuse) + 10; });      //

                    g.append("text")
                        .attr('class', 'val')
                        .attr('x', function () {
                            return x1(d.round);                             //
                        })

                        .attr('y', function () {
                            return y1(d.value) - 10;                    //
                        })
                }

                function onMouseOut(d, i) {

                    d3.select(this)
                        .attr('class', 'bar');

                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('width', x1.bandwidth())              //
                        .attr("y", function (d) { return y1(d.timeuse); })              //
                        .attr("height", function (d) { return height - y1(d.timeuse); });           //

                    d3.selectAll('.val')
                        .remove()
                }

            </script>

        </div>

                        
        <div id="Second">
            <p>Graph 2</p>
            <svg width="480" height="250" id="svg3"></svg>
                <script>
                            // set the dimensions and margins of the graph
                            var margin3 = { top: 20, right: 20, bottom: 30, left: 50 },
                                width3 = 480 - margin3.left - margin3.right,
                                height3 = 250 - margin3.top - margin3.bottom;

                            // set the ranges
                            var x = d3.scaleLinear().range([0, width3]);    //OK
                            var y = d3.scaleLinear().range([height3, 0]);

                            // define the line
                            var valueline = d3.line()
                                .x(function (d) { return x(d.round); })
                                .y(function (d) { return y(d.timeuse); });

                            var svg3 = d3.select("body").append("svg")
                                .attr("width", width3 + margin3.left + margin3.right)
                                .attr("height", height3 + margin3.top + margin3.bottom)
                                .append("g").attr("transform",
                                    "translate(" + margin3.left + "," + margin3.top + ")");

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
        
        <!--/div-->
    </form>


</asp:Content>
