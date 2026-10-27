<%@ Page Title="" Language="C#" MasterPageFile="~/MAGASIN.Master"
AutoEventWireup="true" CodeBehind="modifarticle.aspx.cs"
Inherits="sabena.modifarticle" %>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder2"
    runat="server">

    <h1>
        <i class="fa fa-edit"></i>
        Modifier un Article
    </h1>

</asp:Content>

<asp:Content ID="Content3"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

<div class="container mt-3">

<div class="panel panel-primary">

<div class="panel-heading">
    Modification Article
</div>

<div class="panel-body">

<!-- ================= DESIGNATION / FOURNISSEUR ================= -->
<div class="row">

    <div class="col-md-6">

        <label>Désignation *</label>

        <asp:TextBox ID="DESIGTXT"
            runat="server"
            CssClass="form-control" />

    </div>

    <div class="col-md-6">

        <label>Fournisseur</label>

        <asp:TextBox ID="fournisseurTXT"
            runat="server"
            CssClass="form-control" />

    </div>

</div>

<br />

<!-- ================= STOCK ================= -->
<div class="row">

    <div class="col-md-3">

        <label>Stock MAX *</label>

        <asp:TextBox ID="MAXTXT"
            runat="server"
            CssClass="form-control"
            TextMode="Number" />

    </div>

    <div class="col-md-3">

        <label>Stock MIN *</label>

        <asp:TextBox ID="minTXT"
            runat="server"
            CssClass="form-control"
            TextMode="Number" />

    </div>

    <div class="col-md-3">

        <label>Quantité *</label>

        <asp:TextBox ID="qtetxt"
            runat="server"
            CssClass="form-control"
            TextMode="Number"
            AutoPostBack="true"
            OnTextChanged="CalcTotal" />

    </div>

    <div class="col-md-3">

        <label>Prix Unitaire *</label>

        <asp:TextBox ID="PRIXTXT"
            runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnTextChanged="CalcTotal" />

    </div>

</div>

<br />

<!-- ================= TOTAL ================= -->
<div class="alert alert-info">

    <strong>Prix Total :</strong>

    <asp:Label ID="LBL_TOTAL"
        runat="server"
        Font-Bold="true"
        Font-Size="Large" />

</div>

<br />

<!-- ================= BUTTON ================= -->
<div class="text-center">

    <asp:Button ID="BTN_MODIFIER"
        runat="server"
        Text="Modifier Article"
        CssClass="btn btn-warning btn-lg"
        OnClick="BTN_MODIFIER_Click" />

</div>

<br />

<!-- ================= SUCCESS ================= -->
<asp:Panel ID="PanelSuccess"
    runat="server"
    Visible="false">

    <div class="alert alert-success">

        <asp:Label ID="LBL_SUCCESS"
            runat="server" />

    </div>

</asp:Panel>

<!-- ================= ERROR ================= -->
<asp:Panel ID="PanelError"
    runat="server"
    Visible="false">

    <div class="alert alert-danger">

        <asp:Label ID="LBL_ERROR"
            runat="server" />

    </div>

</asp:Panel>

</div>
</div>
</div>

</asp:Content>