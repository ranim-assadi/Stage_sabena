using System;
using System.Data;
using System.Data.SqlServerCe;
using System.IO;
using System.Web.UI.WebControls;
using MyUtilities;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class DA_HISTORIQUE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerHistorique();
            }
        }

        private void ChargerHistorique()
        {
            try
            {
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    if (conn.State != ConnectionState.Open)
                        conn.Open();

                    string sql = "SELECT * FROM DA ORDER BY IDDA DESC";

                    SqlCeDataAdapter da = new SqlCeDataAdapter(sql, conn);

                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    gvDA.DataSource = dt;
                    gvDA.DataBind();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "err",
                    "alert('Erreur : " + ex.Message.Replace("'", " ") + "');",
                    true);
            }
        }

        protected void gvDA_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                // ============================
                // TELECHARGEMENT EXCEL
                // ============================

                if (e.CommandName == "download")
                {
                    string fichier = e.CommandArgument.ToString();

                    if (string.IsNullOrEmpty(fichier))
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "a",
                            "alert('Aucun fichier disponible');",
                            true);

                        return;
                    }

                    string chemin = Server.MapPath("~/DA_FILES/" + fichier);

                    if (File.Exists(chemin))
                    {
                        Response.Clear();

                        Response.ContentType = "application/vnd.ms-excel";

                        Response.AddHeader(
                            "content-disposition",
                            "attachment;filename=" + fichier);

                        Response.WriteFile(chemin);

                        Response.End();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "a",
                            "alert('Fichier introuvable sur le serveur');",
                            true);
                    }
                }

                // ============================
                // CONSULTATION DA
                // ============================

                if (e.CommandName == "voir")
                {
                    string id = e.CommandArgument.ToString();

                    Response.Redirect("DA_DETAIL.aspx?id=" + id);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "err",
                    "alert('Erreur : " + ex.Message.Replace("'", " ") + "');",
                    true);
            }
        }
    }
}