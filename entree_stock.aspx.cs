using System;
using System.Data;
using System.Data.SqlServerCe;
using System.Web.UI.WebControls;

namespace sabena
{
    public partial class entree_stock : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadGrid();
        }

        private void LoadGrid()
        {
            SqlCeConnection conn = DBConnection.GetConnection();
            conn.Open();

            SqlCeCommand cmd = new SqlCeCommand(@"
                SELECT ID, DesignationARTICLE, StockActuel, Prixunitaire
                FROM ARTICLE", conn);

            SqlCeDataAdapter da = new SqlCeDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvStock.DataSource = dt;
            gvStock.DataBind();

            conn.Close();
        }
        protected void gvStock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ENTREE")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;

                TextBox txtQte = (TextBox)row.FindControl("TXT_QTE");

                int qte = 0;
                int.TryParse(txtQte.Text, out qte);

                if (qte <= 0) return;

                SqlCeConnection conn = DBConnection.GetConnection();
                conn.Open();

                SqlCeCommand cmd = new SqlCeCommand(@"
            UPDATE ARTICLE
            SET StockActuel = StockActuel + @qte
            WHERE ID = @id", conn);

                cmd.Parameters.Add("@qte", qte);
                cmd.Parameters.Add("@id", id);

                cmd.ExecuteNonQuery();

                SqlCeCommand hist = new SqlCeCommand(@"
            INSERT INTO STOCK_MOUVEMENT
            (IDArticle, TypeMouvement, Quantite, DateMouvement)
            VALUES (@id, 'ENTREE', @qte, @date)", conn);

                hist.Parameters.Add("@id", id);
                hist.Parameters.Add("@qte", qte);
                hist.Parameters.Add("@date", DateTime.Now);

                hist.ExecuteNonQuery();

                conn.Close();

                LoadGrid();
            }
        }
  
    }
}