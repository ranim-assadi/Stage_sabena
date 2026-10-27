<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MAGASIN.Master" CodeBehind="Consultarticle.aspx.cs" Inherits="sabena.Consultarticle" %>

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
    
     
 <h1>Consultation des Articles </h1>
   
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


   		<div class="panel panel-default">
								<div class="panel-heading">
									<i class="fa fa-external-link-square"></i>
									Liste des Articles
									<div class="panel-tools">
									
									
										<a class="btn btn-xs btn-link panel-refresh" href="ConsultDB.aspx">
											<i class="fa fa-refresh"></i>
										</a>
										
										<a class="btn btn-xs btn-link panel-close" href="#">
											<i class="fa fa-times"></i>
										</a>
									</div>
								</div>
								<div class="panel-body">
 
 
                                   
        <asp:GridView 
    id="gv"  
    runat="server"
    AutoGenerateColumns="False"
    OnRowCommand="GridView1_RowCommand"
    OnRowDataBound="GridView1_RowDataBound"
    class="table table-striped table-bordered table-hover sample_1">

    <Columns>

        <asp:BoundField DataField="id" HeaderText="ID" />

        <asp:BoundField DataField="Designationarticle" HeaderText="Designation" />

        <asp:BoundField DataField="QTE" HeaderText="QTE" />

        <asp:BoundField 
            DataField="prixunitaire"
            HeaderText="Prix"
            DataFormatString="{0:0.00}" />

        <asp:BoundField DataField="stockmin" HeaderText="Stock Min" />
        <asp:BoundField DataField="stockmax" HeaderText="Stock Max" />
        <asp:BoundField DataField="fournisseur" HeaderText="Fournisseur" />
        <asp:BoundField DataField="dateentrer" HeaderText="Date" />
        <asp:BoundField DataField="name" HeaderText="Magasinier" />

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>

                <asp:LinkButton 
                    ID="MODIFIER"
                    CommandName="modifier"
                    CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                    runat="server"
                    CssClass="btn btn-xs btn-blue">
                    Modifier
                </asp:LinkButton>

                <asp:LinkButton 
                    ID="SUPPRIMER"
                    CommandName="Supprimer"
                    CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                    runat="server"
                    CssClass="btn btn-xs btn-red"
                    OnClientClick="return confirm('Supprimer ?');">
                    Supprimer
                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
  
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [PN], [SN], [DESIGNATION], [QTE], [OE], [VISITE], [Demandeur], [DATE] FROM [DemandeB]" ></asp:SqlDataSource>
                    
                                            
 </div></div>
             

     



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

