using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class Default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string cin = user_txt.Text;
            string pwd = pwd_txt.Text;


            if (DALUTILISATEUR.Selectuser(cin, pwd) == null)
            {

                errorr.Visible = true;
                errorr.Text = "Veuillez vérifier votre login ou mot de passe";
                user_txt.Text = "";
                pwd_txt.Text = "";

            }
            else
                if (DALUTILISATEUR.Selectuservalid(cin, pwd) == null)
                {

                    {
                        errorr.Text = "Ce compte est en cours de Validation !";

                        string javaScript = "<script language=JavaScript>" + "msr();" + "</script>";
                        RegisterStartupScript("Button1_ClickScript", javaScript);
                    }
                }
                else
                    if (DALEnseignant.Selectprofil(cin,pwd) == "ADMIN")
                    {
                        errorr.Text = DALUTILISATEUR.Selectuser(cin, pwd);
                        Session["uni"] = user_txt.Text;
                        Session["pwd"] = pwd_txt.Text;
                        Response.Redirect("DA_VALIDATION.aspx");
                    }
                    else if (DALEnseignant.Selectprofil(cin, pwd) == "SUPER ADMIN")
                    {
                        errorr.Text = DALUTILISATEUR.Selectuser(cin, pwd);
                        Session["uni"] = user_txt.Text;
                        Session["pwd"] = pwd_txt.Text;
                        Response.Redirect("admincompte.aspx");
                    
                    }
                    else if (DALEnseignant.Selectprofil(cin, pwd) == "RESPONSABLE")
                    {
                        errorr.Text = DALUTILISATEUR.Selectuser(cin, pwd);
                        Session["uni"] = user_txt.Text;
                        Session["pwd"] = pwd_txt.Text;
                        Response.Redirect("listeMouvement.aspx");

                    }
                    else if (DALEnseignant.Selectprofil(cin, pwd) == "Magasin")
                    {
                        errorr.Text = DALUTILISATEUR.Selectuser(cin, pwd);
                        Session["uni"] = user_txt.Text;
                        Session["pwd"] = pwd_txt.Text;
                        Response.Redirect("listeMouvement.aspx");

                    }
                    else
                    {

                        errorr.Text = DALUTILISATEUR.Selectuser(cin, pwd);
                        Session["uni"] = user_txt.Text;
                        Session["pwd"] = pwd_txt.Text;
                        Response.Redirect("ajoutdb.aspx");

                    }

        }
  
        
    }
}