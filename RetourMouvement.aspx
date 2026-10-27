<%@ Page Title="" Language="C#" MasterPageFile="~/MAGASIN.Master" AutoEventWireup="true" CodeBehind="RetourMouvement.aspx.cs" Inherits="sabena.RetourMouvement" %>
	
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    	 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		<!--<![endif]-->
		<script src="assets/plugins/jquery-ui/jquery-ui-1.10.2.custom.min.js"></script>
		<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script src="assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"></script>
		<script src="assets/plugins/blockUI/jquery.blockUI.js"></script>
		<script src="assets/plugins/iCheck/jquery.icheck.min.js"></script>
		<script src="assets/plugins/perfect-scrollbar/src/jquery.mousewheel.js"></script>
		<script src="assets/plugins/perfect-scrollbar/src/perfect-scrollbar.js"></script>
		<script src="assets/plugins/less/less-1.5.0.min.js"></script>
		<script src="assets/plugins/jquery-cookie/jquery.cookie.js"></script>
		<script src="assets/plugins/bootstrap-colorpalette/js/bootstrap-colorpalette.js"></script>
		<script src="assets/js/main.js"></script>
		<!-- end: MAIN JAVASCRIPTS -->
		<!-- start: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
		<script src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
		<script src="assets/plugins/autosize/jquery.autosize.min.js"></script>
		<script src="assets/plugins/select2/select2.min.js"></script>
		<script src="assets/plugins/jquery.maskedinput/src/jquery.maskedinput.js"></script>
		<script src="assets/plugins/jquery-maskmoney/jquery.maskMoney.js"></script>
		<script src="assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script src="assets/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
		<script src="assets/plugins/bootstrap-daterangepicker/moment.min.js"></script>
		<script src="assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
		<script src="assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
		<script src="assets/plugins/bootstrap-colorpicker/js/commits.js"></script>
		<script src="assets/plugins/jQuery-Tags-Input/jquery.tagsinput.js"></script>
		<script src="assets/plugins/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
		<script src="assets/plugins/summernote/build/summernote.min.js"></script>
		<script src="assets/plugins/ckeditor/ckeditor.js"></script>
		<script src="assets/plugins/ckeditor/adapters/jquery.js"></script>
		<script src="assets/js/form-elements.js"></script>
    	<link href="assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css"/>
		<link href="assets/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
      <link rel="stylesheet" href="assets/css/main-responsive.css">


              
       


      <script type="text/javascript">
          $(function () {
              $(".sample_1").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
          });
		</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h1>Liste des outils retournés</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <asp:Panel ID="Panel3" runat="server" Width="100%">
          
                    <div class="well well-lg ">      
          
            date debut :               <asp:TextBox ID="datedebut"  textmode="Date" CausesValidation="False"  data-date-format="yyyy-mm-dd" data-date-viewmode="years"  runat="server" Width="150px"  ></asp:TextBox>
                &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;      &nbsp;&nbsp;  &nbsp;&nbsp; 
                         date fin : <asp:TextBox ID="datefin"  textmode="Date"  CausesValidation="False"  data-date-format="yyyy-mm-dd" data-date-viewmode="years"  runat="server" Width="150px"  ></asp:TextBox>
                  
      avion :     <asp:DropDownList ID="acdt1" AppendDataBoundItems="true" runat="server" Height="35px"  AutoPostBack="True"  DataSourceID="SqlDataSource1" DataTextField="Designation" DataValueField="MSN" OnTextChanged="ACtxt_TextChanged" Width="150px" OnSelectedIndexChanged="ACtxt_SelectedIndexChanged" >
           <asp:ListItem Text="Tous" Value="Tous" />

                  </asp:DropDownList>
             

      <asp:LinkButton ID="chercher1" runat="server" class="btn btn-info pull-right" OnClick="chercher_click" >
                                Trie Par date <i class="fa  clip-search-2"></i>
                          
  &nbsp;  &nbsp;     </asp:LinkButton>

                        <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-green  pull-right " OnClick="btndate_Click11" >
                                Export EXCEL par DATE <i class="fa  clip-file-excel"></i>
                            </asp:LinkButton>


                        <asp:LinkButton ID="btndate_Click1" runat="server" class="btn btn-green  pull-right " OnClick="btndate_Click" >
                                Export EXCEL par DATE <i class="fa  clip-file-excel"></i>
                            </asp:LinkButton>
                        
                    
                

                    </div>
             
      
                    <div class="well well-lg ">      
    <asp:SqlDataSource ID="SqlDataSource1"  runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [Designation], [MSN] FROM [AC]"></asp:SqlDataSource>
                       
        

Avion :  <asp:DropDownList ID="ACtxt" runat="server" Height="35px"  AutoPostBack="True"  DataSourceID="SqlDataSource1" DataTextField="Designation" DataValueField="MSN" OnTextChanged="ACtxt_TextChanged" Width="150px" OnSelectedIndexChanged="ACtxt_SelectedIndexChanged" ></asp:DropDownList>
             &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;      &nbsp;&nbsp;  &nbsp;&nbsp;                   
 BV  :  <asp:DropDownList Width="150px" ID="BVDROP" runat="server" Height="35px"    ></asp:DropDownList>

          <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-info pull-right" OnClick="triBV_click" >
                                Trie Par BV <i class="fa  clip-search-2"></i>
                            </asp:LinkButton>
   </div>
                  
        </asp:Panel>


        <asp:GridView id="gv"  runat="server" class="table table-striped table-bordered table-hover table-full-width sample_1"  AutoGenerateColumns="False"  onrowcommand="GridView1_RowCommand"  style="text-align: center" Font-Size="Small" width="100%"
      
           >
  
            <Columns>
                 <asp:BoundField DataField="idmouv"  HeaderText="IDMOUV" />
                <asp:BoundField DataField="designation" HeaderText="Désignation" />
               
                 <asp:BoundField DataField="PN" HeaderText="PN" />
                <asp:BoundField DataField="SN" HeaderText="SN"  ControlStyle-Width="25px" />
                <asp:BoundField DataField="nnoe" HeaderText="NO OE"  ControlStyle-Width="25px" />
                    <asp:BoundField DataField="Qtesortie" HeaderText="Qte Sortie" />
                 <asp:BoundField DataField="datemv" HeaderText="Date sortie" /> 
                <asp:BoundField DataField="heuresortie" HeaderText="H/S" /> 
                  <asp:BoundField DataField="dateretour" HeaderText="Date retour" />              
                  <asp:BoundField DataField="heureRetour" HeaderText="H/R" />
                           <asp:BoundField DataField="ACdesig" HeaderText="ATE/AC" />
                           <asp:BoundField DataField="nom" HeaderText="N/MAG" />         
                  <asp:BoundField DataField="nommeca" HeaderText="Mécanicien" />
              
            </Columns>
            <EmptyDataTemplate>
               Aucun enregistrement n'a été trouvé!
            </EmptyDataTemplate>
            <HeaderStyle Font-Size="Medium" />
            <RowStyle Font-Size="Medium" />
        </asp:GridView>
  
           
    <asp:LinkButton class="btn btn-primary" ID="Imprimer" runat="server" OnClick="Imprimer_Click"><i class="fa fa-print"></i>  Imprimer</asp:LinkButton>
                   
    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>

</asp:Content>
