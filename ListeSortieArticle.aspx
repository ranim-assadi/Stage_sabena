<%@ Page Title="" Language="C#" MasterPageFile="~/MAGASIN.Master"
AutoEventWireup="true" CodeBehind="ListeSortieArticle.aspx.cs"
Inherits="sabena.ListeSortieArticle" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    	 
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


<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder2"
    runat="server">



    <h2>Liste Sortie Articles</h2>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">




<div class="container">

    <!-- FILTRES -->
    <div class="row">

        <!-- DATE DEBUT -->
        <div class="col-md-3">
            <label>Date début</label>

            <asp:TextBox ID="txtDateDebut"
                runat="server"
                TextMode="Date"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- DATE FIN -->
        <div class="col-md-3">
            <label>Date fin</label>

            <asp:TextBox ID="txtDateFin"
                runat="server"
                TextMode="Date"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- ARTICLE -->
        <div class="col-md-3">
            <label>Article</label>

            <asp:DropDownList ID="ddlArticle"
                runat="server"
                CssClass="form-control">
            </asp:DropDownList>
        </div>

        <!-- DEMANDEUR -->
        <div class="col-md-3">

            <label>Demandeur</label>

            <!-- NOM -->
            <asp:TextBox ID="TXT_DEMANDEUR"
                runat="server"
                CssClass="form-control"
                list="listeEmployes"
                autocomplete="off"
                placeholder="Tapez un nom..."
                onchange="setEmployeId()">
            </asp:TextBox>

            <!-- ID CACHE -->
            <asp:HiddenField ID="HF_DEMANDEUR_ID"
                runat="server" />

            <!-- LISTE AUTO COMPLETE -->
            <datalist id="listeEmployes">

                <%
                    System.Data.DataTable dtEmp =
                        DALDB.GetDatat(
                        "SELECT Stampnum, NOM, PRENOM FROM Mecanicien ORDER BY NOM");

                    foreach (System.Data.DataRow row in dtEmp.Rows)
                    {
                        string nom =
                            row["NOM"].ToString() + " " +
                            row["PRENOM"].ToString();

                        string id =
                            row["Stampnum"].ToString();
                %>

                    <option
                        value="<%= nom %>"
                        data-id="<%= id %>">
                    </option>

                <%
                    }
                %>

            </datalist>

        </div>

    </div>

    <br />

    <!-- LIGNE 2 -->
    <div class="row">

        <!-- AVION -->
        <div class="col-md-3">

            <label>Avion</label>

            <!-- AVION -->



    <!-- TEXTBOX -->
    <asp:TextBox ID="txtAvion"
        runat="server"
        CssClass="form-control"
        list="listeAvions"
        autocomplete="off"
        placeholder="Tapez un avion...">
    </asp:TextBox>

    <!-- LISTE AUTO COMPLETE -->
    <datalist id="listeAvions">

        <%
            System.Data.DataTable dtAvion =
                DALDB.GetDatat(
                "SELECT MSN, Designation FROM AC ORDER BY Designation");

            foreach (System.Data.DataRow row in dtAvion.Rows)
            {
                string avion =
                    row["Designation"].ToString();

                string msn =
                    row["MSN"].ToString();
        %>

            <option
                value="<%= avion %>"
                data-msn="<%= msn %>">
            </option>

        <%
            }
        %>

    </datalist>



        </div>

        <!-- BUTTON FILTER -->
        <div class="col-md-3" style="margin-top:25px;">

            <asp:Button ID="btnFilter"
                runat="server"
                Text="Filtrer"
                CssClass="btn btn-primary"
                OnClick="btnFilter_Click" />

        </div>

        <!-- EXPORT -->
        <div class="col-md-3" style="margin-top:25px;">

            <asp:Button ID="btnExport"
                runat="server"
                Text="Export Excel"
                CssClass="btn btn-success"
                OnClick="btnExport_Click" />

        </div>

    </div>

    <hr />

    <!-- GRID -->
    <asp:GridView ID="gvSortie"
        runat="server"
        class="table table-striped table-bordered table-hover table-full-width sample_1"
        AutoGenerateColumns="true">
    </asp:GridView>

</div>


<!-- JAVASCRIPT -->
<script>

    function setEmployeId() {

        var input =
            document.getElementById('<%= TXT_DEMANDEUR.ClientID %>');

        var hidden =
            document.getElementById('<%= HF_DEMANDEUR_ID.ClientID %>');

        var options =
            document.getElementById('listeEmployes').options;

        hidden.value = "";

        for (var i = 0; i < options.length; i++) {

            if (options[i].value === input.value) {

                hidden.value =
                    options[i].getAttribute("data-id");

                break;
            }
        }
    }

</script>

</asp:Content>