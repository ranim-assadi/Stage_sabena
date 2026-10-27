using System;
using System.Globalization;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class addarticle : System.Web.UI.Page
    {
        private const string CULTURE_TN = "fr-TN";

        // ================= PAGE LOAD =================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializePage();
                ResetTotal();
            }
        }

        private void InitializePage()
        {
            try
            {
                Label lbl = (Label)Page.Master.FindControl("PAGETXT");
                if (lbl != null)
                    lbl.Text = "📦 Ajout des Articles";
            }
            catch (Exception ex)
            {
                LogError("InitPage", ex);
            }
        }

        // ================= RESET TOTAL =================
        private void ResetTotal()
        {
            // Devise par défaut = DT avec 3 décimales
            string devise = "DT";

            // Si le dropdown existe déjà on prend sa valeur
            if (ddlDevise != null && ddlDevise.SelectedValue != "")
                devise = ddlDevise.SelectedValue;

            LBL_TOTAL.Text = FormatMontant(0, devise);
        }

        // ================= FORMAT MONTANT =================
        // DT  = 3 décimales  → 10,500 DT
        // EUR = 2 décimales  → 10,50 EUR
        // USD = 2 décimales  → 10,50 USD
        private string FormatMontant(decimal montant, string devise)
        {
            string format = (devise == "DT") ? "0.000" : "0.00";

            CultureInfo ci = CultureInfo.GetCultureInfo(CULTURE_TN);

            return montant.ToString(format, ci) + " " + devise;
        }

        // ================= CALCUL TOTAL =================
        protected void CalcTotal(object sender, EventArgs e)
        {
            try
            {
                // Récupérer la devise choisie
                string devise = ddlDevise.SelectedValue;

                int qte;
                decimal prix;

                if (!int.TryParse(qtetxt.Text, out qte) || qte <= 0)
                {
                    ResetTotal();
                    return;
                }

                string prixText = PRIXTXT.Text.Trim()
                                              .Replace(",", ".")
                                              .Replace(" ", "");

                if (!decimal.TryParse(prixText,
                    NumberStyles.Any,
                    CultureInfo.InvariantCulture,
                    out prix) || prix <= 0)
                {
                    ResetTotal();
                    return;
                }

                decimal total = qte * prix;

                // Afficher avec la bonne devise et décimales
                LBL_TOTAL.Text = FormatMontant(total, devise);
            }
            catch (Exception ex)
            {
                LogError("CalcTotal", ex);
            }
        }

        // ================= ADD ARTICLE =================
        protected void ButtonAjout_Click(object sender, EventArgs e)
        {
            try
            {
                int qte, min, max;
                decimal prix;
                string devise;

                if (!ValidateInputs(out qte, out min, out max, out prix, out devise))
                    return;

                if (min >= max)
                {
                    ShowError("❌ MIN doit être inférieur à MAX");
                    return;
                }

                if (qte < min || qte > max)
                {
                    ShowError("❌ Quantité hors MIN/MAX");
                    return;
                }

                int userId = GetCurrentUserId();
                if (userId == -1) return;

                decimal total = qte * prix;

                ARTICLE article = new ARTICLE();
                article.DesignationAR = DESIGTXT.Text.Trim();
                article.FournisseurAR = fournisseurTXT.Text.Trim();
                article.StockminAR = min;
                article.StockmaxAR = max;
                article.qte = qte;
                article.PrixunitaireAR = prix;
                article.PrixtotalAR = total;
                article.DeviseAR = devise;   // ✅ Devise sauvegardée
                article.DateentreAR = DateTime.Now;
                article.IDmagasinier = userId;

                int result = DALARTICLE.Insert(article);

                if (result > 0)
                {
                    ClearForm();
                    ShowSuccess(
                        "✅ Article ajouté avec succès (ID: " + result + ") " +
                        "| Prix unitaire : " + FormatMontant(prix, devise) +
                        " | Total : " + FormatMontant(total, devise)
                    );
                }
                else
                {
                    ShowError("❌ Erreur insertion article");
                }
            }
            catch (Exception ex)
            {
                LogError("ButtonAjout", ex);
                ShowError("❌ Erreur système");
            }
        }

        // ================= VALIDATION =================
        private bool ValidateInputs(out int qte, out int min, out int max,
                                    out decimal prix, out string devise)
        {
            qte = 0;
            min = 0;
            max = 0;
            prix = 0;
            devise = ddlDevise.SelectedValue; // ✅ Récupérer devise

            if (string.IsNullOrWhiteSpace(DESIGTXT.Text))
            {
                ShowError("❌ Désignation obligatoire");
                return false;
            }

            if (!int.TryParse(qtetxt.Text, out qte) || qte <= 0)
            {
                ShowError("❌ Quantité invalide");
                return false;
            }

            if (!int.TryParse(minTXT.Text, out min) || min <= 0)
            {
                ShowError("❌ MIN invalide");
                return false;
            }

            if (!int.TryParse(MAXTXT.Text, out max) || max <= 0)
            {
                ShowError("❌ MAX invalide");
                return false;
            }

            string prixText = PRIXTXT.Text.Trim()
                                          .Replace(",", ".")
                                          .Replace(" ", "");

            if (!decimal.TryParse(prixText,
                NumberStyles.Any,
                CultureInfo.InvariantCulture,
                out prix) || prix <= 0)
            {
                ShowError("❌ Prix invalide");
                return false;
            }

            return true;
        }

        // ================= USER ID =================
        private int GetCurrentUserId()
        {
            try
            {
                string u = Session["uni"] != null ? Session["uni"].ToString() : "";
                string p = Session["pwd"] != null ? Session["pwd"].ToString() : "";

                if (u == "" || p == "")
                {
                    ShowError("❌ Session expirée");
                    return -1;
                }

                long id = DALUTILISATEUR.selectid(u, p);
                return (int)id;
            }
            catch (Exception ex)
            {
                LogError("GetUserId", ex);
                ShowError("❌ Erreur utilisateur");
                return -1;
            }
        }

        // ================= UI =================
        private void ShowSuccess(string msg)
        {
            PanelSuccess.Visible = true;
            PanelError.Visible = false;
            LabelSuccess.Text = msg;
        }

        private void ShowError(string msg)
        {
            PanelError.Visible = true;
            PanelSuccess.Visible = false;
            LabelError.Text = msg;
        }

        private void ClearForm()
        {
            DESIGTXT.Text = "";
            fournisseurTXT.Text = "";
            MAXTXT.Text = "";
            minTXT.Text = "";
            qtetxt.Text = "";
            PRIXTXT.Text = "";

            // ✅ Reset devise à DT par défaut
            ddlDevise.SelectedIndex = 0;

            ResetTotal();

            PanelError.Visible = false;
            PanelSuccess.Visible = false;
        }

        protected void ButtonReset_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        // ================= LOG =================
        private void LogError(string title, Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(
                "[" + DateTime.Now + "] " + title + " : " + ex.Message);
        }
    }
}