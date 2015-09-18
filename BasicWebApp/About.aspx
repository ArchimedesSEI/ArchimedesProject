<%@ Page Title="CEO Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="BasicWebApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 
<form method="post" action="">
    <h2><%: Title %>.</h2>
Login:<br> 
<input type="text" name="Login" value=""><br>
Password:<br>
<input type="text" name="Password" value=""><br><br>
<input type="submit" value="Submit" class="submit">
 
<asp:GridView ID="gvTeams" runat="server"
    DataSourceID="dsTeams">
    
</asp:GridView>

<asp:SqlDataSource ID="dsTeams" runat="server"
    SelectCommand="
        SELECT project_id, project_name, project_description
          FROM SEI_TimeMachine2.dbo.project;">
</asp:SqlDataSource>
    
 </asp:Content>



