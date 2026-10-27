using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class detail_alimentation : System.Web.UI.Page
    {
        // ================= VIEWSTATE =================
        int idArticle
        {
            get { return ViewState["idArticle"] != null ? (int)ViewState["idArticle"] : 0; }
            set { ViewState["idArticle"] = value; }
        }

        // ================= PAGE LOAD =================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("listeconsomable.aspx");
                    return;
                }

                idArticle = Convert.ToInt32(Request.QueryString["id"]);

                LoadArticle();
                LoadHistorique();
            }
        }

        // ================= LOAD ARTICLE =================
        private void LoadArticle()
        {
            DataTable dt = DALARTICLE.SelectByID(idArticle.ToString());

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                // Remplissage classique
                LBL_DESIGNATION.Text = row["DesignationARTICLE"].ToString();
                LBL_FOURNISSEUR.Text = row["Fournisseur"].ToString();
                LBL_QTE.Text = row["QTE"].ToString();
                LBL_MIN.Text = row["Stockmin"].ToString();
                LBL_MAX.Text = row["Stockmax"].ToString();

                // Conversion du prix
                decimal prix = 0;
                if (row["prixunitaire"] != DBNull.Value)
                {
                    string rawPrix = row["prixunitaire"].ToString().Replace(",", ".");
                    decimal.TryParse(rawPrix, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out prix);
                }

                // 👉 CONCATÉNATION DIRECTE (Prix + Devisear)
                LBL_PRIX.Text = prix.ToString("0.000") + " " + row["Devisear"].ToString();
            }
        }
        // ================= LOAD HISTORIQUE =================
        private void LoadHistorique()
        {
            DataTable dt = DALMOUVCONSO.SelectByArticle(idArticle.ToString());

            gvHistorique.DataSource = dt;
            gvHistorique.DataBind();
        }

        // ================= PAGINATION =================
        protected void gvHistorique_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHistorique.PageIndex = e.NewPageIndex;
            LoadHistorique();
        }

        // ================= AJOUT STOCK =================
        protected void BTN_AJOUT_Click(object sender, EventArgs e)
        {
            try
            {
                if (idArticle <= 0)
                {
                    ShowError("❌ ID invalide");
                    return;
                }

                // ✅ Récupérer la devise choisie
                string devise = ddlDevise.SelectedValue;

                // Quantité
                int qteAjout;
                if (!int.TryParse(TXT_QTE.Text.Trim(), out qteAjout) || qteAjout <= 0)
                {
                    ShowError("❌ Quantité invalide");
                    return;
                }

                // Prix unitaire
                decimal prix = 0;
                string prixText = prixu.Text.Trim()
                                            .Replace(",", ".")
                                            .Replace(" ", "");

                if (!decimal.TryParse(prixText,
                    NumberStyles.Any,
                    CultureInfo.InvariantCulture,
                    out prix) || prix <= 0)
                {
                    ShowError("❌ Prix unitaire invalide");
                    return;
                }

                int qteActuelle = Convert.ToInt32(LBL_QTE.Text);
                int nouvelleQte = qteActuelle + qteAjout;

                // Mise à jour stock
                DALARTICLE.UpdateStock(idArticle, nouvelleQte);

                // ✅ Mouvement avec devise
                Mouvconso m = new Mouvconso();
                m.IDarticle = idArticle;
                m.typemouvement = "ENTREE";
                m.Quantite = qteAjout;
                m.prixu = prix.ToString(
                                       CultureInfo.InvariantCulture
                                   );                        // stocker en invariant
                m.Devise = devise;                   // ✅ Devise sauvegardée
                m.DateMouvement = DateTime.Now;
                m.fournisseur = TXT_FOURNISSEUR.Text.Trim();
                m.Demandeur = "";
                m.Avion = "11111111";
                m.NumDB = "";
                m.MagasinierID = Convert.ToInt32(
                                       DALUTILISATEUR.selectid(
                                           Session["uni"].ToString(),
                                           Session["pwd"].ToString()
                                       )
                                   );

                DALMOUVCONSO.Insert(m);

                // ✅ Message succès avec devise et format
                decimal total = qteAjout * prix;
                ShowSuccess(
                    "✅ Stock alimenté avec succès" +
                    " | Qté ajoutée : " + qteAjout +
                    " | Prix unitaire : " + FormatMontant(prix, devise) +
                    " | Total : " + FormatMontant(total, devise)
                );

                // Refresh
                LoadArticle();
                LoadHistorique();

                // Reset champs
                prixu.Text = "";
                TXT_QTE.Text = "";
                TXT_FOURNISSEUR.Text = "";
                ddlDevise.SelectedIndex = 0; // ✅ Reset devise à DT
            }
            catch (Exception ex)
            {
                ShowError("❌ Erreur : " + ex.Message);
            }
        }

        // ================= FORMAT MONTANT =================
        // DT  → 3 décimales  ex: 10,500 DT
        // EUR → 2 décimales  ex: 10,50 EUR
        // USD → 2 décimales  ex: 10,50 USD
        private string FormatMontant(decimal montant, string devise)
        {
            string format = (devise == "DT") ? "0.000" : "0.00";
            CultureInfo ci = CultureInfo.GetCultureInfo("fr-TN");
            return montant.ToString(format, ci) + " " + devise;
        }

        // ================= UI =================
        private void ShowSuccess(string msg)
        {
            PanelSuccess.Visible = true;
            PanelError.Visible = false;
            LBL_SUCCESS.Text = msg;
        }

        private void ShowError(string msg)
        {
            PanelError.Visible = true;
            PanelSuccess.Visible = false;
            LBL_ERROR.Text = msg;
        }
    }
}