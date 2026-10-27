using System;
using System.Data.SqlServerCe;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web.UI;

namespace sabena
{
    public partial class printmeca : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBadge();
            }
        }

        private void LoadBadge()
        {
            SqlCeConnection conn = null;

            try
            {
                if (string.IsNullOrEmpty(Request.Params["id"]))
                    return;

                string mecanicienId = Request.Params["id"].ToString().Trim();

                int idNum;
                if (!int.TryParse(mecanicienId, out idNum))
                    return;

                time.Text = "Émis le " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");

                string query =
                    "SELECT Stampnum, nom, prenom " +
                    "FROM mecanicien " +
                    "WHERE stampnum = @id";

                conn = DBConnection.GetConnection();
                SqlCeCommand cmd = new SqlCeCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", idNum);

                conn.Open();
                SqlCeDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    string code = dr["Stampnum"].ToString();
                    string nom = dr["nom"].ToString();
                    string prenom = dr["prenom"].ToString();

                    IDtxt.Text = code;
                    nomtxt.Text = nom.ToUpper() + " ";
                    PrenomTXT.Text = prenom;

                    // Code-barres
                    imgBarcode.ImageUrl = GenerateCompactBarcode(code);
                    imgBarcode.Style["display"] = "block";

                    // QR Code
                    string qrData = code;
                    imgQR.ImageUrl =
                        "https://api.qrserver.com/v1/create-qr-code/?size=100x100&margin=2&data=" +
                        Server.UrlEncode(qrData);

                    dr.Close();
                }
                else
                {
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur: " + ex.Message);
            }
            finally
            {
                if (conn != null && conn.State == System.Data.ConnectionState.Open)
                    conn.Close();
            }
        }

        private string GenerateCompactBarcode(string code)
        {
            try
            {
                int width = 220;
                int height = 50;

                using (Bitmap bmp = new Bitmap(width, height))
                using (Graphics g = Graphics.FromImage(bmp))
                {
                    g.Clear(Color.White);
                    g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.None;

                    int x = 15;
                    int barWidth = 2;
                    int barHeight = 32;
                    int startY = 4;

                    string barcodeData = "*" + code + "*";

                    foreach (char c in barcodeData)
                    {
                        int value = (int)c;

                        for (int i = 0; i < 6; i++)
                        {
                            if ((value * 13 + i * 7) % 2 == 0)
                            {
                                g.FillRectangle(Brushes.Black, x, startY, barWidth, barHeight);
                            }
                            x += barWidth + 1;
                        }
                        x += 2;
                    }

                    using (Font font = new Font("Consolas", 8, FontStyle.Regular))
                    {
                        StringFormat sf = new StringFormat();
                        sf.Alignment = StringAlignment.Center;
                        g.DrawString(code, font, Brushes.Black, width / 2, startY + barHeight + 3, sf);
                    }

                    using (MemoryStream ms = new MemoryStream())
                    {
                        bmp.Save(ms, ImageFormat.Png);
                        return "data:image/png;base64," + Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}