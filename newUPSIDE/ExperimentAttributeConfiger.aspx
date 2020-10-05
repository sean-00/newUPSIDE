<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExperimentAttributeConfiger.aspx.cs" Inherits="newUPSIDE.ExperimentAttributeConfiger" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <form id="form1" runat="server">
        <asp:Label ID="Label4" runat="server" Text="Input Experiment Name:" Height="20px" Width="100%"></asp:Label>

        <asp:TextBox runat="server"></asp:TextBox>

        <asp:Label ID="Label1" runat="server" Text="Input Experiment Description:" Height="20px" Width="100%"></asp:Label>
        <asp:TextBox runat="server" ID="description"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="Input new Experiment URL:" Height="20px" Width="100%"></asp:Label>

        <asp:TextBox runat="server"></asp:TextBox>
    </form>

   




</asp:Content>
