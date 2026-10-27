<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ajout_utilisateur.aspx.cs"
Inherits="sabena.ajout_utilisateur" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Créer Demandeur</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <h3>Création Demandeur</h3>

    <!-- VALIDATION SUMMARY -->
    <asp:ValidationSummary 
        ID="ValidationSummary1" 
        runat="server"
        CssClass="alert alert-danger"
        HeaderText="Veuillez corriger les erreurs suivantes :" />

    <!-- MATRICULE -->
    <div class="form-group">
        <label>Matricule*</label>

        <asp:TextBox ID="txt_matricule" runat="server" CssClass="form-control" />

        <asp:RequiredFieldValidator
            ID="rfvMatricule"
            runat="server"
            ControlToValidate="txt_matricule"
            ErrorMessage="Le matricule est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />

        <asp:RegularExpressionValidator
            ID="revMatricule"
            runat="server"
            ControlToValidate="txt_matricule"
            ValidationExpression="^[0-9]+$"
            ErrorMessage="Le matricule doit contenir uniquement des chiffres."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <!-- NOM -->
    <div class="form-group">
        <label>Nom*</label>

        <asp:TextBox ID="TXT_NOM" runat="server" CssClass="form-control" />

        <asp:RequiredFieldValidator
            ID="rfvNom"
            runat="server"
            ControlToValidate="TXT_NOM"
            ErrorMessage="Le nom est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <!-- PRENOM -->
    <div class="form-group">
        <label>Prenom*</label>

        <asp:TextBox ID="TXT_PRENOM" runat="server" CssClass="form-control" />

        <asp:RequiredFieldValidator
            ID="rfvPrenom"
            runat="server"
            ControlToValidate="TXT_PRENOM"
            ErrorMessage="Le prénom est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <!-- FONCTION -->
    <div class="form-group">
        <label>Fonction</label>

        <asp:TextBox ID="TXT_FONCTION" runat="server" CssClass="form-control" />
    </div>

    <!-- DEPARTEMENT -->
    <div class="form-group">
        <label>Departement*</label>

        <asp:DropDownList ID="TXT_DEPARTEMENT" CssClass="form-control" runat="server">
            <asp:ListItem Value="">-- Sélectionner Département --</asp:ListItem>
            <asp:ListItem Value="PRODUCTION">Département Production</asp:ListItem>
            <asp:ListItem Value="ENGINEERING">Département Engineering</asp:ListItem>
            <asp:ListItem Value="CABIN">CABINE</asp:ListItem>
            <asp:ListItem Value="LOGISTIQUE">Département Logistique</asp:ListItem>
            <asp:ListItem Value="QUALITE">Département Qualité</asp:ListItem>
            <asp:ListItem Value="DIRECTION">Département Direction</asp:ListItem>
            <asp:ListItem Value="FINANCE">Département Finance</asp:ListItem>
        </asp:DropDownList>

        <asp:RequiredFieldValidator
            ID="rfvDepartement"
            runat="server"
            ControlToValidate="TXT_DEPARTEMENT"
            InitialValue=""
            ErrorMessage="Le département est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <!-- ESCALE -->
    <div class="form-group">
        <label>Escale*</label>

        <asp:DropDownList ID="TXT_ESCALE" CssClass="form-control" runat="server">
            <asp:ListItem Value="">-- Sélectionner Escale --</asp:ListItem>
            <asp:ListItem Value="MIR">ESCALE MIR</asp:ListItem>
            <asp:ListItem Value="TUN">ESCALE TUN</asp:ListItem>
            <asp:ListItem Value="NBE">ESCALE NBE</asp:ListItem>
            <asp:ListItem Value="DJE">ESCALE DJE</asp:ListItem>
            <asp:ListItem Value="SFX">ESCALE SFX</asp:ListItem>
            <asp:ListItem Value="RAK">ESCALE RAK</asp:ListItem>
            <asp:ListItem Value="OUD">ESCALE OUD</asp:ListItem>
        </asp:DropDownList>

        <asp:RequiredFieldValidator
            ID="rfvEscale"
            runat="server"
            ControlToValidate="TXT_ESCALE"
            InitialValue=""
            ErrorMessage="L'escale est obligatoire."
            ForeColor="Red"
            Display="Dynamic" />
    </div>

    <br />

    <asp:Button ID="BTN_SAVE"
        runat="server"
        Text="Créer"
        CssClass="btn btn-success"
        OnClick="BTN_SAVE_Click" />

    <br /><br />

    <asp:Label ID="LBL_MSG" runat="server" />

</div>

</form>

</body>
</html>