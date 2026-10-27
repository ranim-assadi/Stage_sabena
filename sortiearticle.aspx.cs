
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlServerCe;
using System.IO;
using System.Web.Services;


namespace sabena
{
    public partial class sortiearticle : System.Web.UI.Page
    {
        //private ARTICLE GetDataFromInterface()
        //{
        //    try
        //    {

        //        ARTICLE a = new ARTICLE();

        //        a.DesignationAR = DESIGTXT.Text;

        //        a.PrixachatAR = PRIXTXT.Text;
        //        a.FournisseurAR = fournisseurTXT.Text;
        //        a.StockminAR = minTXT.Text;
        //        a.StockmaxAR = maxTXT.Text;
        //        a.DateentreAR = DateTime.Now.ToString("yyyy-MM-dd");
        //        a.qte = qtetxt.Text;
        //        a.IDmagasinier = DALUTILISATEUR.selectid(Session["uni"].ToString(), Session["pwd"].ToString()).ToString();


        //        return a;
        //    }
        //    catch (Exception ex)
        //    {

        //        Label1.Text = "Erreur de saisie! \n Verifier vos champs SVP!";
        //        Label1.Visible = true;
        //        return null;
        //    }
        //}
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    { 
        //        Label mpLabel = (Label)Page.Master.FindControl("PAGETXT");
        //        mpLabel.Text = "Modification d'un Article";
        //        try
        //        {

        //            if (this.Request.Params["id"] != null)
        //            {
        //                string str = " SELECT  ARTICLE.DesignationARTICLE, ARTICLE.Prixachat, ARTICLE.Fournisseur, ARTICLE.Stockmin, ARTICLE.stockmax, ARTICLE.dateentrer, ARTICLE.QTE FROM ARTICLE where ARTICLE.id=" +this.Request.Params["id"].ToString();


        //                SqlCeCommand cmd = new SqlCeCommand(str, DBConnection.GetConnection());

        //                cmd.Connection.Open();

        //                SqlCeDataReader dr = cmd.ExecuteReader();
        //                if (dr.Read())
        //                {
                        
        //                    DESIGTXT.Text = dr["DesignationARTICLE"].ToString();

        //                    PRIXTXT.Text = dr["Prixachat"].ToString();
        //                    fournisseurTXT.Text = dr["Fournisseur"].ToString();
        //                    minTXT.Text = dr["Stockmin"].ToString();
        //                    maxTXT.Text = dr["stockmax"].ToString();

        //                    qtetxt.Text = dr["QTE"].ToString();

        //                }
        //            }
        //        }
        //        catch
        //        { }
        //    }
        //}



        //protected void Buttonmodif_Click(object sender, EventArgs e)
        //{
                     
        //        int qtein = int.Parse(qtetxt.Text);
        //        int qtemax = int.Parse(maxTXT.Text);
        //        int qtemin = int.Parse(minTXT.Text);

        //        try
        //        {
        //            if (qtein >= qtemin && qtein <= qtemax)
        //            {
        //                DALARTICLE.Update(this.Request.Params["id"], this.GetDataFromInterface());


        //                this.Response.Redirect("consultarticle.aspx");
        //            }
        //            else
        //            {
        //                Label2.ForeColor = System.Drawing.Color.Orange;

        //                Label2.Text = "La Quantité entrée ne doit pas étre inferieur à la stock min ou superieure à la stock max ";
        //                Panel2.Visible = true;
        //            }
        //        }
        //        catch
        //        {
        //            Label1.ForeColor = System.Drawing.Color.Red;

        //            Label1.Text = "Vérifier Votre demande ! ";
        //            Label1.Visible = true;
        //            Panel1.Visible = true;

        //        }
         
     

        //}



    }
}