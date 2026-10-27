<%@ Page Language="C#" AutoEventWireup="true"
MasterPageFile="~/MAGASIN.Master"
CodeBehind="sortie_article.aspx.cs"
Inherits="sabena.sortie_article" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<h1>Sortie de Stock</h1>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">

<!-- VALIDATION -->
<asp:ValidationSummary 
    ID="ValidationSummary1" 
    runat="server"
    CssClass="alert alert-danger"
    HeaderText="Veuillez corriger les erreurs suivantes :" />

<!-- ARTICLE -->
<div class="panel panel-info">
    <div class="panel-heading"><B>Article</B></div>
    <div class="panel-body">

        <table class="table table-bordered">
            <tr>
                <td>Désignation</td>
                <td><asp:Label ID="LBL_DESIGNATION" runat="server" /></td>
            </tr>
            <tr>
                <td>Fournisseur</td>
                <td><asp:Label ID="LBL_FOURNISSEUR" runat="server" /></td>
            </tr>
            <tr>
                <td>Stock</td>
                <td>
                    <asp:Label ID="LBL_QTE" runat="server"
                        Font-Bold="true" Font-Size="Large" ForeColor="Blue" />
                </td>
            </tr>
        </table>

    </div>
</div>

<br />

<!-- SORTIE -->
<div class="panel panel-success">
<div class="panel-heading"><b>Sortie</b></div>

<div class="panel-body">

    <!-- QUANTITE -->
    <div class="form-group">

        <label>Quantité *</label>

        <asp:TextBox ID="TXT_QTE"
            runat="server"
            CssClass="form-control"
            TextMode="Number" />

        <!-- obligatoire -->
        <asp:RequiredFieldValidator
            ID="rfvQte"
            runat="server"
            ControlToValidate="TXT_QTE"
            ErrorMessage="La quantité est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />

        <!-- quantité > 0 -->
        <asp:RangeValidator
            ID="rvQte"
            runat="server"
            ControlToValidate="TXT_QTE"
            MinimumValue="1"
            MaximumValue="999999"
            Type="Integer"
            ErrorMessage="La quantité doit être supérieure à 0."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <!-- DEMANDEUR -->
    <div class="form-group">

        <label>Demandeur *</label>

        <asp:TextBox ID="TXT_DEMANDEUR"
            runat="server"
            CssClass="form-control"
            list="listeEmployes"
            autocomplete="off"
            placeholder="Tapez nom..."
            onkeyup="checkDemandeur()" />

        <!-- obligatoire -->
        <asp:RequiredFieldValidator
            ID="rfvDemandeur"
            runat="server"
            ControlToValidate="TXT_DEMANDEUR"
            ErrorMessage="Le demandeur est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />

        <!-- demandeur valide -->
        <asp:CustomValidator
            ID="cvDemandeur"
            runat="server"
            ErrorMessage="Veuillez sélectionner un demandeur valide."
            ForeColor="Red"
            Display="Dynamic"
            ClientValidationFunction="validateDemandeur" />

        <asp:HiddenField ID="HF_DEMANDEUR_ID" runat="server" />

        <datalist id="listeEmployes">
            <asp:Repeater ID="rptEmployes" runat="server">
                <ItemTemplate>
                    <option value='<%# Eval("NomComplet") %>'
                            data-id='<%# Eval("Stampnum") %>' />
                </ItemTemplate>
            </asp:Repeater>
        </datalist>

        <!-- bouton create -->
        <div id="divNewUser" style="display:none; margin-top:10px;">
            <a href="#"
               class="btn btn-warning btn-sm"
               onclick="openCreateUserModal(); return false;">
               ➕ Créer ce demandeur
            </a>
        </div>

    </div>

    <!-- NUM DB -->
    <div class="form-group">

        <label>Num DB</label>

        <asp:TextBox ID="TXT_NUMDB"
            runat="server"
            CssClass="form-control" />
    </div>

    <!-- AVION -->
    <div class="form-group">

        <label>Avion</label>

        <asp:TextBox ID="TXT_AVION"
            runat="server"
            CssClass="form-control"
            list="listeAvions"
            autocomplete="off"
            placeholder="Tapez avion..."
            onkeyup="setAvionId()" />

        <asp:HiddenField ID="HF_AVION_ID" runat="server" />

        <datalist id="listeAvions">
            <asp:Repeater ID="rptAvions" runat="server">
                <ItemTemplate>
                    <option value='<%# Eval("Designation") %>'
                            data-id='<%# Eval("MSN") %>' />
                </ItemTemplate>
            </asp:Repeater>
        </datalist>

    </div>

    <br />

    <center>
        <asp:Button ID="BTN_SORTIR"
            runat="server"
            Text="Valider"
            CssClass="btn btn-danger btn-lg"
            OnClick="BTN_SORTIR_Click" />
    </center>

</div>
</div>

<!-- SUCCESS -->
<asp:Panel ID="PanelSuccess" runat="server" Visible="false">
    <div class="alert alert-success">
        <asp:Label ID="LBL_SUCCESS" runat="server" />
    </div>
</asp:Panel>

<!-- ERROR -->
<asp:Panel ID="PanelError" runat="server" Visible="false">
    <div class="alert alert-danger">
        <asp:Label ID="LBL_ERROR" runat="server" />
    </div>
</asp:Panel>

</div>

<!-- MODAL -->
<div id="modalCreateUser" class="modal fade" tabindex="-1">

<div class="modal-dialog modal-lg">
<div class="modal-content">

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">&times;</button>
    <h4>Créer Demandeur</h4>
</div>

<div class="modal-body" style="height:600px;">
    <iframe id="iframeCreateUser"
            style="width:100%; height:100%; border:none;"></iframe>
</div>

</div>
</div>

</div>

<!-- JS -->
<script>

    function checkDemandeur() {

        var input = document.getElementById('<%= TXT_DEMANDEUR.ClientID %>');
    var hidden = document.getElementById('<%= HF_DEMANDEUR_ID.ClientID %>');
    var options = document.getElementById('listeEmployes').options;
    var divNewUser = document.getElementById('divNewUser');

    hidden.value = "";

    var found = false;

    for (var i = 0; i < options.length; i++) {

        if (options[i].value.trim().toLowerCase() === input.value.trim().toLowerCase()) {

            hidden.value = options[i].getAttribute("data-id");
            found = true;
            break;
        }
    }

    divNewUser.style.display =
        (!found && input.value !== "") ? "block" : "none";
}

function setAvionId() {

    var input = document.getElementById('<%= TXT_AVION.ClientID %>');
    var hidden = document.getElementById('<%= HF_AVION_ID.ClientID %>');
    var options = document.getElementById('listeAvions').options;

    hidden.value = "";

    for (var i = 0; i < options.length; i++) {

        if (options[i].value === input.value) {

            hidden.value = options[i].getAttribute("data-id");
            break;
        }
    }
}

function openCreateUserModal() {

    var nom = document.getElementById('<%= TXT_DEMANDEUR.ClientID %>').value;

    document.getElementById("iframeCreateUser").src =
        "ajout_utilisateur.aspx?nom=" + encodeURIComponent(nom);

    $('#modalCreateUser').modal('show');
}

/* VALIDATION DEMANDEUR */
function validateDemandeur(sender, args) {

    var hidden =
        document.getElementById('<%= HF_DEMANDEUR_ID.ClientID %>');

    args.IsValid = hidden.value !== "";
}

</script>

</asp:Content>