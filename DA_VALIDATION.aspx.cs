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
    public partial class DA_VALIDATION : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uni"] == null || Session["pwd"] == null)
            {
                Response.Redirect("default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ChargerDemandesEnAttente();
            }
        }
        private void ChargerDemandesEnAttente()
        {
            string str1 = "SELECT IDDA, NumeroDA, DateDA, Demandeur, Service, Statut, Total " +
                          "FROM DA " +
                          "WHERE Statut = 'en attente' " +
                          "ORDER BY IDDA DESC";

            DataSet ds = DALDB.GetData(str1);

            if (ds.Tables.Count > 0)
            {
                gv.DataSource = ds;
                gv.DataBind();
            }
        }


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            gv.Columns[1].Visible = true;
        }
        public string etatimage(object objOnSale)
        {
            string ledgreen = "~/image/chekgren.png";
            string ledyellow = "~/image/chekyellow.png";
            string ledorange = "~/image/chekorang.png";

            string etat = Convert.ToString(objOnSale);

            if (etat == "VR")
            {
                return ledorange;
            }

            else if (etat == "VU")
            {
                return ledyellow;
            }
            else { return ledgreen; }

        }
        public void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "valider")
            {
                int idDA = Convert.ToInt32(e.CommandArgument);
                ModifierStatutDA(idDA, "validée");
                ChargerDemandesEnAttente();
            }
            else if (e.CommandName == "refuser")
            {
                int idDA = Convert.ToInt32(e.CommandArgument);
                ModifierStatutDA(idDA, "refusée");
                ChargerDemandesEnAttente();
            }
        }


        private void ModifierStatutDA(int idDA, string statut)
        {
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeCommand cmd = new SqlCeCommand(
                    "UPDATE DA SET Statut=@statut WHERE IDDA=@id",
                    conn);

                cmd.Parameters.AddWithValue("@statut", statut);
                cmd.Parameters.AddWithValue("@id", idDA);

                cmd.ExecuteNonQuery();
            }
        }
    }
}