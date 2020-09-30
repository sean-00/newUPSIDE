   <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewExperimentData.aspx.cs" Inherits="newUPSIDE.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <form id="form1" runat="server">
        <asp:DropDownList ID="ExperimentNameSelected" runat="server" OnSelectedIndexChanged="ExperimentNameSelected_SelectedIndexChanged" ></asp:DropDownList>



        <asp:Button OnClick="GetJson_Click" Text="Get"  runat="server" />
        <asp:Label ID="Label1" runat="server" Text="Experiment Data" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
        <asp:Label ID="LabelTest" runat="server" Text=""></asp:Label>
        <asp:Table class="table table-bordered table-striped" id="ExperimentDataTable" runat="server">
            
        </asp:Table>
        <table class="table table-bordered table-striped" >
            <tr>
                <th>Round</th>
                <th>Success</th>
                <th>OverTime</th>
                <th>TimeUse</th>
            </tr>
        </table>
        <div id="box">
        </div>
    </form>
</asp:Content>
