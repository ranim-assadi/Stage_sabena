using System;
using System.Data;

namespace sabena
{
    public partial class sortie_article : System.Web.UI.Page
    {
        int idArt;

        protected void Page_Load(object sender, EventArgs e)
        {
            int.TryParse(Request.QueryString["id"], out idArt);

            if (!IsPostBack)
            {
                LoadArticle();
                LoadEmployes();
                LoadAvions();
            }
        }

        private void LoadArticle()
        {
            if (idArt == 0) return;

            DataTable dt = DALARTICLE.SelectByID(idArt.ToString());

            if (dt.Rows.Count > 0)
            {
                LBL_DESIGNATION.Text = dt.Rows[0]["DesignationARTICLE"].ToString();
                LBL_FOURNISSEUR.Text = dt.Rows[0]["Fournisseur"].ToString();
                LBL_QTE.Text = dt.Rows[0]["QTE"].ToString();
            }
        }

        private void LoadEmployes()
        {
            string sql = @"
                SELECT Stampnum,
                       NOM + ' ' + PRENOM AS NomComplet
                FROM Mecanicien
                ORDER BY NOM";

            rptEmployes.DataSource = DALARTICLE.GetDatat(sql);
            rptEmployes.DataBind();
        }

        private void LoadAvions()
        {
            string sql = @"
                SELECT MSN,
                       Designation
                FROM AC
                ORDER BY Designation";

            rptAvions.DataSource = DALARTICLE.GetDatat(sql);
            rptAvions.DataBind();
        }

        protected void BTN_SORTIR_Click(object sender, EventArgs e)
        {
            try
            {
                int qte = Convert.ToInt32(TXT_QTE.Text);
                int stock = Convert.ToInt32(LBL_QTE.Text);

                if (qte > stock)
                {
                    ShowError("Stock insuffisant");
                    return;
                }

                if (string.IsNullOrEmpty(HF_DEMANDEUR_ID.Value))
                {
                    ShowError("Demandeur invalide");
                    return;
                }

                // ❌ Avion n'est plus obligatoire
                string avion = string.IsNullOrEmpty(HF_AVION_ID.Value)
       ? "11111111"
       : HF_AVION_ID.Value;

                DALARTICLE.UpdateStock(idArt, stock - qte);

                int magasinierId = Convert.ToInt32(
                    DALUTILISATEUR.selectid(
                        Session["uni"].ToString(),
                        Session["pwd"].ToString()
                    )
                );

                Mouvconso m = new Mouvconso
                {
                    IDarticle = idArt,
                    Quantite = qte,
                    typemouvement = "SORTIE",
                    DateMouvement = DateTime.Now,
                    Demandeur = HF_DEMANDEUR_ID.Value,
                    Avion = avion, // peut être null
                    NumDB = TXT_NUMDB.Text,
                    MagasinierID = magasinierId
                };

                DALMOUVCONSO.Insert(m);

                ShowSuccess("Sortie enregistrée");

                TXT_QTE.Text = "";
                TXT_DEMANDEUR.Text = "";
                TXT_AVION.Text = "";
                HF_DEMANDEUR_ID.Value = "";
                TXT_NUMDB.Text = "";
                HF_AVION_ID.Value = "";
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private void ShowSuccess(string msg)
        {
            LoadArticle();
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