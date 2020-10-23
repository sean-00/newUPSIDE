<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExperimentAttributeConfiger.aspx.cs" Inherits="newUPSIDE.ExperimentAttributeConfiger" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <form id="form1" runat="server">
               
        <asp:Label ID="Label4" runat="server" Text="Input Experiment Name:" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="30px" Width="100%"></asp:Label>
        <asp:TextBox ID="ConfigerName" runat="server" BorderWidth="1px" Width="100%" AutoComplete="off"></asp:TextBox>
        <asp:Label ID="Label1" runat="server" Text="Input Experiment Description:" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="30px" Width="100%"></asp:Label>
        <asp:TextBox ID="ConfigerDescription" runat="server" AutoComplete="off" Width="100%" TextMode="MultiLine" BorderColor="Black" BorderWidth="1px" Height="200px"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="Input Header Number:" BackColor="#66CCFF" Font-Bold="True" ForeColor="Black" Height="30px" Width="100%"></asp:Label>
        
      
        <asp:PlaceHolder ID="PlaceHolderLoadTextBox" runat="server"></asp:PlaceHolder>
                 <asp:TextBox ID="ConfigerHeaderNumber" runat="server" AutoComplete="off" Width="79%" OnKeyPress="if(((event.keyCode>=48)&&(event.keyCode <=57))||(event.keyCode==46)) {event.returnValue=true;} else{event.returnValue=false;}" MaxLength="15" BorderWidth="1px"></asp:TextBox>  
        <asp:Button ID="ConfigerHeaderButton" Text="Add Header Column" runat="server" OnClick="ConfigerHeaderButton_Click" Width="20.6%" BorderWidth="2px" BorderColor="#00CCFF" /><br />
     

        
        <asp:Button  runat="server" OnClick="Submit_Click" Text="Submit to Json File" Width="100%" BorderColor="#00CCFF" BorderWidth="2px"/>
        <asp:FileUpload ID="MyFileUpload" runat="server" BorderWidth="1px" Width="79%" /> 
        <asp:Button ID="FileUploadButton" runat="server" Text="Upload Json Experiment Data " onclick="FileUploadButton_Click" BorderWidth="2px"  Width="20.6%" BorderColor="#00CCFF"/>
         
        
    </form>

   




</asp:Content>
