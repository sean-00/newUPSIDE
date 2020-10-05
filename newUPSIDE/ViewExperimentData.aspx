   <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="ViewExperimentData.aspx.cs" Inherits="newUPSIDE.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head"  runat="server">
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
    </form>
</asp:Content>
