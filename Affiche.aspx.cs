 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlServerCe;
using System.IO;


namespace sabena
{
    public partial class affiche : System.Web.UI.Page
    {
        private DemandeB GetDataFromInterface()
        {
            try
            {
                DemandeB a = new DemandeB();


                a.NOCMD = Nocmd.Text;
                a.NODA = NoDA.Text;
                a.QTESTK = QTESTK.Text;
                a.QTEDA = QTEDA.Text;
                a.REMARQUE = REMARQUETXT.Text;
                if (Stockchk.Checked) { a.ESTK = "1"; } else { a.ESTK = "0"; }
                if (DAchk.Checked) { a.EDA = "1"; } else { a.EDA = "0"; }
          
                a.etatdb = "VO";
               
                a.ordo = "NO";
               // a.date = DateTime.Now.ToString("yyyy-MM-dd");
                return a;
            }
            catch (Exception ex)
            {

                Label1.Text = "Erreur de saisie! \n Verifier vos champs SVP!";
                Label1.Visible = true;
                return null;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                Label mpLabel = (Label)Page.Master.FindControl("PAGETXT");
                mpLabel.Text = "Traitement de demande Besoin";
                if (this.Request.Params["Usemode"] == "sh")
              {
                  Panel4.Visible = false;
              }
                QTESTK.Visible = false;
                QTEDA.Visible = false;
                Nocmd.Visible = false;
                NoDA.Visible = false;
                REMARQUETXT.Visible = false;
                Button1.Visible = false;
                try
                {

                    if (this.Request.Params["id"] != null)
                    {
                        string str = " SELECT utilisateur.departement as dept,utilisateur.nom+ +utilisateur.prenom as name ,DemandeB.id, DemandeB.etatDB, DemandeB.DESIGNATION, DemandeB.PN, DemandeB.SN, AC.Designation AS acidd, DemandeB.QTE, DemandeB.OE, DemandeB.DATE, DemandeB.DATEBESOIN, DATEDIFF(day,DemandeB.DATE, DemandeB.DATEBESOIN) AS remaining,DemandeB.URL as link FROM  DemandeB INNER JOIN Utilisateur ON DemandeB.Demandeur = Utilisateur.ID INNER JOIN AC ON DemandeB.ACID = AC.MSN and  demandeb.id= " + this.Request.Params["id"].ToString(); ;
                               

                        SqlCeCommand cmd = new SqlCeCommand(str, DBConnection.GetConnection());

                        cmd.Connection.Open();

                        SqlCeDataReader dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {

                            NDBtxt.Text = dr["ID"].ToString();
                            Designtxt.Text = dr["designation"].ToString();
                            PNTXT.Text = dr["pn"].ToString();
                            SNtxt.Text = dr["sn"].ToString();
                            ACTXT.Text = dr["acidd"].ToString();
                            QTETXT.Text = dr["qte"].ToString();
                           
                            Demandeurtxt.Text = dr["name"].ToString();
                            OETXT.Text = dr["oe"].ToString();
                            DEPTTXT.Text = dr["dept"].ToString();

                            DATETXT.Text = dr["date"].ToString();

                            datedesoinTXT.Text = dr["datebesoin"].ToString();
                            REMTXT.Text=dr["remaining"].ToString();
                            linkurl.NavigateUrl = dr["link"].ToString();
                            linkurl.Text = dr["link"].ToString();
                        }
                    }

                    string str1 = " SELECT * from cloture where IDDB="+this.Request.Params["id"];
                    DataSet ds = DALDB.GetData(str1);
                    if (ds.Tables.Count > 0)
                    {
                        gv.DataSource = ds;
                        gv.DataBind();
                       // gv.Columns[0].Visible = false;
                       // gv.Columns[1].Visible = true;


                    }


                }
                catch
                { }
               

            }
        }

        public string etatimageDA(object objOnSale)
        {
            string ledgreen = "~/image/chekgren.png";
            string ledyellow = "~/image/chekyellow.png";

            string etat = Convert.ToString(objOnSale);

            if (etat == "1")
            {
                return ledgreen;
            }

            else
            {
                return ledyellow;
            }

        }
        public string etatimageSTK(object objOnSale)
        {
            string ledgreen = "~/image/chekgren.png";
            string ledyellow = "~/image/chekyellow.png";

            string etat = Convert.ToString(objOnSale);

            if (etat == "1")
            {
                return ledgreen;
            }

            else
            {
                return ledyellow;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //try
            //{
            if (this.Request.Params["Usemode"] == "Tr")
            {
                DALDB.insertCloture(this.Request.Params["id"], this.GetDataFromInterface());
                this.Response.Redirect("traitedDB.aspx");
            }
            else
            {
                DALDB.insertCloture(this.Request.Params["id"], this.GetDataFromInterface());
                this.Response.Redirect("Consultall.aspx");
            }


               
            //}
            //catch
            //{
            //    Label1.ForeColor = System.Drawing.Color.Red;

            //    Label1.Text = "Vérifier Votre demande ! ";
            //    Label1.Visible = true;
            //    Panel1.Visible = true;

            //}
        }

        protected void QTESTK_TextChanged(object sender, EventArgs e)
        {
          
        }

        protected void QTEDA_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void Stockchk_CheckedChanged(object sender, EventArgs e)
        {
            if (Stockchk.Checked == true)
            {
                QTESTK.Visible = true;
                REMARQUETXT.Visible = true;
                Button1.Visible = true;
            }else
            { QTESTK.Visible = false;
            REMARQUETXT.Visible = false;
            Button1.Visible = false;
            }
        }

        protected void DAchk_CheckedChanged(object sender, EventArgs e)
        {
            if (DAchk.Checked == true)
            {
                QTEDA.Visible = true;
                Nocmd.Visible = true;
                NoDA.Visible = true;
                REMARQUETXT.Visible = true;
                Button1.Visible = true;
            }
            else
            { QTEDA.Visible = false;
            Nocmd.Visible = false;
            NoDA.Visible = false;
            REMARQUETXT.Visible = false;
            Button1.Visible = false;
            }
        }

        protected void cloture_Click(object sender, EventArgs e)
        {

        }
        private void ModifierStatutDemande(string id, string statut)
        {
            SqlCeCommand cmd = new SqlCeCommand(
                "UPDATE DemandeB SET etatDB = @etatDB WHERE id = @id",
                DBConnection.GetConnection()
            );

            cmd.Parameters.AddWithValue("@etatDB", statut);
            cmd.Parameters.AddWithValue("@id", id);

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }
        protected void btnValiderDA_Click(object sender, EventArgs e)
        {
            if (Request.Params["id"] != null)
            {
                ModifierStatutDemande(Request.Params["id"], "V");
                Response.Redirect("DA_VALIDATION.aspx");
            }
        }

        protected void btnRefuserDA_Click(object sender, EventArgs e)
        {
            if (Request.Params["id"] != null)
            {
                ModifierStatutDemande(Request.Params["id"], "R");
                Response.Redirect("DA_VALIDATION.aspx");
            }
        }
       


    }

}