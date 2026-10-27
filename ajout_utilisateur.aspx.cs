using System;
using System.Data.SqlServerCe;

namespace sabena
{
    public partial class ajout_utilisateur : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TXT_NOM.Text = Request.QueryString["nom"];
            }
        }

        protected void BTN_SAVE_Click(object sender, EventArgs e)
        {
            try
            {
                string sql = @"
INSERT INTO Mecanicien
(Stampnum,nom, PRENOM,fonction,Departement,Escale)
VALUES
(@Stampnum,@NOM, @PRENOM,@fonction,@Departement,@Escale)";

                using (SqlCeConnection con = DBConnection.GetConnection())
                using (SqlCeCommand cmd = new SqlCeCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@NOM", TXT_NOM.Text);
                    cmd.Parameters.AddWithValue("@PRENOM", TXT_PRENOM.Text);;
                    cmd.Parameters.AddWithValue("@Stampnum", txt_matricule.Text);
                    cmd.Parameters.AddWithValue("@fonction", TXT_FONCTION.Text);
                    cmd.Parameters.AddWithValue("@Departement", TXT_DEPARTEMENT.SelectedValue); 
                    cmd.Parameters.AddWithValue("@Escale", TXT_ESCALE.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LBL_MSG.Text = "Utilisateur créé avec succès";
            

                // ✅ UNE SEULE ACTION (FERMER + RELOAD PARENT)
                ClientScript.RegisterStartupScript(
       this.GetType(),
       "closePopup",
       @"
    window.parent.document.getElementById('iframeCreateUser').src = '';
    window.parent.location.reload();
    ",
       true
   );

          
            }
            catch (Exception ex)
            {
                LBL_MSG.Text = "Erreur : " + ex.Message;
            }
        }
    }
}