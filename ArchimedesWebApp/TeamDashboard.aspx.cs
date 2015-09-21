using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArchimedesWebApp
{
    public partial class TeamDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblTeamName.Text = Session["TeamName"].ToString();
        }

        protected void btnAssignToTeam_Click(Object sender, EventArgs e)
        {
            dsUsers.Insert();
            gvTeamMembers.DataBind();
        }
    }
}