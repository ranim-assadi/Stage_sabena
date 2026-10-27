<%@ Page Title="" Language="C#" MasterPageFile="~/adminmaster.Master" AutoEventWireup="true" CodeBehind="Mouvement.aspx.cs" Inherits="sabena.Mouvement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h1>Ajouter une demande de Besoin</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>

   
       


        <table class="table table-striped table-bordered  table-full-width dataTable" >
            <tr>
                <td>
                    PN
                </td>
                   <td>
                       <asp:TextBox ID="PNTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
                    <td>
                    SN 
                </td>
                   <td>
                       <asp:TextBox ID="SNTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
            
                  <td>
                    DESIGNATION
                </td>
                   <td>
                       <asp:TextBox ID="DESIGTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
                    </tr>
            <tr>
                  <td>
                    QTY
                </td>
                   <td>
                       <asp:TextBox ID="QTYTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
             
                  <td>
                    CRM/CRAC
                </td>
                   <td>
                       <asp:TextBox ID="CRMTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
                  <td>
                    OE
                </td>
                   <td>
                       <asp:TextBox ID="OETXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
                 </tr>
            <tr>
                                  <td>
                    VISITE
                </td>
                   <td>
                       <asp:TextBox ID="VISITETXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
                  <td>
                    BS
                </td>
                   <td>
                       <asp:TextBox ID="BSTXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
             
                  <td>
                    DA
                </td>
                   <td>
                       <asp:TextBox ID="DATXT" class="form-control" runat="server"></asp:TextBox>
                   </td>
            </tr>

        </table>

   <center>    <asp:Button ID="Button1" runat="server" class="btn btn-primary" Text="Ajouter" OnClick="Button1_Click" />

       <br />
        <br />

        <asp:Label ID="Label1" Visible="false" runat="server" Text="Label" ForeColor="Black"></asp:Label>
       </center> 




</div>
<div>
    
      
                
                   

</div>
</asp:Content>
