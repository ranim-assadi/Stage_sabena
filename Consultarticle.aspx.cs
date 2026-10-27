using System;
using System.Data;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class Consultarticle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadArticles();
            }
        }

        // ================= LOAD =================
        private void LoadArticles()
        {
            try
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

                if (profil != "RESPONSABLE")
                {
                    Response.Redirect("forbidden.aspx");
                    return;
                }

                string sql = @"
                    SELECT 
                        ARTICLE.ID,
                        Utilisateur.PRENOM  + '   ' + Utilisateur.NOM  as name,
                        ARTICLE.DesignationARTICLE,
                        ARTICLE.QTE,
                        ARTICLE.Prixunitaire,
                        ARTICLE.Fournisseur,
                        ARTICLE.Stockmin,
                        ARTICLE.Stockmax,
                        ARTICLE.dateentrer
                    FROM ARTICLE
                    INNER JOIN Utilisateur 
                        ON ARTICLE.IDmagasinier = Utilisateur.ID
                    ORDER BY ARTICLE.ID DESC";

                DataSet ds = DALARTICLE.GetData(sql);

                if (ds == null || ds.Tables.Count == 0)
                {
                    gv.DataSource = null;
                    gv.DataBind();
                    return;
                }

                gv.DataSource = ds.Tables[0];
                gv.DataBind();

                if (gv.Columns.Count > 0)
                    gv.Columns[0].Visible = false;
            }
            catch (Exception ex)
            {
                Response.Write("Erreur load: " + ex.Message);
            }
        }

        // ================= COLORATION STOCK MIN =================
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DataRowView drv = (DataRowView)e.Row.DataItem;

                    int qte = Convert.ToInt32(drv["QTE"]);
                    int stockMin = Convert.ToInt32(drv["Stockmin"]);

                    // ===== COLOR RULE =====
                    if (qte <= stockMin)
                    {
                        e.Row.BackColor = Color.LightPink;   // fond rouge clair
                        e.Row.ForeColor = Color.DarkRed;     // texte rouge
                        e.Row.Font.Bold = true;
                    }
                }
            }
            catch
            {
                // ignore errors row safe
            }
        }

        // ================= COMMANDS =================
        public void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["uni"] == null)
            {
                Response.Redirect("default.aspx");
                return;
            }

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gv.Rows[index];
            int id = Convert.ToInt32(row.Cells[0].Text);

            try
            {
                if (e.CommandName == "Supprimer")
                {
                    DALARTICLE.Delete(id);
                    LoadArticles();
                }

                if (e.CommandName == "modifier")
                {
                    Response.Redirect("modifarticle.aspx?id=" + id);
                }
            }
            catch (Exception)
            {
                // ===== FK ERROR HANDLING =====
                Response.Write("<script>alert('Impossible de supprimer: article utilisé dans le stock ou mouvements');</script>");
            }
        }
    }
}