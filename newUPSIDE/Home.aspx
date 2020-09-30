  <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="newUPSIDE.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
         .bg1{
             
             position:fixed;

                top: 0;

                left: 0;

                width:100%;

                height:100%;

                min-width: 1000px;

                z-index:-10;

                zoom: 1;

                background-color: #fff;

                background: url(Image/back.jpg);

                background-repeat: no-repeat;

                background-size: cover;                            

            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
   
        
  <div class="container" style="max-height:300px">
    <h1 class="display-4" style="color: #FFFFFF; position: fixed; left: 106px; top: 206px; font-weight: bold;text-align: center;">UPSIDE</h1>
    <p class="lead"style="color: #FFFFFF; position: fixed; left: 50px; top: 280px; right:50px; font-weight: lighter;">The Unity Portal / Interface for Data and Experiments will be a web application that provide a platform for researchers to do their experiments on the web page by unity program.  Researcher can select what data they want from the experiment before the experiment start, the unity program will form the data and web server will visualize the data for user to read the result. The researcher can also look up the history experiments data for their summary and comparison. Online experiment platform will give the researchers a chance to promote their experiments for more people and data visualizing will let researchers have different perspectives to analyse the results of their experiments.</p>   
  </div>
    <div class="bg1">
        
        </div>
        
</asp:Content>
