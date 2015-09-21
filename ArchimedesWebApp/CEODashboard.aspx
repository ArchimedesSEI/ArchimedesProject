<%@ Page Title="" Language="C#" MasterPageFile="~/Archimedes.Master" AutoEventWireup="true" CodeBehind="CEODashboard.aspx.cs" Inherits="ArchimedesWebApp.CEODashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>CEO Dashboard</h1>
    <asp:GridView ID="gvTeams" runat="server"
        AutoGenerateColumns="false"
        DataSourceID="dsTeams">
        <Columns>
            <asp:TemplateField HeaderText="Team Name">
                <ItemTemplate>
                    <asp:LinkButton ID="btnTeamName" runat="server"
                        Text='<%# Eval("team_name") %>'
                        CommandArgument='<%# Eval("team_key") + ";" + Eval("team_name") %>'
                        OnCommand="btnTeamName_Command" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Time Logged">  
                <ItemTemplate>              
                    <asp:Label ID="lblTotalTime" runat="server"
                        Text='<%# Eval("time_logged") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="dsTeams" runat="server"
        ConnectionString="Data Source=csdb;Initial Catalog=SEI_Archimedes;Integrated Security=True"
        ProviderName="System.Data.SqlClient"
        SelectCommand="
            SELECT Teams.team_key, Teams.team_name, ISNULL(SUM([ENTRY].entry_total_time), 0) AS time_logged
            FROM SEI_Archimedes.dbo.Teams
	                LEFT OUTER JOIN SEI_Archimedes.dbo.Team_Linking ON (Teams.team_key = Team_Linking.team_key)
	                LEFT OUTER JOIN SEI_TimeMachine2.dbo.[USER] team_user ON (Team_Linking.[user_id] = team_user.[user_id])
	                LEFT OUTER JOIN SEI_TimeMachine2.dbo.[ENTRY] ON ([ENTRY].entry_user_id = team_user.[user_id])
            WHERE Teams.active = 'Y'
            GROUP BY Teams.team_key, Teams.team_name;"></asp:SqlDataSource>
</asp:Content>
