using System;
using System.Data;
using System.Globalization;

namespace sabena
{
    public partial class modifarticle : System.Web.UI.Page
    {
        // ================= ID ARTICLE =================
        private int idArticle
        {
            get
            {
                if (ViewState["idArticle"] == null)
                    return 0;

                int id;

                if (int.TryParse(ViewState["idArticle"].ToString(), out id))
                    return id;

                return 0;
            }
            set
            {
                ViewState["idArticle"] = value;
            }
        }

        // ================= PAGE LOAD =================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id;

                if (Request.QueryString["id"] != null &&
                    int.TryParse(Request.QueryString["id"], out id))
                {
                    idArticle = id;

                    LoadArticle();
                }
                else
                {
                    ShowError("ID article invalide");
                }
            }
        }

        // ================= LOAD ARTICLE =================
        private void LoadArticle()
        {
            try
            {
                DataTable dt = DALARTICLE.SelectByID(idArticle.ToString());

                if (dt == null || dt.Rows.Count == 0)
                {
                    ShowError("Article introuvable");
                    return;
                }

                DataRow r = dt.Rows[0];

                DESIGTXT.Text = Safe(r["designationarticle"]);

                fournisseurTXT.Text = Safe(r["fournisseur"]);

                minTXT.Text = Safe(r["stockmin"]);

                MAXTXT.Text = Safe(r["stockmax"]);

                qtetxt.Text = Safe(r["qte"]);

                // ===== PRIX FORMAT 0.00 =====
                decimal prix = SafeDecimal(r["prixunitaire"]);

                PRIXTXT.Text = prix.ToString("0.00");

                // ===== TOTAL =====
                decimal total = SafeDecimal(r["prixtotal"]);

                LBL_TOTAL.Text = total.ToString("0.00") + " DT";
            }
            catch (Exception ex)
            {
                ShowError("Erreur chargement : " + ex.Message);
            }
        }

        // ================= MODIFIER =================
        protected void BTN_MODIFIER_Click(object sender, EventArgs e)
        {
            try
            {
                if (idArticle == 0)
                {
                    ShowError("ID invalide");
                    return;
                }

                // ===== VALIDATION =====

                int qte;
                int stockMin;
                int stockMax;

                decimal prix;

                if (!int.TryParse(qtetxt.Text.Trim(), out qte))
                {
                    ShowError("Quantité invalide");
                    return;
                }

                if (!int.TryParse(minTXT.Text.Trim(), out stockMin))
                {
                    ShowError("Stock minimum invalide");
                    return;
                }

                if (!int.TryParse(MAXTXT.Text.Trim(), out stockMax))
                {
                    ShowError("Stock maximum invalide");
                    return;
                }

                string prixText = PRIXTXT.Text.Trim();

                prixText = prixText.Replace(",", ".");

                if (!decimal.TryParse(
                    prixText,
                    NumberStyles.Any,
                    CultureInfo.InvariantCulture,
                    out prix))
                {
                    ShowError("Prix invalide");
                    return;
                }

                if (stockMin > stockMax)
                {
                    ShowError("Le stock MIN ne peut pas dépasser le stock MAX");
                    return;
                }

                decimal total = qte * prix;

                // ===== SESSION =====

                if (Session["uni"] == null || Session["pwd"] == null)
                {
                    ShowError("Session expirée");
                    return;
                }

                // ===== ARTICLE =====

                ARTICLE a = new ARTICLE();

                a.DesignationAR = DESIGTXT.Text.Trim();

                a.FournisseurAR = fournisseurTXT.Text.Trim();

                a.StockminAR = stockMin;

                a.StockmaxAR = stockMax;

                a.qte = qte;

                a.PrixunitaireAR = prix;

                a.PrixtotalAR = total;

                a.DateentreAR = DateTime.Now;

                a.IDmagasinier = DALUTILISATEUR.selectid(
                    Session["uni"].ToString(),
                    Session["pwd"].ToString()
                );

                // ===== UPDATE =====

                int result = DALARTICLE.Update(
                    idArticle.ToString(),
                    a
                );

                if (result > 0)
                {
                    ShowSuccess("Modification réussie");

                    PRIXTXT.Text = prix.ToString("0.00");

                    LBL_TOTAL.Text = total.ToString("0.00") + " DT";
                }
                else
                {
                    ShowError("Modification échouée");
                }
            }
            catch (Exception ex)
            {
                ShowError("Erreur : " + ex.Message);
            }
        }

        // ================= CALCUL TOTAL LIVE =================
        protected void CalcTotal(object sender, EventArgs e)
        {
            try
            {
                int qte;

                decimal prix;

                if (int.TryParse(qtetxt.Text.Trim(), out qte))
                {
                    string prixText = PRIXTXT.Text.Trim();

                    prixText = prixText.Replace(",", ".");

                    if (decimal.TryParse(
                        prixText,
                        NumberStyles.Any,
                        CultureInfo.InvariantCulture,
                        out prix))
                    {
                        decimal total = qte * prix;

                        LBL_TOTAL.Text = total.ToString("0.00") + " DT";

                        return;
                    }
                }

                LBL_TOTAL.Text = "0.00 DT";
            }
            catch
            {
                LBL_TOTAL.Text = "0.00 DT";
            }
        }

        // ================= SAFE STRING =================
        private string Safe(object o)
        {
            if (o == null || o == DBNull.Value)
                return "";

            return o.ToString();
        }

        // ================= SAFE DECIMAL =================
        private decimal SafeDecimal(object o)
        {
            decimal result;

            if (o == null || o == DBNull.Value)
                return 0;

            string value = o.ToString().Trim();

            if (string.IsNullOrEmpty(value))
                return 0;

            value = value.Replace(",", ".");

            if (decimal.TryParse(
                value,
                NumberStyles.Any,
                CultureInfo.InvariantCulture,
                out result))
            {
                return result;
            }

            return 0;
        }

        // ================= SUCCESS =================
        private void ShowSuccess(string msg)
        {
            PanelSuccess.Visible = true;

            PanelError.Visible = false;

            LBL_SUCCESS.Text = msg;
        }

        // ================= ERROR =================
        private void ShowError(string msg)
        {
            PanelError.Visible = true;

            PanelSuccess.Visible = false;

            LBL_ERROR.Text = msg;
        }
    }
}