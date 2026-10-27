using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlServerCe;

namespace sabena
{
    public partial class SortieOutillage : System.Web.UI.Page
    {
        private const string TOKEN_KEY = "SubmitToken";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                    Qtemouv1.Text = "1";
              
                FillAvionList();
                GenerateSubmitToken();

                if (Request.QueryString["op"] == "ok")
                {
                    RestoreMecaState();
                    panelOE.Visible = true;
                    Paneloutill.Visible = false;
                }
            }
        }

        private void GenerateSubmitToken()
        {
            string token = Guid.NewGuid().ToString();
            ViewState[TOKEN_KEY] = token;
            Session[TOKEN_KEY] = token;
        }

        private bool IsTokenValid()
        {
            if (ViewState[TOKEN_KEY] == null || Session[TOKEN_KEY] == null) return false;
            return ViewState[TOKEN_KEY].ToString() == Session[TOKEN_KEY].ToString();
        }

        private void RestoreMecaState()
        {
            if (Session["MecaID"] != null)
            {
                IDMecatxt.Text = Session["MecaID"].ToString();
                nomtxt.Text = Session["MecaNom"].ToString();
                prenomTXT.Text = Session["MecaPrenom"].ToString();
                Panel1.Visible = true;
                Panelmecanicien.Visible = false;
            }
        }

  private void FillAvionList()
        {
            try
            {
                string sql = "SELECT Designation, MSN FROM AC";

                // On récupère la connexion
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    // IMPORTANT : SqlCeDataAdapter ouvre et ferme la connexion 
                    // automatiquement si elle est fermée. 
                    // Ne faites pas conn.Open() manuellement ici pour minimiser le temps de verrouillage.

                    using (SqlCeDataAdapter adp = new SqlCeDataAdapter(sql, conn))
                    {
                        DataTable dt = new DataTable();
                        adp.Fill(dt); // C'est ici que les DLL natives se chargent

                        ACtxt.DataSource = dt;
                        ACtxt.DataTextField = "Designation";
                        ACtxt.DataValueField = "MSN";
                        ACtxt.DataBind();

                        ACtxt.Items.Insert(0, new ListItem("-- Sélectionnez Avion --", "0"));
                    }
                }
            }
            catch (Exception ex)
            {
                // En cas de vraie erreur de base de données (fichier manquant, etc.)
                System.Diagnostics.Debug.WriteLine("Erreur FillAvionList : " + ex.Message);
            }
        }

        public bool EstDisponible(string idOutillage)
        {
            string sql = "SELECT COUNT(*) FROM MouvementOutillage WHERE IDoutillage = @id AND (heureRetour = '' OR heureRetour IS NULL)";
            using (SqlCeConnection conn = DBConnection.GetConnection())
            {
                SqlCeCommand cmd = new SqlCeCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", idOutillage);
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return (count == 0);
            }
        }

        protected void loadMeca(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(IDMecatxt.Text)) return;
                string sql = "SELECT nom, prenom FROM mecanicien WHERE stampnum =" + IDMecatxt.Text;
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    SqlCeCommand cmd = new SqlCeCommand(sql, conn);
                    conn.Open();
                    SqlCeDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        nomtxt.Text = dr["nom"].ToString();
                        prenomTXT.Text = dr["prenom"].ToString();
                        Session["MecaID"] = IDMecatxt.Text;
                        Session["MecaNom"] = nomtxt.Text;
                        Session["MecaPrenom"] = prenomTXT.Text;
                        Panelmecanicien.Visible = false;
                        Panel1.Visible = true;
                        Paneloutill.Visible = true;
                        panelErrormeca.Visible = false;
                        Page.SetFocus(Idoutillagetxt);
                    }
                    else
                    {
                        Label2.Text = "❌ Code mécanicien introuvable";
                        panelErrormeca.Visible = true;
                    }
                }
            }
            catch { Label2.Text = "Erreur badge"; panelErrormeca.Visible = true; }
        }

        protected void loadoutillage(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(Idoutillagetxt.Text)) return;

                string sql = "SELECT * FROM outillage WHERE id = @id";
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    SqlCeCommand cmd = new SqlCeCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", Idoutillagetxt.Text);
                    conn.Open();
                    SqlCeDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        if (!EstDisponible(Idoutillagetxt.Text))
                        {
                            Label2.Text = "⚠️ Cet outillage est déjà sorti et n'a pas encore été retourné.";
                            panelErrormeca.Visible = true;
                            paneldetailoutil.Visible = false;
                            return;
                        }

                        Idcle.Text = dr["id"].ToString();
                        desitxt.Text = dr["Designation"].ToString();
                        pntxt.Text = dr["PN"].ToString();
                        sntxt.Text = dr["SN"].ToString();
                        qtetxt.Text = dr["qte"].ToString();
                        remarque.Text = dr["remarque"].ToString();
                        auxtype.Text = dr["typeoutillage"].ToString();
                        typetxt.Text = dr["typeoutillage"].ToString();
                        Image1.ImageUrl = dr["URLIMG"].ToString();

                        paneldetailoutil.Visible = true;
                        Paneloutill.Visible = false;
                        panelErrormeca.Visible = false;
                    }
                    else
                    {
                        Label2.Text = "❌ Erreur : Code outillage introuvable.";
                        panelErrormeca.Visible = true;
                        paneldetailoutil.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                Label2.Text = "Erreur : " + ex.Message;
                panelErrormeca.Visible = true;
            }
        }

        protected void check_Click(object sender, EventArgs e)
        {
            auxline.Text = "check";
            panelmouvment.Visible = true;
            bool isStd = (auxtype.Text == "Standard");

            // Gestion OE
            oelabel.Visible = !isStd;
            OEtxt.Visible = !isStd;
            OEtxt.ReadOnly = false; // Modifiable en mode Check
            OEtxt.Enabled = true;
            OEtxt.Text = "";

            // Gestion BV (On force la visibilité si ce n'est pas un outil standard)
            bvlablel.Visible = !isStd;
            BVDROP.Visible = !isStd;

            if (isStd)
            {
                OEtxt.Text = "check";
            }
            else
            {
                LoadBVDropdown();
            }
        }

        protected void line_Click(object sender, EventArgs e)
        {
            auxline.Text = "line";
            panelmouvment.Visible = true;

            // Masquer BV
            bvlablel.Visible = false;
            BVDROP.Visible = false;

            // OE par défaut "line" et non modifiable
            oelabel.Visible = true;
            OEtxt.Visible = true;
            OEtxt.Text = "line";
            OEtxt.ReadOnly = true; // Non modifiable
        }

        protected void Buttonajout_Click(object sender, EventArgs e)
        {
            if (!IsTokenValid())
            {
                Response.Redirect("SortieOutillage.aspx?op=ok");
                return;
            }

            if (ACtxt.SelectedIndex <= 0)
            {
                Label2.Text = "⚠️ Sélectionnez un avion !";
                panelErrormeca.Visible = true; return;
            }

            if (BVDROP.Visible && BVDROP.SelectedIndex <= 0)
            {
                Label2.Text = "⚠️ Sélectionnez un BV !";
                panelErrormeca.Visible = true; return;
            }

            int qteSaisie;
            if (!int.TryParse(Qtemouv1.Text, out qteSaisie) || qteSaisie <= 0)
            {
                Label2.Text = "❌ Quantité invalide"; panelErrormeca.Visible = true; return;
            }

            try
            {
                DALmouvoutillage.Insert(GetDataFromInterface());
                DALOE.Insert(GetDataFromInterfaceoe());

                Session[TOKEN_KEY] = null;
                Response.Redirect("SortieOutillage.aspx?op=ok", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                Label2.Text = "Erreur : " + ex.Message; panelErrormeca.Visible = true;
                GenerateSubmitToken();
            }
        }

        private MouvOutillage GetDataFromInterface()
        {
            MouvOutillage a = new MouvOutillage();
            a.idoutillage = Idcle.Text;
            a.idmecanicien = IDMecatxt.Text;
            if (Session["uni"] == null) return null;
            a.idmagasin = DALUTILISATEUR.selectid(Session["uni"].ToString(), Session["pwd"].ToString()).ToString();
            a.idac = ACtxt.SelectedValue;
            a.heuresortie = DateTime.Now.ToString("HH:mm");
            a.datemouvement = DateTime.Now.ToString("MM/dd/yyyy");
            a.qte = Qtemouv1.Text;
            a.remarque = remarquetxt.Text;
            a.heureretour = ""; a.dateretour = "";
            a.bv = (auxline.Text == "line") ? "LINE" : (BVDROP.Visible ? BVDROP.SelectedItem.Text : "Standard");
            return a;
        }

        private OE GetDataFromInterfaceoe()
        {
            return new OE { noOE = OEtxt.Text, idoutilsortie = DALOE.maxidoutillage().ToString() };
        }

        private void LoadBVDropdown()
        {
            try
            {
                if (string.IsNullOrEmpty(ACtxt.SelectedValue)) return;
                string com = "SELECT id, bvavion FROM BV WHERE IDAVION =" + ACtxt.SelectedValue;
                using (SqlCeConnection conn = DBConnection.GetConnection())
                {
                    SqlCeDataAdapter adpt = new SqlCeDataAdapter(com, conn);
                    DataTable dt = new DataTable();
                    adpt.Fill(dt);
                    BVDROP.DataSource = dt;
                    BVDROP.DataTextField = "BVAVION";
                    BVDROP.DataValueField = "ID";
                    BVDROP.DataBind();
                    BVDROP.Items.Insert(0, new ListItem("-- Sélectionnez BV --", "0"));
                }
            }
            catch { }
        }

        protected void LinkButton1_Clickplus(object sender, EventArgs e)
        {
            GenerateSubmitToken();
            panelOE.Visible = false;
            paneldetailoutil.Visible = false;
            panelmouvment.Visible = false;
            Paneloutill.Visible = true;
            Idoutillagetxt.Text = "";
            OEtxt.ReadOnly = false; // Reset pour le prochain outil
            RestoreMecaState();
            Page.SetFocus(Idoutillagetxt);
        }

        protected void termine_Click(object sender, EventArgs e) { Session["MecaID"] = null; Response.Redirect("listeMouvement.aspx"); }
        protected void non(object sender, EventArgs e) { panelmouvment.Visible = false; paneldetailoutil.Visible = true; }
        protected void ACtxt_SelectedIndexChanged(object sender, EventArgs e) { if (auxline.Text == "check" && auxtype.Text != "Standard") LoadBVDropdown(); }
        protected void ACtxt_TextChanged(object sender, EventArgs e) { }
        protected void LinkButton1_Click1(object sender, EventArgs e) { Response.Redirect("ADDOE.aspx?Usemode=Update&id=" + DALOE.maxidoutillage().ToString()); }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e) { }
    }
}