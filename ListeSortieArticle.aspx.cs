using System;
using System.Data;
using System.IO;
using OfficeOpenXml;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class ListeSortieArticle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadArticles();
                LoadGrid();
            }
        }

        // ================= LOAD ARTICLES =================
        private void LoadArticles()
        {
            DataTable dt = DALARTICLE.GetDatat(
             "SELECT  ID, DesignationARTICLE FROM ARTICLE ORDER BY DesignationARTICLE"
            );

            ddlArticle.DataSource = dt;
            ddlArticle.DataTextField = "DesignationARTICLE";
            ddlArticle.DataValueField = "ID";
            ddlArticle.DataBind();

            ddlArticle.Items.Insert(0, new ListItem("Tous", "0"));
        }

        // ================= LOAD GRID =================
        private void LoadGrid()
        {
            DataSet ds = DALDB.GetData(BuildQuery());

            if (ds == null || ds.Tables.Count == 0)
            {
                gvSortie.DataSource = null;
                gvSortie.DataBind();
                return;
            }

            gvSortie.DataSource = ds.Tables[0];
            gvSortie.DataBind();
        }

        // ================= FILTER BUTTON =================
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadGrid();
        }

        // ================= EXPORT EXCEL =================
        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataSet ds = DALDB.GetData(BuildQuery());

            if (ds == null || ds.Tables.Count == 0)
                return;

            DataTable dt = ds.Tables[0];

            using (ExcelPackage excel = new ExcelPackage())
            {
                ExcelWorksheet ws =
                    excel.Workbook.Worksheets.Add("SortieArticles");

                ws.Cells["A1"].LoadFromDataTable(dt, true);

                ws.Cells[ws.Dimension.Address].AutoFitColumns();

                using (MemoryStream ms = new MemoryStream())
                {
                    Response.Clear();
                    Response.ContentType =
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                    Response.AddHeader(
                        "content-disposition",
                        "attachment; filename=SortieArticles.xlsx"
                    );

                    excel.SaveAs(ms);

                    ms.WriteTo(Response.OutputStream);

                    Response.Flush();
                    Response.End();
                }
            }
        }

        // ================= SQL QUERY =================
        private string BuildQuery()
        {
            string sql = @"
SELECT
    M.ID,

    A.DesignationARTICLE AS Article,

    M.Quantite,

    U.NOM + ' ' + U.PRENOM AS Demandeur,

    AC.Designation AS Avion,
M.NumDB,

  CONVERT(nvarchar, M.DateMouvement, 103) + ' ' + CONVERT(nvarchar, M.DateMouvement, 108) AS DateMouvement

FROM Mouvconso M

INNER JOIN ARTICLE A
    ON A.ID = M.IDarticle

INNER JOIN AC
    ON M.Avion = AC.MSN

INNER JOIN mecanicien U
    ON M.Demandeur = U.Stampnum

WHERE 1=1";

            // DATE
            if (!string.IsNullOrWhiteSpace(txtDateDebut.Text) &&
                !string.IsNullOrWhiteSpace(txtDateFin.Text))
            {
                sql += " AND CONVERT(nvarchar, M.DateMouvement, 23) >= '"
                       + txtDateDebut.Text + "'";

                sql += " AND CONVERT(nvarchar, M.DateMouvement, 23) <= '"
                       + txtDateFin.Text + "'";
            }

            // ARTICLE
            if (ddlArticle.SelectedValue != "0")
            {
                sql += " AND A.ID = " + ddlArticle.SelectedValue;
            }

            // DEMANDEUR
            if (!string.IsNullOrWhiteSpace(HF_DEMANDEUR_ID.Value))
            {
                sql += " AND U.Stampnum = " + HF_DEMANDEUR_ID.Value;
            }

            // AVION
            if (!string.IsNullOrWhiteSpace(txtAvion.Text))
            {
                sql += " AND AC.Designation LIKE '%"
                       + txtAvion.Text + "%'";
            }
            sql += " ORDER BY M.ID DESC";

            return sql;
        }
    }
}