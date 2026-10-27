<%@ Page Title="Sortie Outillage" Language="C#" MasterPageFile="~/MAGASIN.Master" AutoEventWireup="true" CodeBehind="SortieOutillage.aspx.cs" Inherits="sabena.SortieOutillage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .meca-info { background-color: #dff0d8; padding: 10px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #d6e9c6; color: black; font-weight: bold; }
        .table-custom { width: 100%; background: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <h1>Sortie outillages</h1>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Informations du Mécanicien (Affiché une fois scanné) -->
    <asp:Panel ID="Panel1" Visible="false" runat="server">
        <div class="meca-info">
            Mécanicien : <asp:Label ID="nomtxt" runat="server"></asp:Label> <asp:Label ID="prenomTXT" runat="server"></asp:Label>
        </div>
    </asp:Panel>

    <asp:Panel ID="panelErrormeca" Visible="false" runat="server">
        <div class="alert alert-warning">
            <strong><asp:Label ID="Label2" runat="server"></asp:Label></strong>
        </div>
    </asp:Panel>

    <!-- Étape 1: Saisie Mécanicien (Masqué après validation) -->
    <asp:Panel ID="Panelmecanicien" Visible="true" runat="server">
        <div class="well">
            <table class="table">
                <tr>
                    <td>Code Mécanicien : *</td>
                    <td><asp:TextBox ID="IDMecatxt" class="form-control" AutoPostBack="True" runat="server" OnTextChanged="loadMeca" placeholder="Scanner badge..."></asp:TextBox></td>
                </tr>
            </table>
        </div>
    </asp:Panel>

    <!-- Étape 2: Saisie Outillage -->
    <asp:Panel ID="Paneloutill" Visible="false" runat="server">
        <div class="well">
            <table class="table">
                <tr>
                    <td>Code Outillage : *</td>
                    <td><asp:TextBox ID="Idoutillagetxt" AutoPostBack="True" class="form-control" runat="server" OnTextChanged="loadoutillage" placeholder="Scanner outil..."></asp:TextBox></td>
                </tr>
            </table>
        </div>
    </asp:Panel>

    <!-- Détails Outillage Scanné -->
    <asp:Panel ID="paneldetailoutil" Visible="false" runat="server">
        <div class="alert alert-info" style="color:black;">
            <table width="100%">
                <tr>
                    <td>
                        ID: <strong><asp:Label ID="Idcle" runat="server"></asp:Label></strong> <br /><br />
                        Désignation: <strong><asp:Label ID="desitxt" runat="server"></asp:Label></strong><br /><br />
                        PN: <asp:Label ID="pntxt" runat="server"></asp:Label> | SN: <asp:Label ID="sntxt" runat="server"></asp:Label><br /><br />
                        Stock Disponible: <strong><asp:Label ID="qtetxt" runat="server"></asp:Label></strong><br /><br />
                            Type outillage: <asp:Label ID="typetxt" runat="server"></asp:Label><br /><br />
                        Remarque: <asp:Label ID="remarque" runat="server"></asp:Label>
                    </td>
                    <td align="right"><asp:Image ID="Image1" runat="server" Height="200px" Width="300px" /></td>
                </tr>
            </table>
            <hr />
            <center>
                <asp:Button ID="check" runat="server" class="btn btn-info" Text="Sortie CHECK" OnClick="check_Click" />
                <asp:Button ID="line" runat="server" class="btn btn-info" Text="Sortie LINE" OnClick="line_Click" />
            </center>
        </div>
    </asp:Panel>

    <!-- Formulaire de Mouvement (Quantité, OE, AC) -->
    <asp:Panel ID="panelmouvment" Visible="false" runat="server">
        <div class="well">
            <table class="table table-bordered">
                <tr>
                    <td>Quantité : *</td>
                    <td><asp:TextBox ID="Qtemouv1" class="form-control" runat="server" type="number" min="1"></asp:TextBox></td>
                    <td><asp:Label ID="oelabel" runat="server" Text="OE * :"></asp:Label></td>
                    <td><asp:TextBox ID="OEtxt" class="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>A/C (Avion) :</td>
                    <td><asp:DropDownList ID="ACtxt" runat="server" AutoPostBack="True" class="form-control" OnSelectedIndexChanged="ACtxt_SelectedIndexChanged"></asp:DropDownList></td>
                    <td><asp:Label ID="bvlablel" runat="server" Text="BV :"></asp:Label></td>
                    <td><asp:DropDownList ID="BVDROP" runat="server" class="form-control"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td>Remarque :</td>
                    <td colspan="3"><asp:TextBox ID="remarquetxt" runat="server" class="form-control"></asp:TextBox></td>
                </tr>
            </table>
            <center>
                <asp:Button ID="Button2" runat="server" class="btn btn-success" Text="VALIDER LA SORTIE" OnClick="Buttonajout_Click" Width="200px" />
                <asp:Button ID="ButtonCancel" runat="server" class="btn btn-danger" Text="ANNULER" OnClick="non" />
            </center>
        </div>
    </asp:Panel>

    <!-- Panel de Succès -->
    <asp:Panel ID="panelOE" Visible="false" runat="server">
        <div class="alert alert-success" style="text-align:center;">
            <h3>Sortie effectuée avec succès !</h3>
            <asp:LinkButton ID="LinkButton2" class="btn btn-success" runat="server" OnClick="LinkButton1_Clickplus">Sortir un AUTRE OUTIL pour ce mécanicien</asp:LinkButton>
            <asp:Button ID="Button1" runat="server" class="btn btn-primary" Text="Terminer" OnClick="termine_Click" />
            <br /><br />
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click1">Ajouter un OE sur cet outil</asp:LinkButton>
        </div>
    </asp:Panel>

    <asp:Label ID="auxtype" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="auxline" runat="server" Visible="false"></asp:Label>
    <asp:Panel ID="Panelerroroutil" runat="server" Visible="false"><div class="alert alert-danger"><asp:Label ID="erroroutil" runat="server"></asp:Label></div></asp:Panel>

</asp:Content>