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
        <asp:Table ID="Label2" runat="server" Text="Experiment Name" Width="100%" Height="40px" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black"></asp:Table>
        <table width="30%">
            <tbody height="150px">

                <tr>
                    <td><a href="UPSIDE-Experiment://UnityExperiment.exe">Experiment11</a>
                    </td>
                </tr>
                <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
                <tr>
                    <td><a href="UPSIDE-Experiment://UnityExperiment.exe">Experiment12</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="UPSIDE-Experiment://UnityExperiment.exe">Experiment13</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="UPSIDE-Experiment://UnityExperiment.exe">Experiment14</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="链接">Experiment15</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="链接">Experiment16</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="链接">Experiment17</a>
                    </td>
                </tr>
                <tr>
                    <td><a href="链接">Experiment18</a>
                    </td>
                </tr>
            </tbody>

        </table>

        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />

        <asp:Label ID="Label1" runat="server" Text="Experiment Data" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="40px" Width="100%"></asp:Label>
        <asp:Label ID="LabelTest" runat="server" Text=""></asp:Label>
        <table class="table table-bordered table-striped" id="ExperimentDataTable">
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
