using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArchimedesWebApp
{
    public partial class CEODashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnTeamName_Command(Object sender, CommandEventArgs e)
        {
            String[] args = new String[2];
            args = e.CommandArgument.ToString().Split(';');
            Session["TeamKey"] = args[0];
            Session["TeamName"] = args[1];

            Response.Redirect("~/TeamDashboard.aspx");
        }
    }
}