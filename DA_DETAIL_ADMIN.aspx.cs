using MyUtilities;
using System;
using System.Data;
using System.Data.SqlServerCe;
using System.IO;
using System.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class DA_DETAIL_ADMIN : System.Web.UI.Page
    {
        protected int idDA = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out idDA))
            {
                Response.Redirect("DA_HISTORIQUE.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ChargerEntete();
                ChargerDetail();
            }

            pnlValidation.Visible = DemandeEnAttente();

        }

        private void ChargerEntete()
        {
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeCommand cmd = new SqlCeCommand(
                    "SELECT * FROM DA WHERE IDDA=@id",
                    conn);

                cmd.Parameters.AddWithValue("@id", idDA);

                SqlCeDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblNumero.Text = dr["NumeroDA"].ToString();

                    lblDate.Text =
                        Convert.ToDateTime(dr["DateDA"])
                        .ToString("dd/MM/yyyy HH:mm");

                    lblDemandeur.Text = dr["Demandeur"].ToString();

                    lblService.Text = dr["Service"].ToString();

                    lblObservation.Text = dr["Observation"].ToString();

                    lblStatut.Text = dr["Statut"].ToString();
                    ViewState["StatutDA"] = dr["Statut"].ToString();

                    lblTotal.Text =
                        Convert.ToDecimal(dr["Total"])
                        .ToString("0.000") + " TND";

                    ViewState["FichierExcel"] =
                        dr["FichierExcel"].ToString();
                }

                dr.Close();
            }
        }

        private void ChargerDetail()
        {
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeDataAdapter da = new SqlCeDataAdapter(
                    "SELECT * FROM DA_DETAIL WHERE IDDA=@id",
                    conn);

                da.SelectCommand.Parameters.AddWithValue("@id", idDA);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvDetail.DataSource = dt;

                gvDetail.DataBind();

             
            }
        }

        private bool DemandeEnAttente()
        {
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeCommand cmd = new SqlCeCommand(
                    "SELECT Statut FROM DA WHERE IDDA=@id", conn);

                cmd.Parameters.AddWithValue("@id", idDA);

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                    return false;

                return result.ToString().Trim().ToLower() == "en attente";
            }
        }



        protected void btnDownload_Click1(object sender, EventArgs e)
        {
            try
            {
                string fichier = "";

                if (ViewState["FichierExcel"] != null)
                {
                    fichier = ViewState["FichierExcel"].ToString();
                }

                if (string.IsNullOrEmpty(fichier))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "a",
                        "alert('Aucun fichier disponible');",
                        true);

                    return;
                }

                string path = Server.MapPath("~/DA_FILES/" + fichier);

                if (File.Exists(path))
                {
                    Response.Clear();

                    Response.ContentType =
                        "application/vnd.ms-excel";

                    Response.AddHeader(
                        "content-disposition",
                        "attachment;filename=" + fichier);

                    Response.WriteFile(path);

                    Response.End();
                }
                else
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "a",
                        "alert('Fichier introuvable');",
                        true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "e",
                    "alert('Erreur : " +
                    ex.Message.Replace("'", " ") +
                    "');",
                    true);
            }
        }


        protected void btnValider_Click(object sender, EventArgs e)
        {
            ChangerStatut("Validée");
        }

        protected void btnRefuser_Click(object sender, EventArgs e)
        {
            ChangerStatut("Refusée");
        }

        private void ChangerStatut(string statut)
        {
            try
            {
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    if (conn.State != ConnectionState.Open)
                        conn.Open();

                    SqlCeCommand cmd = new SqlCeCommand(
                        "UPDATE DA SET Statut=@statut WHERE IDDA=@id", conn);

                    cmd.Parameters.AddWithValue("@statut", statut);
                    cmd.Parameters.AddWithValue("@id", idDA);
                    cmd.ExecuteNonQuery();
                }

                // Redirection directe vers la liste des demandes en attente
                Response.Redirect("DA_VALIDATION.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "err",
                    "alert('Erreur : " + ex.Message.Replace("'", " ") + "');",
                    true);
            }
        }

    }
}