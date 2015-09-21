<%@ Page Title="" Language="C#" MasterPageFile="~/Archimedes.Master" AutoEventWireup="true" CodeBehind="TeamDashboard.aspx.cs" Inherits="ArchimedesWebApp.TeamDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Team Dashboard</h1>
    <div class="team_block">
        <h2 class="team_name"><asp:Label ID="lblTeamName" runat="server" /></h2>
        <asp:GridView ID="gvTeamMembers" runat="server"
            AutoGenerateColumns="false"
            DataSourceID="dsTeamMembers">
            <Columns>
                <asp:TemplateField HeaderText="Member ID">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnID" runat="server"
                            Text='<%# Eval("user_id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Full Name">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnFullName" runat="server"
                            Text='<%# Eval("user_fullname") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Time Logged">
                    <ItemTemplate>
                        <asp:Label ID="lblTotalTime" runat="server"
                            Text='<%# Eval("user_total_time") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsTeamMembers" runat="server"
            ConnectionString='<%$ ConnectionStrings:SEI_ArchimedesConnectionString %>'
            SelectCommand="
                SELECT team_user.[user_id], team_user.user_last_name + ', ' + team_user.user_first_name AS user_fullname, SUM(log_entry.entry_total_time) AS user_total_time
                FROM SEI_Archimedes.dbo.Team_Linking
	                 LEFT OUTER JOIN SEI_TimeMachine2.dbo.[USER] team_user ON (team_user.[user_id] = Team_Linking.[user_id])
	                 LEFT OUTER JOIN SEI_TimeMachine2.dbo.[ENTRY] log_entry ON (team_user.[user_id] = log_entry.entry_user_id)
                WHERE Team_Linking.team_key = @team_key
                GROUP BY team_user.[user_id], team_user.user_last_name, team_user.user_first_name
                ORDER BY team_user.user_last_name;">
            <SelectParameters>
                <asp:SessionParameter Name="team_key" SessionField="TeamKey" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <div>
        <h3>Assign Users to Teams</h3>
        <asp:DropDownList ID="ddlUsers" runat="server"
            DataSourceID="dsUsers"
            DataTextField="user_fullname"
            DataValueField="user_id" />
        <asp:Button ID="btnAssignToTeam" runat="server"
            Text="Assign"
            OnClick="btnAssignToTeam_Click" />

        <asp:SqlDataSource ID="dsUsers" runat="server"
            ConnectionString='<%$ ConnectionStrings:SEI_ArchimedesConnectionString %>'
            SelectCommand="
                SELECT user_last_name + ', ' + user_first_name AS user_fullname, [user_id]
                FROM SEI_TimeMachine2.dbo.[USER]
                WHERE user_is_enabled = 1
                  AND [user_id] NOT IN (
                        SELECT DISTINCT [user_id]
                          FROM SEI_Archimedes.dbo.Team_Linking)
                ORDER BY user_fullname;"
            InsertCommand="
                INSERT INTO SEI_Archimedes.dbo.Team_Linking (
	                team_key, [user_id]
                ) VALUES (
	                @team_key, @user_id
                );">
            <InsertParameters>
                <asp:ControlParameter Name="user_id" ControlID="ddlUsers" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="team_key" SessionField="TeamKey" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
