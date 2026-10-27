using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlServerCe;
using System.Globalization;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyUtilities;

namespace sabena
{
    public partial class DA_AUTO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) ChargerDonnees();
        }

        private void ChargerDonnees()
        {
            string sql = "SELECT ID, DesignationARTICLE, QTE, Stockmin, prixunitaire, Fournisseur " +
                         "FROM ARTICLE " +
                         "WHERE QTE <= Stockmin " +
                         "AND ID NOT IN ( " +
                         "    SELECT ArticleID FROM DA_DETAIL " +
                         "    INNER JOIN DA ON DA.IDDA = DA_DETAIL.IDDA " +
                         "    WHERE DA.Statut = 'En attente' " +
                         ")";

            DataTable dt = DALARTICLE.GetDatat(sql);
            gv.DataSource = dt;
            gv.DataBind();
        }

        protected void btnGenerer_Click(object sender, EventArgs e)
        {
            decimal totalGeneralDA = 0;
            DataTable dtSelection = new DataTable();
            dtSelection.Columns.Add("CODE");
            dtSelection.Columns.Add("DES");
            dtSelection.Columns.Add("QTE", typeof(int));
            dtSelection.Columns.Add("STK");
            dtSelection.Columns.Add("PU", typeof(decimal));
            dtSelection.Columns.Add("PT", typeof(decimal));

            try
            {
                foreach (GridViewRow row in gv.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                    if (chk != null && chk.Checked)
                    {
                        DataKey key = gv.DataKeys[row.RowIndex];
                        string code = key["ID"].ToString();

                        string des = "";
                        if (key["DesignationARTICLE"] != null) des = key["DesignationARTICLE"].ToString();

                        string stk = "0";
                        if (key["QTE"] != null) stk = key["QTE"].ToString();

                        decimal pu = ToDecimalSafe(key["prixunitaire"]);

                        TextBox txt = (TextBox)row.FindControl("txtQte");
                        int qte = 0;
                        if (!int.TryParse(txt.Text, out qte) || qte <= 0) qte = 1;

                        decimal pt = pu * qte;
                        totalGeneralDA += pt;
                        dtSelection.Rows.Add(code, des, qte, stk, pu, pt);
                    }
                }

                if (dtSelection.Rows.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "a",
                        "alert('Veuillez cocher au moins un article');", true);
                    return;
                }

                string demandeurNom = DALEnseignant.Selectuser(
                    Session["uni"].ToString(), Session["pwd"].ToString());
                string numDA = "DA-" + DateTime.Now.ToString("yyMMddHHmm");

                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    if (conn.State != ConnectionState.Open) conn.Open();

                    SqlCeCommand cmd = new SqlCeCommand(
                        "INSERT INTO DA (NumeroDA, DateDA, Demandeur, Service, Total, Statut) " +
                        "VALUES (@n, @d, @u, 'MAGASIN', @t, 'En attente')", conn);
                    cmd.Parameters.AddWithValue("@n", numDA);
                    cmd.Parameters.AddWithValue("@d", DateTime.Now);
                    cmd.Parameters.AddWithValue("@u", demandeurNom);
                    cmd.Parameters.AddWithValue("@t", totalGeneralDA);
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT @@IDENTITY";
                    int idDA = Convert.ToInt32(cmd.ExecuteScalar());

                    foreach (DataRow r in dtSelection.Rows)
                    {
                        SqlCeCommand cmdD = new SqlCeCommand(
                            "INSERT INTO DA_DETAIL (IDDA, ArticleID, DesignationARTICLE, QTE, PrixUnitaire, PrixTotal) " +
                            "VALUES (@id, @aid, @des, @q, @pu, @pt)", conn);
                        cmdD.Parameters.AddWithValue("@id", idDA);
                        cmdD.Parameters.AddWithValue("@aid", r["CODE"]);
                        cmdD.Parameters.AddWithValue("@des", r["DES"]);
                        cmdD.Parameters.AddWithValue("@q", r["QTE"]);
                        cmdD.Parameters.AddWithValue("@pu", r["PU"]);
                        cmdD.Parameters.AddWithValue("@pt", r["PT"]);
                        cmdD.ExecuteNonQuery();
                    }
                }

                ExporterExcelImageFormat(dtSelection, numDA, totalGeneralDA, demandeurNom);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "e",
                    "alert('Erreur: " + ex.Message.Replace("'", " ") + "');", true);
            }
        }

        private decimal ToDecimalSafe(object value)
        {
            if (value == null || value == DBNull.Value || string.IsNullOrEmpty(value.ToString()))
                return 0;
            string s = value.ToString().Replace(" ", "").Replace(",", ".");
            decimal result;
            if (decimal.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out result))
                return result;
            return 0;
        }

        private void ExporterExcelImageFormat(DataTable dt, string num, decimal total, string demandeur)
        {
            string logoUrl = Request.Url.GetLeftPart(UriPartial.Authority) +
                             ResolveUrl("~/image/sabenawhite.png");

            StringBuilder sb = new StringBuilder();

            sb.Append("<html xmlns:o='urn:schemas-microsoft-com:office:office' ");
            sb.Append("xmlns:x='urn:schemas-microsoft-com:office:excel' ");
            sb.Append("xmlns='http://www.w3.org/TR/REC-html40'>");

            sb.Append("<head>");
            sb.Append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");

            sb.Append("<!--[if gte mso 9]>");
            sb.Append("<xml>");
            sb.Append("<x:ExcelWorkbook>");
            sb.Append("<x:ExcelWorksheets>");
            sb.Append("<x:ExcelWorksheet>");
            sb.Append("<x:Name>DA</x:Name>");
            sb.Append("<x:WorksheetOptions>");
            sb.Append("<x:Print>");
            sb.Append("<x:ValidPrinterInfo/>");
            sb.Append("<x:Scale>100</x:Scale>");
            sb.Append("<x:FitWidth>1</x:FitWidth>");
            sb.Append("<x:FitHeight>1</x:FitHeight>");
            sb.Append("</x:Print>");
            sb.Append("<x:PageSetup>");
            sb.Append("<x:Layout x:Orientation='Landscape'/>");
            sb.Append("</x:PageSetup>");
            sb.Append("<x:Selected/>");
            sb.Append("<x:DoNotDisplayGridlines/>");
            sb.Append("</x:WorksheetOptions>");
            sb.Append("</x:ExcelWorksheet>");
            sb.Append("</x:ExcelWorksheets>");
            sb.Append("</x:ExcelWorkbook>");
            sb.Append("</xml>");
            sb.Append("<![endif]-->");

            sb.Append("<style>");
            sb.Append("@page { mso-page-orientation: landscape; margin: 0.2in; } ");
            sb.Append("table { border-collapse: collapse; font-family: Arial; font-size: 11pt; width: 1100px; table-layout: fixed; } ");
            sb.Append("td { border: 1px solid black; padding: 5px; height: 35px; vertical-align: middle; } ");
            sb.Append(".no-border { border: none; } ");
            sb.Append(".title { font-size: 20pt; font-weight: bold; text-align: center; border: 2px solid black; height: 70px; } ");
            sb.Append(".gray { background-color: #f2f2f2; font-weight: bold; text-align: center; } ");
            sb.Append(".signature-bottom { font-size: 14pt; font-weight: bold; border: none; height: 130px; vertical-align: top; padding-top: 10px; } ");
            sb.Append("</style>");
            sb.Append("</head>");
            sb.Append("<body>");

            sb.Append("<table>");
            sb.Append("<colgroup>");
            sb.Append("<col width='100'><col width='100'><col width='190'><col width='190'>");
            sb.Append("<col width='70'><col width='70'><col width='90'><col width='110'>");
            sb.Append("<col width='90'><col width='90'>");
            sb.Append("</colgroup>");

            sb.Append("<tr>");
            sb.Append("<td class='no-border' colspan='2' align='center' style='height:80px;'>");
            sb.Append("<img src='" + logoUrl + "' width='160'>");
            sb.Append("</td>");
            sb.Append("<td colspan='5' class='title'>DEMANDE D'APPROVISIONNEMENT</td>");
            sb.Append("<td class='gray'>N° DA ST</td>");
            sb.Append("<td colspan='2' align='center' style='font-size:14pt; border: 2px solid black;'>" + num + "</td>");
            sb.Append("</tr>");

            sb.Append("<tr>");
            sb.Append("<td class='gray' colspan='2'>FOURNISSEUR</td>");
            sb.Append("<td colspan='3'>DIVERS</td>");
            sb.Append("<td class='gray' colspan='2'>Nom du demandeur :</td>");
            sb.Append("<td colspan='3' align='center' style='font-size:12pt;'>" + demandeur.ToUpper() + "</td>");
            sb.Append("</tr>");

            sb.Append("<tr>");
            sb.Append("<td colspan='5' rowspan='3'></td>");
            sb.Append("<td class='gray' colspan='2'>Service :</td>");
            sb.Append("<td align='center'>MAGASIN</td>");
            sb.Append("<td class='gray'>Date:</td>");
            sb.Append("<td align='center'>" + DateTime.Now.ToString("dd/MM/yyyy") + "</td>");
            sb.Append("</tr>");

            sb.Append("<tr>");
            sb.Append("<td class='gray' colspan='2' style='height:80px;'>Signature :</td>");
            sb.Append("<td colspan='3'></td>");
            sb.Append("</tr>");

            sb.Append("<tr>");
            sb.Append("<td class='gray' colspan='3'>N° Imputation comptable</td>");
            sb.Append("<td colspan='2'></td>");
            sb.Append("</tr>");

            sb.Append("<tr><td colspan='10' class='no-border' style='height:10px;'></td></tr>");

            sb.Append("<tr class='gray'>");
            sb.Append("<td>ITEM</td><td>CODE</td><td colspan='2'>DESIGNATION</td>");
            sb.Append("<td>QTE</td><td>STK</td><td>PU / HT</td><td>PT</td>");
            sb.Append("<td>CONSO</td><td>PERIODE J</td>");
            sb.Append("</tr>");

            for (int i = 0; i < 20; i++)
            {
                sb.Append("<tr>");
                sb.Append("<td align='center'>" + (i + 1) + "</td>");

                if (i < dt.Rows.Count)
                {
                    sb.Append("<td align='center'>" + dt.Rows[i]["CODE"] + "</td>");
                    sb.Append("<td colspan='2'>" + dt.Rows[i]["DES"] + "</td>");
                    sb.Append("<td align='center'>" + dt.Rows[i]["QTE"] + "</td>");
                    sb.Append("<td align='center'>" + dt.Rows[i]["STK"] + "</td>");
                    sb.Append("<td align='right' style='mso-number-format:\"#,##0.000\"'>" + dt.Rows[i]["PU"] + "</td>");
                    sb.Append("<td align='right' style='mso-number-format:\"#,##0.000\"'>" + dt.Rows[i]["PT"] + "</td>");
                }
                else
                {
                    sb.Append("<td></td><td colspan='2'></td><td></td><td></td><td></td><td></td>");
                }

                sb.Append("<td></td><td></td>");
                sb.Append("</tr>");
            }

            sb.Append("<tr>");
            sb.Append("<td colspan='5' class='no-border'></td>");
            sb.Append("<td colspan='2' class='gray' style='height:45px;'>TOTAL</td>");
            sb.Append("<td align='right' style='background-color:#ffff99; font-size:12pt; mso-number-format:\"#,##0.000\"'>");
            sb.Append(total.ToString("0.000") + " TND</td>");
            sb.Append("<td colspan='2' class='no-border'></td>");
            sb.Append("</tr>");

            sb.Append("<tr><td colspan='10' class='no-border' style='height:40px;'></td></tr>");

            sb.Append("<tr>");
            sb.Append("<td colspan='2' class='signature-bottom'>Signature Acheteur</td>");
            sb.Append("<td colspan='3' class='signature-bottom' style='text-align:center;'>Signature DAF</td>");
            sb.Append("<td colspan='2' class='signature-bottom' style='text-align:center;'>Signature DT</td>");
            sb.Append("<td colspan='3' class='signature-bottom' style='text-align:right;'>Signature DG</td>");
            sb.Append("</tr>");

            sb.Append("</table></body></html>");

            string dossier = Server.MapPath("~/DA_FILES/");
            if (!Directory.Exists(dossier)) Directory.CreateDirectory(dossier);

            string nomFichier = "DA_" + num + ".xls";
            string cheminComplet = Path.Combine(dossier, nomFichier);

            File.WriteAllText(cheminComplet, sb.ToString(), Encoding.UTF8);

            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                if (conn.State != ConnectionState.Open) conn.Open();
                SqlCeCommand cmd = new SqlCeCommand(
                    "UPDATE DA SET FichierExcel=@f WHERE NumeroDA=@n", conn);
                cmd.Parameters.AddWithValue("@f", nomFichier);
                cmd.Parameters.AddWithValue("@n", num);
                cmd.ExecuteNonQuery();
            }

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + nomFichier);
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = Encoding.UTF8;
            Response.WriteFile(cheminComplet);
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control) { }
    }
}