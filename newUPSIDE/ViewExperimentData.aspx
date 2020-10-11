   <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="ViewExperimentData.aspx.cs" Inherits="newUPSIDE.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head"  runat="server">
    <script type="text/javascript" src="https://d3js.org/d3.v4.min.js"></script>
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
            <asp:ListItem Text="ITEM1"></asp:ListItem>
            <asp:ListItem Text="ITEM2"></asp:ListItem>
            <asp:ListItem Text="ITEM3"></asp:ListItem>
        </asp:DropDownList>
        


        <asp:Button OnClick="GetJson_Click" Text="Open Experiment"  runat="server" />
        <asp:Label ID="Label3" runat="server" Text="Experiment Description" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
       <asp:Label ID="Label4" runat="server" Text="The Unity Portal / Interface for Data and Experiments will be a web application that provide a platform for researchers to do their experiments on the web page by unity program.  Researcher can select what data they want from the experiment before the experiment start, the unity program will form the data and web server will visualize the data for user to read the result. The researcher can also look up the history experiments data for their summary and comparison. Online experiment platform will give the researchers a chance to promote their experiments for more people and data visualizing will let researchers have different perspectives to analyse the results of their experiments."  Width="100%"></asp:Label>
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
            <H2>Bar Chart</H2>
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
                    //.text("Round_Time bar chart");

                var x1 = d3.scaleBand().range([0, width]).padding(0.4),                         //
                    y1 = d3.scaleLinear().range([height, 0]);         //range([300,0])          //

                var g = svg4.append("g")
                    .attr("transform", "translate(" + 100 + "," + 100 + ")");

                //read json file for data
                //d3.json("..\File\testbar.json", function (error, data2) {             //how to use the file in File directory ?
                d3.json("testbar.json", function (error, data2) {

                    if (error) {
                        throw error;
                    }

                    data2.forEach(function (d) {
                        d.round = d.round;
                        d.timeuse = +d.timeuse;
                        console.log(d.round, d.timeuse);     
                    });

                    x1.domain(data2.map(function (d) { return d.round; }));                     //
                    y1.domain([0, d3.max(data2, function (d) { return d.timeuse; })]);          //


                    g.append("g")
                        .attr("transform", "translate(0," + height + ")")
                        .call(d3.axisBottom(x1))                                                //
                        .append("text")
                        .attr("y", height - 300)                        //height -250 below the axis(y)
                        .attr("x", width + 50)                         //width -100 @ mid
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
                        .call(d3.axisLeft(y1));                                         //

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
                            return x1(d.round);                                         //
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
                        .attr("y", function (d) { return y1(d.timeuse); })              //
                        .attr("height", function (d) { return height - y1(d.timeuse); });           //

                    d3.selectAll('.val')
                        .remove()
                }

            </script>
        </div>

        <div id="Second">
            <H2> Line Chart </H2>
            <svg width="480" height="250" id="svg3"></svg>
                <script>
                    // set the dimensions and margins of the graph
                    var margin3 = { top3: 20, right3: 50, bottom3: 30, left3: 50 },
                        width3 = 480 - margin3.left3 - margin3.right3,
                        height3 = 250 - margin3.top3 - margin3.bottom3;


                    // set the ranges
                    var x = d3.scaleLinear().range([0, width3]);    //OK
                    var y = d3.scaleLinear().range([height3, 0]);

                    // define the line
                    var valueline = d3.line()
                        .x(function (d) { return x(d.round); })
                        .y(function (d) { return y(d.timeuse); });


                    //var svg3 = d3.select("body").append("svg")
                    var svg3 = d3.select("#svg3").append("svg")
                        .attr("width", width3 + margin3.left3 + margin3.right3)
                        .attr("height", height3 + margin3.top3 + margin3.bottom3)
                        .append("g").attr("transform",
                            "translate(" + margin3.left3 + "," + margin3.top3 + ")");


                    // Get the data
                    d3.json("testbar.json", function (error, data) {
                        if (error) throw error;
                        // format the data
                        data.forEach(function (d) {
                            d.round = d.round;
                            d.timeuse = +d.timeuse;
                            console.log(d.round, d.timeuse);
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
                            //.attr("y", height3)       //  height -250  ????
                            .attr("x", width3 + 50)        // width - 100 @ mid
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


    </form>
</asp:Content>
