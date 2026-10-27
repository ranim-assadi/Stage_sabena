using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class ADM : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uni"] == null || Session["pwd"] == null)
            {
                Response.Redirect("default.aspx");
                return;
            }

            string profil = DALEnseignant.Selectprofil(
                Session["uni"].ToString(),
                Session["pwd"].ToString()
            );

            if (profil != "RESPONSABLE" && profil != "ADMIN" && profil != "SUPER ADMIN")
            {
                Response.Redirect("default.aspx");
                return;
            }

            Label1.Text = DALEnseignant.Selectuser(
                Session["uni"].ToString(),
                Session["pwd"].ToString()
            );
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

        }
       
        protected void deconx(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("default.aspx");
        }

        protected void ajoutensei(object sender, EventArgs e)
        {
           
        }

        
      
    }
}