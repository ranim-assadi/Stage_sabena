<%@ Page Title="Validation DA" Language="C#" MasterPageFile="~/superadmin.Master" AutoEventWireup="true" CodeBehind="DA_VALIDATION.aspx.cs" Inherits="sabena.DA_VALIDATION" %>

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

      


              
            	<script type="text/javascript" src="assets/plugins/select2/select2.min.js"></script>
		<script type="text/javascript" src="assets/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/plugins/DataTables/media/js/DT_bootstrap.js"></script>
		<script src="assets/js/table-data.js"></script>



      <script type="text/javascript">
          $(function () {
              $(".sample_1").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
          });
		</script>

</asp:Content>




<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
     
 <h1>Validation des demandes d'achats en attente</h1>
<a href="DA_HISTORIQUE_ADMIN.aspx" class="btn btn-primary">Historique validations</a>
    <br />
    <br />

   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     
   
            
     <asp:ScriptManager ID="ScriptManager1" runat="server">

          
</asp:ScriptManager>

     
    <asp:Panel ID="Panel1" Visible="false" runat="server">
   <div class="alert alert-warning">
										<button data-dismiss="alert" class="close">
											×
										</button>
										<i class="fa fa-exclamation-triangle"></i>
										<strong>Warning ! </strong> Vous ne pouvez pas modifier ou supprimer les demandes valider !.
									</div>
    </asp:Panel>


   	
           <div class="well well-lg">


        <asp:GridView ID="gv" runat="server"
    CssClass="table table-striped table-bordered table-hover table-full-width sample_1"
    AutoGenerateColumns="False"
    OnRowCommand="GridView1_RowCommand"
    Style="text-align: center"
    Font-Size="Small"
    Width="100%">

    <Columns>
        <asp:BoundField DataField="IDDA" HeaderText="ID" />
        <asp:BoundField DataField="NumeroDA" HeaderText="N° DA" />
        <asp:BoundField DataField="DateDA" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
        <asp:BoundField DataField="Demandeur" HeaderText="Demandeur" />
        <asp:BoundField DataField="Service" HeaderText="Service" />
        <asp:BoundField DataField="Statut" HeaderText="Statut" />
        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:N3}" />

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>

        <asp:HyperLink ID="btnConsulter" runat="server"
                CssClass="btn btn-xs btn-primary"
                NavigateUrl='<%# "DA_DETAIL_ADMIN.aspx?id=" + Eval("IDDA") %>'
                Text="Consulter">
        </asp:HyperLink>

                <asp:LinkButton ID="btnValider" runat="server"
                    CssClass="btn btn-xs btn-success"
                    CommandName="valider"
                    CommandArgument='<%# Eval("IDDA") %>'
                    Text="Valider">
                </asp:LinkButton>

                <asp:LinkButton ID="btnRefuser" runat="server"
                    CssClass="btn btn-xs btn-danger"
                    CommandName="refuser"
                    CommandArgument='<%# Eval("IDDA") %>'
                    Text="Refuser">
                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>
    </Columns>

    <EmptyDataTemplate>
        Aucune demande d'achat en attente.
    </EmptyDataTemplate>

</asp:GridView>
  
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [PN], [SN], [DESIGNATION], [QTE], [OE], [VISITE], [Demandeur], [DATE] FROM [DemandeB]" ></asp:SqlDataSource>
                    
                                            

               </div>
     



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
		<script type="text/javascript" src="assets/plugins/select2/select2.min.js"></script>
		<script type="text/javascript" src="assets/plugins/DataTables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/plugins/DataTables/media/js/DT_bootstrap.js"></script>
		<script src="assets/js/table-data.js"></script>


    
   

</asp:Content>

