
   <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="ViewExperimentData.aspx.cs" Inherits="newUPSIDE.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head"  runat="server">


    <!-- 
    Response.Buffer = true;
    //Response.ExpiresAbsolute = now() - 1;
    Response.Expires = 0;
    Response.CacheControl = "no-cache";
    //Response.AddHeader "Pragma", "No-Cache";
    -->
    <!--
    Response.Expires = 0;
    Response.Cache.SetNoStore();
    Response.AppendHeader("Pragma", "no-cache");
    -->

    <script type="text/javascript" src="https://d3js.org/d3.v4.min.js"></script>
    <!--script type="text/javascript" src="d3.v4.min.js"></script-->
    <style>
        table tbody {
            display: block;
            height: 200px;
            overflow-y: scroll;
        }

        table tbody1 {
            display: block;
            height: 150px;
            overflow-y: scroll;
        }

        table thead, tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        table thead {
            width: calc( 100% - 1em )
        }

            table thead th {
                background: #ccc;
            }
    </style>

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
            stroke: blueviolet;
            stroke-width: 3px;
        }

        .bar {
            fill: lightblue;
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

    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
    <script src="lib/main.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body"  runat="server">
    <form id="form1" runat="server">
         <asp:Label ID="Label2" runat="server" Text="Select Experiment" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
        <asp:DropDownList ID="ExperimentNameSelected" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ExperimentNameSelected_SelectedIndexChanged" Width="50%">
            
            
        </asp:DropDownList>
        
        <a  href="UPSIDE-Experiment://UnityExperiment.exe">Open Experiment</a>        
        <asp:Label ID="Label3" runat="server" Text="Experiment Description" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
       <asp:Label ID="Label4" runat="server" Text="Please choose the experiments"  Width="100%"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="Experiment Data" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
        <asp:Label ID="LabelTest" runat="server" Text=""></asp:Label>
        <asp:Table class="table table-bordered table-striped" id="ExperimentDataTable" runat="server">
            <asp:TableHeaderRow ID ="tableHeaderName" >
                
            </asp:TableHeaderRow>
            <asp:TableRow ID="tablerow">

            </asp:TableRow>
        </asp:Table>
        <table class="table table-bordered table-striped" >
           
        </table>
        <div id="box">
        </div>
 
        <div id="A">                              
            <H2>&nbsp;Bar chart of time used in each round</H2>
            <svg width ="500" height ="500" id ="svg4"></svg>
            <script>
                function Init() {
                    var v = "ÖÐ¹ú";
                    var s = '<%=CsharpVoid("'+v+'") %>';
                    alert(s);
                }
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
                    //.text("Round_Time bar chart");

                var x1 = d3.scaleBand().range([0, width]).padding(0.4),                         //
                    y1 = d3.scaleLinear().range([height, 0]);         //range([300,0])          //

                var g = svg4.append("g")
                    .attr("transform", "translate(" + 100 + "," + 100 + ")");

                //var filepath = "File/";
                //var filename = filepath + "testbar.json";
                var filename = "testbar.json";
                //read json file for data
                d3.json(filename, function (error, data2) {                         //Use "/" to combine directory name and file name
                //d3.json("testbar.json", function (error, data2) {                 //read testbar.json in root directory

                    if (error) {
                        console.error(error);
                    } else {
                        console.log(data2);
                    }
                    //if (error) {
                    //    throw error;
                    //}

                    data2.forEach(function (d) {
                        d.Round = d.Round;
                        d.TimeUse = +d.TimeUse;
                        console.log("A:", d.Round, d.TimeUse);     
                    });

                    x1.domain(data2.map(function (d) { return d.Round; }));                     //
                    y1.domain([0, d3.max(data2, function (d) { return d.TimeUse; })]);          //


                    g.append("g")
                        .attr("transform", "translate(0," + height + ")")
                        .call(d3.axisBottom(x1))                                                //
                        .append("text")
                        .attr("y", height - 300)                                    //height -250 below the axis(y)
                        .attr("x", width + 50)                                      //width -100 @ mid
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
                        .text("Time");

                    g.append("g")
                        .attr("transform", "translate(0, 0)")
                        .call(d3.axisLeft(y1));                                         //

                    g.selectAll(".bar")
                        .data(data2)
                        .enter()
                        .append("rect")
                        .attr("class", "bar")
                        .on("mouseover", onMouseOver)
                        .on("mouseout", onMouseOut)
                        .attr("x", function (d) { return x1(d.Round); })                //
                        .attr("y", function (d) { return y1(d.TimeUse); })              //
                        .attr("width", x1.bandwidth()).transition()                     //
                        .ease(d3.easeLinear).duration(200)
                        .delay(function (d, i) { return i * 25; })
                        .attr("height", function (d) { return height - y1(d.TimeUse); });       //
                });
                //console.log("x.bandwidth()=", x.bandwidth());

                function onMouseOver(d, i) {
                    d3.select(this)
                        .attr('class', 'highlight');

                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('width', x1.bandwidth() + 5)                              //
                        .attr("y", function (d) { return y1(d.TimeUse) - 10; })         //
                        .attr("height", function (d) { return height - y1(d.TimeUse) + 10; });      //

                    g.append("text")
                        .attr('class', 'val')
                        .attr('x', function () {
                            return x1(d.Round);                                         //
                        })

                        .attr('y', function () {
                            return y1(d.value) - 10;                                    //
                        })
                }

                function onMouseOut(d, i) {

                    d3.select(this)
                        .attr('class', 'bar');

                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('width', x1.bandwidth())                                  //
                        .attr("y", function (d) { return y1(d.TimeUse); })              //
                        .attr("height", function (d) { return height - y1(d.TimeUse); });           //

                    d3.selectAll('.val')
                        .remove()
                }

            </script>
        </div>

        <div id="Second">
            <H2>&nbsp;Line chart of time used in each round</H2>
            <br><br><br>
            <svg width="480" height="250" id="svg3"></svg>
                <script>
                    // set the dimensions and margins of the graph, top 20,right 50, bottom 30, left 50
                    // change to left = 80 ,
                    var margin3 = { top3: 50, right3: 50, bottom3: 0, left3: 80 },
                        width3 = 480 - margin3.left3 - margin3.right3,
                        height3 = 250 - margin3.top3 - margin3.bottom3;


                    // set the ranges
                    var x = d3.scaleLinear().range([0, width3]);    // 0~480-80-50=250
                    var y = d3.scaleLinear().range([height3, 0]);   //250-50-0=200 ~ 0

                    // define the line
                    var valueline = d3.line()
                        .x(function (d) { return x(d.Round); })
                        .y(function (d) { return y(d.TimeUse); });


                    //var svg3 = d3.select("body").append("svg")
                    var svg3 = d3.select("#svg3").append("svg")
                        .attr("width", width3 + margin3.left3 + margin3.right3)
                        .attr("height", height3 + margin3.top3 + margin3.bottom3)
                        .append("g").attr("transform",
                            "translate(" + margin3.left3 + "," + 20 + ")");
                        //.append("g").attr("transform",
                        //    "translate(" + margin3.left3 + "," + margin3.top3 + ")");


                    // Get the data
                    //d3.json("File/testbar.json", function (error, data) {
                    d3.json(filename, function (error, data) {
                        if (error) throw error;
                        // format the data
                        data.forEach(function (d) {
                            d.Round = d.Round;
                            d.TimeUse = +d.TimeUse;
                            console.log("B:", d.Round, d.TimeUse);
                        });

                        // Scale the range of the data
                        x.domain(d3.extent(data, function (d) { return d.Round; }));
                        y.domain([0, d3.max(data, function (d) { return d.TimeUse; })]);

                        // Add the valueline path.
                        svg3.append("path")
                            .data([data])
                            .attr("class", "line")
                            .attr("d", valueline);
                        // Add the X Axis
                        svg3.append("g")
                            //.attr("transform", "translate(0," + height + ")")
                            .attr("transform", "translate(" + 0 + "," + height3 + ")")      //500-20-30=450
                            .call(d3.axisBottom(x).ticks(5))                                //ticks(5) show 5 scale
                            .append("text")
                            //.attr("y", height3)                                           // height -250  
                            .attr("x", width3 + 50)                                         // width - 100 @ mid
                            .attr("text-anchor", "end")
                            .attr("font-size", "18px")
                            .attr("stroke", "blue")
                            .text("Round");

                        // Add the Y Axis
                        svg3.append("g")
                            .attr("transform", "translate(" + 0 + "," + 0 + ")")            //
                            .call(d3.axisLeft(y))
                            .append("text")
                            .attr("transform", "rotate(-90)")
                            .attr("x",20)
                            //  .attr("transform", "translate(" + width + "," + height + ")")
                            .attr("y", -50)                                                 //OK !
                            //.attr("dy", "-5.1em")
                            .attr("text-anchor", "end")
                            .attr("font-size", "18px")
                            .attr("stroke", "blue")
                            .text("Time");

                    });
                </script>
            </div>

            <div id="B">   
            <br><br><br>
            <H2>&nbsp;Percentage of Success</H2>
            <svg width="600" height="600" id="svg2"></svg>
            <script>
                //
                var width2 = 600;
                var height2 = 600;
                var itemCount2 = 0;
                var trueCount2 = 0;
                var falseCount2 = 0;

                d3.json(filename, function (error, data123) {
                    console.log("data123.length=" + data123.length);
                    if (error) {
                        throw error;
                    }
                    //console.log(data123.filter((res) => { return res.Success == false }).length)
                    //console.log(data123.filter((res) => { return res.Success == true }).length)
                    falseCount2 = parseInt(data123.filter((res) => { return res.Success == false }).length);
                    trueCount2 = parseInt(data123.filter((res) => { return res.Success == true }).length);
                    console.log("falseCount2=" + falseCount2 + ",   trueCount2=" + trueCount2);

                    var dataset = [['Success', trueCount2], ['Failure', falseCount2]];
                    var pie = d3.pie()
                        .sort(null)
                        .value(function (d) {
                            return d[1];
                        });
                    var piedata = pie(dataset);

                    var outerRadius2 = width2 / 4;
                    var innerRadius2 = 0;

                    var arc = d3.arc()
                        .outerRadius(outerRadius2)
                        .innerRadius(innerRadius2);

                    var colors = d3.schemeCategory10;

                    //var svg = d3.select('body')
                    var svg2 = d3.select("#svg2")
                        .append('svg')
                        .attr('width', width2)
                        .attr('height', height2);

                    var arcs = svg2.selectAll('g')
                        .data(piedata)
                        .enter()
                        .append('g')
                        .attr('transform', 'translate(' + width2 / 2 + ',' + height2 / 2 + ')');

                    arcs.append('path')
                        .attr('fill', function (d, i) {
                            return colors[i];
                        })
                        .attr('d', function (d) {
                            return arc(d);
                        });

                    arcs.append('text')
                        .attr('transform', function (d, i) {
                            var x2 = arc.centroid(d)[0] * 2.8;
                            var y2 = arc.centroid(d)[1] * 2.8;
                            if (i === 4) {
                                return 'translate(' + (x2 * 1.2) + ', ' + (y2 * 1.2) + ')';
                            } else if (i === 3) {
                                return 'translate(' + (x2 - 40) + ', ' + y2 + ')';
                            } else if (i === 5) {
                                return 'translate(' + (x2 + 40) + ', ' + y2 + ')';
                            }
                            return 'translate(' + x2 + ', ' + y2 + ')';
                        })
                        .attr('text-anchor', 'middle')
                        .style("font-size", "16px")
                        .attr("stroke", "blue")
                        .text(function (d) {
                            var percent = Number(d.value) / d3.sum(dataset, function (d) {
                                return d[1];
                            }) * 100;
                            return d.data[0] + ' ' + percent.toFixed(1) + '%';
                        })

                    arcs.append('line')
                        .attr('stroke', 'black')
                        .attr('x1', function (d) { return arc.centroid(d)[0] * 2; })
                        .attr('y1', function (d) { return arc.centroid(d)[1] * 2; })
                        .attr('x2', function (d, i) {
                            if (i === 4) {
                                return arc.centroid(d)[0] * 3.2;
                            }
                            return arc.centroid(d)[0] * 2.5;
                        })
                        .attr('y2', function (d, i) {
                            if (i === 4) {
                                return arc.centroid(d)[1] * 3.2;
                            }
                            return arc.centroid(d)[1] * 2.5;
                        });
                });
//
            </script>
        </div>

        <div id="E">  
            <br>
            <H2>&nbsp;Percentage of Overtime</H2>
            <svg width="600" height="600" id="svg5"></svg>
            <script>
                //
                var width5 = 600;
                var height5 = 600;
                var itemCount5 = 0;
                var trueCount5 = 0;
                var falseCount5 = 0;

                d3.json(filename, function (error, data1234) {
                    console.log("data1234.length=" + data1234.length);
                    if (error) {
                        throw error;
                    }
                    //console.log(data123.filter((res) => { return res.Success == false }).length)
                    //console.log(data123.filter((res) => { return res.Success == true }).length)
                    falseCount5 = parseInt(data1234.filter((res) => { return res.OverTime == false }).length);
                    trueCount5 = parseInt(data1234.filter((res) => { return res.OverTime == true }).length);
                    console.log("falseCount5=" + falseCount5 + ",   trueCount5=" + trueCount5);

                    var dataset = [['Timeout', trueCount5], ['No timeout', falseCount5]];
                    var pie = d3.pie()
                        .sort(null)
                        .value(function (d) {
                            return d[1];
                        });
                    var piedata = pie(dataset);

                    var outerRadius5 = width5 / 4;
                    var innerRadius5 = 0;

                    var arc = d3.arc()
                        .outerRadius(outerRadius5)
                        .innerRadius(innerRadius5);

                    var colors = d3.schemeCategory10;

                    //var svg = d3.select('body')
                    var svg5 = d3.select("#svg5")
                        .append('svg')
                        .attr('width', width5)
                        .attr('height', height5);

                    var arcs = svg5.selectAll('g')
                        .data(piedata)
                        .enter()
                        .append('g')
                        .attr('transform', 'translate(' + width5 / 2 + ',' + height5 / 2 + ')');

                    arcs.append('path')
                        .attr('fill', function (d, i) {
                            return colors[i + 7];
                        })
                        .attr('d', function (d) {
                            return arc(d);
                        });

                    arcs.append('text')
                        .attr('transform', function (d, i) {
                            var x5 = arc.centroid(d)[0] * 2.8;
                            var y5 = arc.centroid(d)[1] * 2.8;
                            if (i === 4) {
                                return 'translate(' + (x5 * 1.2) + ', ' + (y5 * 1.2) + ')';
                            } else if (i === 3) {
                                return 'translate(' + (x5 - 40) + ', ' + y5 + ')';
                            } else if (i === 5) {
                                return 'translate(' + (x5 + 40) + ', ' + y5 + ')';
                            }
                            return 'translate(' + x5 + ', ' + y5 + ')';
                        })
                        .attr('text-anchor', 'middle')
                        .style("font-size", "16px")
                        .attr("stroke", "blue")
                        .text(function (d) {
                            var percent = Number(d.value) / d3.sum(dataset, function (d) {
                                return d[1];
                            }) * 100;
                            return d.data[0] + ' ' + percent.toFixed(1) + '%';
                        })

                    arcs.append('line')
                        .attr('stroke', 'black')
                        .attr('x1', function (d) { return arc.centroid(d)[0] * 2; })
                        .attr('y1', function (d) { return arc.centroid(d)[1] * 2; })
                        .attr('x2', function (d, i) {
                            if (i === 4) {
                                return arc.centroid(d)[0] * 3.2;
                            }
                            return arc.centroid(d)[0] * 2.5;
                        })
                        .attr('y2', function (d, i) {
                            if (i === 4) {
                                return arc.centroid(d)[1] * 3.2;
                            }
                            return arc.centroid(d)[1] * 2.5;
                        });
                });
//
            </script>
        </div>




    </form>
</asp:Content>
