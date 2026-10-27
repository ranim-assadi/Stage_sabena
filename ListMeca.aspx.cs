using System;
using System.Data;
using System.Data.SqlServerCe;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;

namespace sabena
{
    public partial class ListMeca : System.Web.UI.Page
    {
        // =====================================================
        // PAGE LOAD
        // =====================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Vérification session
                if (Session["uni"] == null || Session["pwd"] == null)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                SetPageTitle();
                LoadMecaniciens();
            }
        }

        // =====================================================
        // TITRE PAGE
        // =====================================================
        private void SetPageTitle()
        {
            Label mpLabel =
                (Label)Page.Master.FindControl("PAGETXT");

            if (mpLabel != null)
            {
                mpLabel.Text = "Liste des Mécaniciens";
            }
        }

        // =====================================================
        // LOAD GRIDVIEW
        // =====================================================
        private void LoadMecaniciens()
        {
            try
            {
                string query =
                    "SELECT Stampnum, nom, prenom, stampurl AS ImgPath " +
                    "FROM mecanicien " +
                    "WHERE type = 1 " +
                    "ORDER BY nom ASC";

                DataSet ds = DALARTICLE.GetData(query);

                if (ds.Tables.Count > 0)
                {
                    gv.DataSource = ds;
                    gv.DataBind();

                    string profil =
                        DALEnseignant.Selectprofil(
                            Session["uni"].ToString(),
                            Session["pwd"].ToString());

                    // Gestion visibilité colonnes
                    if (profil != "RESPONSABLE")
                    {
                        if (gv.Columns.Count > 3)
                        {
                            gv.Columns[3].Visible = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Erreur chargement : " + ex.Message,
                    "red");
            }
        }

        // =====================================================
        // EXPORT EXCEL
        // =====================================================
        protected void btnSearch_Click(
            object sender,
            EventArgs e)
        {
            try
            {
                string query =
                    "SELECT Stampnum, nom, prenom " +
                    "FROM mecanicien " +
                    "WHERE type = 1 " +
                    "ORDER BY nom ASC";

                using (SqlCeConnection con =
                    DBConnection.GetConnection())
                {
                    using (SqlCeCommand cmd =
                        new SqlCeCommand(query, con))
                    {
                        SqlCeDataAdapter da =
                            new SqlCeDataAdapter(cmd);

                        DataTable dt = new DataTable();

                        con.Open();
                        da.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            ShowMessage(
                                "Aucune donnée trouvée",
                                "orange");

                            return;
                        }

                        using (ExcelPackage excel =
                            new ExcelPackage())
                        {
                            ExcelWorksheet ws =
                                excel.Workbook.Worksheets.Add(
                                    "Liste Mécaniciens");

                            // ================= HEADER =================

                            ws.Cells[1, 1].Value = "Stamp";
                            ws.Cells[1, 2].Value = "Prénom";
                            ws.Cells[1, 3].Value = "Nom";
                            ws.Cells[1, 4].Value = "Code Barre";

                            ws.Cells[1, 1, 1, 4]
                                .Style.Font.Bold = true;

                            // ================= DATA =================

                            int row = 2;

                            foreach (DataRow dr in dt.Rows)
                            {
                                string stamp =
                                    dr["Stampnum"].ToString();

                                ws.Cells[row, 1].Value = stamp;

                                ws.Cells[row, 2].Value =
                                    dr["prenom"].ToString();

                                ws.Cells[row, 3].Value =
                                    dr["nom"].ToString();

                                // Barcode
                                ws.Cells[row, 4].Value =
                                    "*" + stamp + "*";

                                ws.Cells[row, 4]
                                    .Style.Font.Name =
                                    "IDAutomationHC39M";

                                ws.Cells[row, 4]
                                    .Style.Font.Size = 12;

                                row++;
                            }

                            ws.Cells.AutoFitColumns();

                            // ================= DOWNLOAD =================

                            Response.Clear();
                            Response.Buffer = true;

                            Response.ContentType =
                                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                            Response.AddHeader(
                                "content-disposition",
                                "attachment; filename=ListeMecaniciens.xlsx");

                            Response.BinaryWrite(
                                excel.GetAsByteArray());

                            Response.Flush();
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Erreur export Excel : " + ex.Message,
                    "red");
            }
        }

        // =====================================================
        // GRIDVIEW COMMAND
        // =====================================================
        protected void GridView1_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            try
            {
                if (Session["uni"] == null)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                int index =
                    Convert.ToInt32(e.CommandArgument);

                GridViewRow row = gv.Rows[index];

                string stamp =
                    row.Cells[0].Text.Trim();

                long id =
                    Convert.ToInt64(stamp);

                // ================= DELETE =================
                if (e.CommandName == "Supprimer")
                {
                    DALMECANICIEN.Delete(
                        Convert.ToInt32(id));

                    Response.Redirect("ListMeca.aspx");
                }

                // ================= UPDATE =================
                else if (e.CommandName == "modifier")
                {
                    Response.Redirect(
                        "modifMeca.aspx?Usemode=Update&id="
                        + id);
                }

                // ================= PRINT =================
                else if (e.CommandName == "Sortie")
                {
                    Response.Redirect(
                        "printmeca.aspx?Usemode=detail&id="
                        + id);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Erreur : " + ex.Message,
                    "red");
            }
        }

        // =====================================================
        // MESSAGE
        // =====================================================
        private void ShowMessage(
            string msg,
            string color)
        {
            Label1.Text = msg;

            Label1.Attributes["style"] =
                "color:" + color +
                ";font-weight:bold;";
        }

        // =====================================================
        // BUTTONS
        // =====================================================
        protected void LinkButton1_Click(
            object sender,
            EventArgs e)
        {

        }

        protected void LinkButton2_Click(
            object sender,
            EventArgs e)
        {
            if (gv.Columns.Count > 1)
            {
                gv.Columns[1].Visible = true;
            }
        }

        protected void editbt(
            object sender,
            EventArgs e)
        {

        }
    }
}