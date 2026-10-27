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
    public partial class DA_DETAIL : System.Web.UI.Page
    {
        protected int idDA = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out idDA))
            {
                Response.Redirect("DA_HISTORIQUE.aspx");
                return;
            }

            bool adminMode = Request.QueryString["admin"] == "1";

            if (!IsPostBack)
            {
                ChargerEntete();
                ChargerDetail();
                if (lblStatut.Text!="En attente") {
                    btnDelete.Visible = false;
                }
            }

                pnlDelete.Visible = DemandeEnAttente();
         
        
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

                // La colonne Action est la 9ème colonne, index 8.
                // On l'affiche seulement si la demande est encore en attente.
                if (gvDetail.Columns.Count > 8)
                {
                    gvDetail.Columns[8].Visible = DemandeEnAttente();
                }
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





        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (!DemandeEnAttente())
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "suppr",
                    "alert('Suppression impossible : la demande est déjà validée ou refusée.');",
                    true);

                return;
            }

            try
            {
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    if (conn.State != ConnectionState.Open)
                        conn.Open();

                    // 1) Supprimer les détails d'abord
                    SqlCeCommand cmdDetail = new SqlCeCommand(
                        "DELETE FROM DA_DETAIL WHERE IDDA=@id", conn);
                    cmdDetail.Parameters.AddWithValue("@id", idDA);
                    cmdDetail.ExecuteNonQuery();

                    // 2) Supprimer la DA
                    SqlCeCommand cmdDA = new SqlCeCommand(
                        "DELETE FROM DA WHERE IDDA=@id", conn);
                    cmdDA.Parameters.AddWithValue("@id", idDA);
                    cmdDA.ExecuteNonQuery();
                }

                // Redirection après suppression
                Response.Redirect("DA_HISTORIQUE.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "err",
                    "alert('Erreur suppression : " + ex.Message.Replace("'", " ") + "');",
                    true);
            }
        }
        private bool DemandeEnAttente()
        {
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeCommand cmd = new SqlCeCommand(
                    "SELECT Statut FROM DA WHERE IDDA=@id",
                    conn);

                cmd.Parameters.AddWithValue("@id", idDA);

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                    return false;

                return result.ToString().Trim().ToLower() == "en attente";
            }
        }

        protected void gvDetail_RowEditing(object sender, GridViewEditEventArgs e)
        {
            if (!DemandeEnAttente())
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "modif",
                    "alert('Modification impossible : la demande est déjà validée ou refusée.');",
                    true);

                return;
            }

            gvDetail.EditIndex = e.NewEditIndex;
            ChargerDetail();
        }

        protected void gvDetail_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDetail.EditIndex = -1;
            ChargerDetail();
        }

        protected void gvDetail_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (!DemandeEnAttente())
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "modif2",
                    "alert('Modification impossible : la demande est déjà validée ou refusée.');",
                    true);

                return;
            }

            object articleID = gvDetail.DataKeys[e.RowIndex].Value;

            GridViewRow row = gvDetail.Rows[e.RowIndex];

            TextBox txtQTE = (TextBox)row.FindControl("txtQTE");

            decimal nouvelleQTE;

            if (!decimal.TryParse(
                txtQTE.Text.Trim().Replace(",", "."),
                NumberStyles.Any,
                CultureInfo.InvariantCulture,
                out nouvelleQTE))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "qte",
                    "alert('Quantité invalide');",
                    true);

                return;
            }

            if (nouvelleQTE <= 0)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "qte2",
                    "alert('La quantité doit être supérieure à zéro');",
                    true);

                return;
            }

            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();

                SqlCeCommand cmdPrix = new SqlCeCommand(
                    "SELECT PrixUnitaire FROM DA_DETAIL WHERE IDDA=@idDA AND ArticleID=@articleID",
                    conn);

                cmdPrix.Parameters.AddWithValue("@idDA", idDA);
                cmdPrix.Parameters.AddWithValue("@articleID", articleID);

                object prixObj = cmdPrix.ExecuteScalar();

                if (prixObj == null || prixObj == DBNull.Value)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "prix",
                        "alert('Prix unitaire introuvable');",
                        true);

                    return;
                }

                decimal prixUnitaire = Convert.ToDecimal(prixObj);

                decimal nouveauPrixTotal = nouvelleQTE * prixUnitaire;

                SqlCeCommand cmdUpdate = new SqlCeCommand(
                    "UPDATE DA_DETAIL SET QTE=@qte, PrixTotal=@prixTotal WHERE IDDA=@idDA AND ArticleID=@articleID",
                    conn);

                cmdUpdate.Parameters.AddWithValue("@qte", nouvelleQTE);
                cmdUpdate.Parameters.AddWithValue("@prixTotal", nouveauPrixTotal);
                cmdUpdate.Parameters.AddWithValue("@idDA", idDA);
                cmdUpdate.Parameters.AddWithValue("@articleID", articleID);

                cmdUpdate.ExecuteNonQuery();

                SqlCeCommand cmdTotal = new SqlCeCommand(
                    "SELECT SUM(PrixTotal) FROM DA_DETAIL WHERE IDDA=@idDA",
                    conn);

                cmdTotal.Parameters.AddWithValue("@idDA", idDA);

                object totalObj = cmdTotal.ExecuteScalar();

                decimal totalDA = 0;

                if (totalObj != null && totalObj != DBNull.Value)
                    totalDA = Convert.ToDecimal(totalObj);

                SqlCeCommand cmdUpdateDA = new SqlCeCommand(
                    "UPDATE DA SET Total=@total WHERE IDDA=@idDA",
                    conn);

                cmdUpdateDA.Parameters.AddWithValue("@total", totalDA);
                cmdUpdateDA.Parameters.AddWithValue("@idDA", idDA);

                cmdUpdateDA.ExecuteNonQuery();
            }

            gvDetail.EditIndex = -1;

            ChargerEntete();
            ChargerDetail();

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "ok",
                "alert('Quantité modifiée avec succès');",
                true);
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

                // Recharger pour refléter le nouveau statut
                ChargerEntete();
                ChargerDetail();

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "ok",
                    "alert('Demande " + statut.ToLower() + " avec succès.');",
                    true);
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