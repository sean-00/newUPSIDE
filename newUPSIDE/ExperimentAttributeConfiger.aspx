<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExperimentAttributeConfiger.aspx.cs" Inherits="newUPSIDE.ExperimentAttributeConfiger" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <form id="form1" runat="server">
               
        <asp:Label ID="Label4" runat="server" Text="Input Experiment Name:" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="30px" Width="100%"></asp:Label>
        <asp:TextBox ID="ConfigerName" runat="server" BorderWidth="1px" Width="100%" AutoComplete="off"></asp:TextBox>
        <asp:Label ID="Label1" runat="server" Text="Input Experiment Description:" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="30px" Width="100%"></asp:Label>
        <asp:TextBox ID="ConfigerDescription" runat="server" AutoComplete="off" Width="100%" TextMode="MultiLine" BorderColor="Black" BorderWidth="1px" Height="200px"></asp:TextBox>        
        <asp:Button  runat="server" OnClick="Submit_Click" Text="Submit to Json File" Width="100%" BorderColor="#00CCFF" BorderWidth="2px"/>
        
    </form>
</asp:Content>
