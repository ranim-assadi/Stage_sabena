using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlServerCe;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;

using System.IO;
using System.Drawing;
using OfficeOpenXml;
using OfficeOpenXml.Style; 

namespace sabena
{
    public partial class listeMouvement : System.Web.UI.Page
    {
   
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label mpLabel = (Label)Page.Master.FindControl("PAGETXT");
                mpLabel.Text = "outillage sortie";
                string str1 = "SELECT  MouvementOutillage.idmouv,outillage.remarque,outillage.Designation,outillage.id, outillage.PN, outillage.SN, MouvementOutillage.QteSortie,CONVERT(nvarchar, MouvementOutillage.dateMouvement,103) AS datemv, MouvementOutillage.heureSortie, AC.Designation AS ACdesig, Utilisateur.NOM +' '+Utilisateur.prenom as nom , Mecanicien.NOM +' '+ Mecanicien.prenom as nommeca FROM MouvementOutillage INNER JOIN Utilisateur ON MouvementOutillage.IDmagasin = Utilisateur.ID INNER JOIN  Mecanicien ON MouvementOutillage.IDmecanicien = Mecanicien.Stampnum INNER JOIN outillage ON MouvementOutillage.IDoutillage = outillage.ID INNER JOIN  AC ON MouvementOutillage.IDAC = AC.MSN and heureRetour =''";
                DataSet ds = DALDB.GetData(str1);
                if (ds.Tables.Count > 0)
                {
                    gv1.DataSource = ds;
                    gv1.DataBind();
                //    gv1.Columns[0].Visible = false;

                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
                if (e.CommandName == "modifier")
                    {
                        int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gv1.Rows[index];
                    string b = row.Cells[0].Text;
                    
                   
                    this.Response.Redirect("RetourOutillage.aspx?Usemode=Update&id=" + b);
                    
                    }
                else if (e.CommandName == "ADDOE")
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gv1.Rows[index];
                    string b = row.Cells[0].Text;


                    this.Response.Redirect("ADDOE.aspx?Usemode=Update&id=" + b);

                }
        }

  


        public override void VerifyRenderingInServerForm(Control control)
        {
            //   return;
        }



        protected void btndate_Click1(object sender, EventArgs e)
        {


            using (SqlCeCommand cmd = new SqlCeCommand("SELECT  outillage.Designation, outillage.PN, outillage.SN, MouvementOutillage.QteSortie,CONVERT(nvarchar, MouvementOutillage.dateMouvement,103) AS datemv, CONVERT(nvarchar, MouvementOutillage.dateretour,103) AS dateretour,MouvementOutillage.heureSortie,MouvementOutillage.heureRetour, AC.Designation AS ACdesig, Utilisateur.NOM +' '+Utilisateur.prenom as nom , Mecanicien.NOM +' '+ Mecanicien.prenom as nommeca FROM MouvementOutillage INNER JOIN Utilisateur ON MouvementOutillage.IDmagasin = Utilisateur.ID INNER JOIN  Mecanicien ON MouvementOutillage.IDmecanicien = Mecanicien.Stampnum INNER JOIN outillage ON MouvementOutillage.IDoutillage = outillage.ID INNER JOIN  AC ON MouvementOutillage.IDAC = AC.MSN and heureRetour =''"))
            {
                SqlCeDataAdapter sda = new SqlCeDataAdapter();

                cmd.Connection = DBConnection.GetConnection();
                DBConnection.GetConnection().Open();
                sda.SelectCommand = cmd;

                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    string path = Server.MapPath("Files\\");

                    if (!Directory.Exists(path))   // CHECK IF THE FOLDER EXISTS. IF NOT, CREATE A NEW FOLDER.
                    {
                        Directory.CreateDirectory(path);
                    }

                    File.Delete(path + "Liste des outils non retournés.xlsx"); // DELETE THE FILE BEFORE CREATING A NEW ONE.

                    ExcelPackage excel = new ExcelPackage();
                    var workSheet = excel.Workbook.Worksheets.Add("Sheet1");
                    workSheet.TabColor = System.Drawing.Color.Black;
                    workSheet.DefaultRowHeight = 12;

                    //  ADD A WORKSHEET.
                    workSheet.Row(1).Height = 20;
                    workSheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    workSheet.Row(1).Style.Font.Bold = true;
                    workSheet.Cells[1, 1].Value = "Designation";
                    workSheet.Cells[1, 2].Value = "PN";
                    workSheet.Cells[1, 3].Value = "SN";
                    workSheet.Cells[1, 4].Value = "Qte sortie ";
                    workSheet.Cells[1, 5].Value = "Heure Sortie";
                    workSheet.Cells[1, 6].Value = "DATE Sortie";
                    workSheet.Cells[1, 7].Value = "DATE Retour";
                    workSheet.Cells[1, 8].Value = "Heure Retour";
                    workSheet.Cells[1, 9].Value = "ATE/AC";
                    workSheet.Cells[1, 10].Value = "Nom Magasinier";
                    workSheet.Cells[1, 11].Value = "Nom Mécanicier";

                    //Body of table  
                    //  
                    int recordIndex = 2;


                    int i;
                    for (i = 0; i <= dt.Rows.Count - 1; i++)
                    {

                        workSheet.Cells[recordIndex, 1].Value = dt.Rows[i].Field<string>("Designation");
                        workSheet.Cells[recordIndex, 2].Value = dt.Rows[i].Field<string>("pn");
                        workSheet.Cells[recordIndex, 3].Value = dt.Rows[i].Field<string>("sn");
                        workSheet.Cells[recordIndex, 4].Value = dt.Rows[i].Field<string>("QteSortie");
                        workSheet.Cells[recordIndex, 5].Value = dt.Rows[i].Field<string>("heureSortie");
                        workSheet.Cells[recordIndex, 6].Value = dt.Rows[i].Field<string>("datemv");
                        workSheet.Cells[recordIndex, 7].Value = dt.Rows[i].Field<string>("dateretour");
                        workSheet.Cells[recordIndex, 8].Value = dt.Rows[i].Field<string>("heureRetour");
                        workSheet.Cells[recordIndex, 9].Value = dt.Rows[i].Field<string>("ACdesig");
                        workSheet.Cells[recordIndex, 10].Value = dt.Rows[i].Field<string>("nom");
                        workSheet.Cells[recordIndex, 11].Value = dt.Rows[i].Field<string>("nommeca");



                        recordIndex++;

                    }

                    // FINALLY, FORMAT THE EXCEL SHEET USING EXCEL'S AUTOFORMAT FUNCTION.
                    workSheet.Column(1).AutoFit();
                    workSheet.Column(2).AutoFit();
                    workSheet.Column(3).AutoFit();
                    workSheet.Column(4).AutoFit();
                    workSheet.Column(5).AutoFit();
                    workSheet.Column(6).AutoFit();
                    workSheet.Column(7).AutoFit();
                    workSheet.Column(8).AutoFit();
                    workSheet.Column(9).AutoFit();
                    workSheet.Column(10).AutoFit();
                    workSheet.Column(11).AutoFit();




                    string excelName = "liste Des outillage non retournés ";
                    using (var memoryStream = new MemoryStream())
                    {
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment; filename=" + excelName + ".xlsx");
                        excel.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();

                        Label2.Text = "Data Exported Successfully";
                        Label2.Attributes.Add("style", "color:green; font: normal 14px Verdana;");
                        Label2.Attributes.Add("style", "display:block");
                        Label2.Attributes.Add("style", "display:block");
                        Label2.Visible = true;
                        string sPath = Server.MapPath("Files\\");

                        Response.AppendHeader("Content-Disposition", "attachment; filename=liste outillage non retourne.xlsx");
                        Response.TransmitFile(sPath + "listoutillageNoretour.xlsx");
                        Response.End();
                    }
                }
            }

        }

        protected void Imprimer_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gv1.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(iTextSharp.text.PageSize.A4.Rotate(), 10, 10, 10, 10);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

                    pdfDoc.Open();
                    pdfDoc.Add(new Paragraph("  \n"));



                    Paragraph p = new Paragraph(" Liste des outillages non Retournés");
                    p.Alignment = Element.ALIGN_CENTER;
                    pdfDoc.Add(p);
                    pdfDoc.Add(new Paragraph("  \n"));





                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=ListeOutillage_noRETOUR.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }

        }

    

 

        }



}


 