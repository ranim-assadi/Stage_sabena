<%@ Page Title="Ajouter Article" Language="C#" MasterPageFile="~/MAGASIN.Master"
    AutoEventWireup="true" CodeBehind="addarticle.aspx.cs"
    Inherits="sabena.addarticle" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h1>📦 Ajouter un Article</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-3">
<div class="panel panel-info">
<div class="panel-heading">
    Ajouter un Article
</div>

<div style="padding:20px;">
<asp:Panel ID="Panel1" runat="server" Width="70%">

<!-- ================= DESIGNATION ================= -->
<div class="row mb-3">
    <div class="col-md-6">
        <label class="fw-bold">Désignation *</label>
        <asp:TextBox ID="DESIGTXT" 
            CssClass="form-control form-control-lg"
            runat="server" />
        <asp:RequiredFieldValidator ID="valDesig"
            ControlToValidate="DESIGTXT"
            CssClass="text-danger"
            ErrorMessage="❌ Obligatoire"
            runat="server" />
    </div>

    <div class="col-md-6">
        <label class="fw-bold">Fournisseur</label>
        <asp:TextBox ID="fournisseurTXT" 
            CssClass="form-control form-control-lg"
            runat="server" />
    </div>
</div>

<!-- ================= STOCK ================= -->
<div class="row mb-3">

    <div class="col-md-3">
        <label class="fw-bold">MAX *</label>
        <asp:TextBox ID="MAXTXT" 
            CssClass="form-control form-control-lg"
            TextMode="Number" 
            runat="server" />
        <asp:RequiredFieldValidator ID="valMax"
            ControlToValidate="MAXTXT"
            CssClass="text-danger"
            ErrorMessage="❌ MAX requis"
            runat="server" />
    </div>

    <div class="col-md-3">
        <label class="fw-bold">MIN *</label>
        <asp:TextBox ID="minTXT" 
            CssClass="form-control form-control-lg"
            TextMode="Number" 
            runat="server" />
        <asp:RequiredFieldValidator ID="valMin"
            ControlToValidate="minTXT"
            CssClass="text-danger"
            ErrorMessage="❌ MIN requis"
            runat="server" />
    </div>

    <div class="col-md-3">
        <label class="fw-bold">Quantité *</label>
        <asp:TextBox ID="qtetxt" 
            CssClass="form-control form-control-lg"
            TextMode="Number"
            AutoPostBack="true"
            OnTextChanged="CalcTotal"
            runat="server" />
        <asp:RequiredFieldValidator ID="valQte"
            ControlToValidate="qtetxt"
            CssClass="text-danger"
            ErrorMessage="❌ Qte requise"
            runat="server" />
    </div>

    <!-- ================= PRIX + DEVISE ================= -->
    <div class="col-md-3">
        <label class="fw-bold">Prix *</label>

        <div class="input-group">

            <asp:TextBox ID="PRIXTXT"
                CssClass="form-control form-control-lg"
                placeholder="10,500"
                AutoPostBack="true"
                OnTextChanged="CalcTotal"
                runat="server" />

            <!-- ✅ Dinars Tunisien par défaut -->
            <asp:DropDownList ID="ddlDevise"
                runat="server"
                CssClass="form-select form-select-lg"
                AutoPostBack="true"
                OnSelectedIndexChanged="CalcTotal"
                Style="max-width:100px;">
                <asp:ListItem Text="DT" Value="DT" Selected="True" />
                <asp:ListItem Text="EUR" Value="EUR" />
                <asp:ListItem Text="USD" Value="USD" />
            </asp:DropDownList>

        </div>

        <asp:RequiredFieldValidator ID="valPrix"
            ControlToValidate="PRIXTXT"
            CssClass="text-danger"
            ErrorMessage="❌ Prix requis"
            runat="server" />

        <small class="text-muted">Ex: 10,500 ou 10.500</small>
    </div>

</div>

<!-- ================= TOTAL ================= -->
<div class="alert alert-info p-3 mb-4">
    <h4>Total :
        <asp:Label ID="LBL_TOTAL"
            runat="server"
            Font-Bold="true"
            Text="0,000 DT" />
    </h4>
</div>

<!-- ================= MESSAGES ================= -->
<asp:Panel ID="PanelSuccess" Visible="false" runat="server">
    <div class="alert alert-success">
        <asp:Label ID="LabelSuccess" runat="server" />
    </div>
</asp:Panel>

<asp:Panel ID="PanelError" Visible="false" runat="server">
    <div class="alert alert-danger">
        <asp:Label ID="LabelError" runat="server" />
    </div>
</asp:Panel>

<!-- ================= BUTTONS ================= -->
<div class="text-center">
    <asp:Button ID="ButtonAjout"
        runat="server"
        CssClass="btn btn-success btn-lg"
        Text="Ajouter"
        OnClick="ButtonAjout_Click"
        OnClientClick="return validateForm();" />
    &nbsp;&nbsp;
    <asp:Button ID="ButtonReset"
        runat="server"
        CssClass="btn btn-secondary btn-lg"
        Text="Reset"
        OnClick="ButtonReset_Click" />
</div>

</asp:Panel>
</div>
</div>
</div>

<!-- ================= JAVASCRIPT ================= -->
<script type="text/javascript">

    function validateForm() {

        const qte  = parseInt(document.getElementById('<%= qtetxt.ClientID %>').value) || 0;
        const min  = parseInt(document.getElementById('<%= minTXT.ClientID %>').value) || 0;
        const max  = parseInt(document.getElementById('<%= MAXTXT.ClientID %>').value) || 0;
        const prix = parseFloat(
            document.getElementById('<%= PRIXTXT.ClientID %>').value.replace(',', '.')
        ) || 0;

        if (min >= max) {
            alert("❌ MIN doit être strictement inférieur à MAX");
            return false;
        }

        if (qte < min || qte > max) {
            alert("❌ Quantité doit être entre MIN et MAX");
            return false;
        }

        if (prix <= 0) {
            alert("❌ Prix invalide, doit être supérieur à 0");
            return false;
        }

        return true;
    }

</script>

</asp:Content>