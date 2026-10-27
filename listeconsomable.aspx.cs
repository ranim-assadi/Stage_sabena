using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlServerCe;
using System.Drawing;

namespace sabena
{
    public partial class listeconsomable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // string b = Session["uni"].ToString(); PN,SN,Designation,QTY,OE,date,demandeur 
             //string x=   DALUTILISATEUR.selectid(Session["uni"].ToString(), Session["pwd"].ToString()).ToString();
                string str1 = " SELECT Utilisateur.NOM+Utilisateur.PRENOM as name, ARTICLE.DesignationARTICLE, ARTICLE.Prixunitaire, ARTICLE.Fournisseur, ARTICLE.Stockmin, ARTICLE.stockmax, ARTICLE.dateentrer, ARTICLE.QTE, ARTICLE.ID FROM ARTICLE INNER JOIN Utilisateur ON ARTICLE.IDmagasinier = Utilisateur.ID order by ARTICLE.id desc";
                DataSet ds = DALARTICLE.GetData(str1);
                if (ds.Tables.Count > 0)
                {
                    gv.DataSource = ds;
                    gv.DataBind();
                   
                    gv.Columns[0].Visible = false;
                    gv.Columns[1].Visible = true;

                   
                }


            }


        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (int.Parse(e.Row.Cells[3].Text) <= int.Parse(e.Row.Cells[4].Text))
                {

                   // e.Row.BackColor = System.Drawing.Color.Red;
                    e.Row.ForeColor = System.Drawing.Color.Red;
                }
              
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            gv.Columns[1].Visible = true;
        }
      
        public void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["uni"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
               
                if (e.CommandName == "Supprimer")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gv.Rows[index];
                    string b = row.Cells[0].Text;
                   
                    Int64 aux = Int64.Parse(b);
                  

                        DALARTICLE.Delete(int.Parse(b));

                        this.Response.Redirect("Consultarticle.aspx");
                    
                }
              
                else  if (e.CommandName == "modifier")
                    {
                        int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gv.Rows[index];
                    string b = row.Cells[0].Text;
                    
                    Int64 aux = Int64.Parse(b);
                    this.Response.Redirect("sortie_article.aspx?Usemode=detail&id=" + aux);
                    
                    }

                
                else
                    if (e.CommandName == "Sortie")
                    {
                        int index = Convert.ToInt32(e.CommandArgument);
                        GridViewRow row = gv.Rows[index];
                        string b = row.Cells[0].Text;

                        Int64 aux = Int64.Parse(b);
                        this.Response.Redirect("sortie_article.aspx?Usemode=detail&id=" + aux);

                    }

            }


        }


        protected void editbt(object sender, EventArgs e)
        {
            //DALUSER.Update(aux.Text, this.GetDataFromInterfacedit());
            //DALdroit.Update(aux.Text, this.GetDataFromInterfaceprofiledit());
            //Response.Redirect("DroitAcces.aspx");
        }
  
    }
}