<%@ Page Title="" Language="C#" MasterPageFile="~/ADM.Master" AutoEventWireup="true" CodeBehind="Affiche.aspx.cs" Inherits="sabena.affiche" %>
	


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h1>Traitement de demande Besoin</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="well well-lg">
          <center>
          <table width="90%" height="150px">
              <tr>
                  <td>
                 Num Demande : <strong>    <asp:Label ID="NDBtxt" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
                Désignation :<strong>  <asp:Label ID="Designtxt" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                    <td>
                        PN :<strong> <asp:Label ID="PNTXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
                       SN : <strong> <asp:Label ID="SNtxt" runat="server" Text="Label"></asp:Label></strong>
                  </td>
              </tr>
                <tr>
                  <td>
                      A/C : <strong> <asp:Label ID="ACTXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
QTE : <strong> <asp:Label ID="QTETXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                    <td>
Démandeur : <strong> <asp:Label ID="Demandeurtxt" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
Département :<strong>  <asp:Label ID="DEPTTXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
              </tr>
                <tr>
                  <td>
                      OE : <strong> <asp:Label ID="OETXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
DATE :<strong>  <asp:Label ID="DATETXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                    <td>
DATE Besoin :<strong>  <asp:Label ID="datedesoinTXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
                   <td>
Remaining : <strong> <asp:Label ID="REMTXT" runat="server" Text="Label"></asp:Label></strong>
                  </td>
              </tr>
              <tr>
                  <td>

                      Pièce jointe : <asp:HyperLink ID="linkurl" runat="server">HyperLink</asp:HyperLink>
                    
                  </td>

              </tr>
          </table>
          </center>
          </div>

    <div>
        <asp:Panel ID="Panel4" runat="server">

<div class="demo-main">
										<div id="inline-container">
										
     

            <table width="50%">
            <tr>
                  <td ><asp:Panel ID="Panel2" runat="server">
							
                    <asp:CheckBox ID="Stockchk"  runat="server" AutoPostBack="true" OnCheckedChanged="Stockchk_CheckedChanged" ></asp:CheckBox>
                       </asp:Panel>
                 
                </td>
                   <td >
                  	
 <asp:Label ID="Label2" runat="server" Text=" EN STOCK"></asp:Label>
                   
                   </td>
               
                   <td >
                       <asp:TextBox ID="QTESTK" runat="server"  class="form-control" placeholder="Quantité en Stock"  ></asp:TextBox>
                   </td>
                </tr>
                </table>
<br />
              <table width="70%" >
                  <tr>
                     
                  <td> <asp:Panel ID="Panel3" runat="server">
							
                    <asp:CheckBox ID="DAchk"  runat="server" AutoPostBack="true" OnCheckedChanged="DAchk_CheckedChanged" ></asp:CheckBox>
                       </asp:Panel>
                   
                </td>
                   <td>
                    
                 <asp:Label ID="Label3" runat="server" Text=" Demande Achat"></asp:Label>
                       
                   </td>
               
                   <td>
                       <asp:TextBox ID="QTEDA"  Width="200" runat="server"  class="form-control" placeholder="Quantité DA"  ></asp:TextBox>
                   </td>
                      <td>
                       <asp:TextBox ID="NoDA" runat="server"  class="form-control" placeholder="Numéro DA" Width="200"></asp:TextBox>
                   </td>
                         <td>
                       <asp:TextBox ID="Nocmd" runat="server" Width="200" class="form-control" placeholder="Numéro Commande" ></asp:TextBox>
                   </td>
                 
            </tr>
        </table>
                                                <br />
    <table width="40%">
        <tr><td>
               <asp:TextBox ID="REMARQUETXT" runat="server"  placeholder= "Remarque"  TextMode="MultiLine" Height="80" Width="300"></asp:TextBox>
                </td>
                <td >
                    <asp:Button ID="Button1" class="btn btn-primary"  Text="traiter" OnClick="Button1_Click" Height="70" Width="100px"   runat="server" />
                   </td>
            <td>

                 &nbsp;</td>
        </tr>
    </table>

    </div></div>
            
            </asp:Panel>
            </div>
     
        <center>
   <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="La Quantité en stock est obligatoire pour traiter la demande !" ControlToValidate="QTESTK" ForeColor="Red"></asp:RequiredFieldValidator>
           <br />   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="La Quantité de DA est obligatoire pour traiter la demande !" ControlToValidate="QTEDA" ForeColor="Red"></asp:RequiredFieldValidator>

          <br />    <asp:CompareValidator ID="CompareValidator2" runat="server" Operator="DataTypeCheck" Type="Integer" 
 ControlToValidate="QTESTK" ErrorMessage="La quantité en stock doit être un entier !" ForeColor="Red"/>
      
       <br />
        <asp:CompareValidator ID="CompareValidator1" runat="server" Operator="DataTypeCheck" Type="Integer" 
 ControlToValidate="QTEDA" ErrorMessage="La quantité Demandé doit être un entier !" ForeColor="Red"/>
      
    </center>
    <br />

<asp:Button ID="btnValiderDA" runat="server"
    Text="Valider la demande"
    CssClass="btn btn-success"
    OnClick="btnValiderDA_Click" />

&nbsp;

<asp:Button ID="btnRefuserDA" runat="server"
    Text="Refuser la demande"
    CssClass="btn btn-danger"
    OnClick="btnRefuserDA_Click" />

<br />
<br />


        
        <asp:GridView id="gv"  runat="server" class="table table-striped table-bordered table-hover table-full-width sample_1"  AutoGenerateColumns="False"    style="text-align: center" Font-Size="Small" width="100%"
      
           >
  
            <Columns>

               
                  <asp:TemplateField HeaderText="EN STOCK">
         <ItemTemplate>
            <asp:Image runat="server" ID="imgOnSale" ImageAlign="AbsMiddle" 
               ImageUrl='<%#etatimageSTK(Eval("ESTK"))%>' />
         </ItemTemplate>

         <HeaderStyle HorizontalAlign="Center" />
         <ItemStyle HorizontalAlign="Center" />
      </asp:TemplateField>
                    <asp:BoundField DataField="QTESTK" HeaderText="QTE STOCK"  />

                       <asp:TemplateField HeaderText="DA">
         <ItemTemplate>
            <asp:Image runat="server" ID="imgOnSale" ImageAlign="AbsMiddle" 
               ImageUrl='<%#etatimageDA(Eval("EDA"))%>' />
         </ItemTemplate>

         <HeaderStyle HorizontalAlign="Center" />
         <ItemStyle HorizontalAlign="Center" />
      </asp:TemplateField>
                    <asp:BoundField DataField="QTEDA" HeaderText="QTE DA"  />
                
                <asp:BoundField DataField="NODA" HeaderText="No DA"  />
                    <asp:BoundField DataField="NOCMD" HeaderText="No Commande"  />

                
                <asp:BoundField DataField="REMARQUE" HeaderText="REMARQUE" />
                 <asp:BoundField DataField="date" HeaderText="DATE" />
       
                             
                        
          
            </Columns>
            <EmptyDataTemplate>
            Aucun traitement fait !
            </EmptyDataTemplate>
            <HeaderStyle Font-Size="Medium" />
            <RowStyle Font-Size="Medium" />
        </asp:GridView>



</div>
<div>
    
       <asp:Panel ID="Panel1" Visible="false" runat="server">  <div class="alert alert-success">
										<button data-dismiss="alert" class="close">
											×
										</button>
										<i class="fa fa-check-circle"></i>
										<strong> <asp:Label ID="Label1"  runat="server" Text="Label" ForeColor="Black"></asp:Label>!</strong> 
									</div>


       
         </asp:Panel>
                
                   

</div>
</asp:Content>

    
      
    
