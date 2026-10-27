<%@ Page Title="Détail Article" Language="C#" MasterPageFile="~/MAGASIN.Master"
    AutoEventWireup="true"
    CodeBehind="detail_alimentation.aspx.cs"
    Inherits="sabena.detail_alimentation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
   
    <style>
        /* Styles stricts et organisés (Type ERP) */
        .erp-card { background: #fff; border: 1px solid #dee2e6; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .erp-card-header { background: #f8f9fa; border-bottom: 1px solid #dee2e6; padding: 12px 20px; font-weight: 600; color: #333; display: flex; align-items: center; justify-content: space-between; }
        .erp-card-body { padding: 20px; }
        
        /* Liste d'informations compacte */
        .info-list { list-style: none; padding: 0; margin: 0; }
        .info-list li { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px dashed #eee; }
        .info-list li:last-child { border-bottom: none; }
        .info-label { color: #6c757d; font-size: 0.9rem; font-weight: 500; }
        .info-value { font-weight: 600; color: #212529; text-align: right; }
        
        /* Formulaire */
        .form-label { font-size: 0.85rem; font-weight: 600; color: #495057; text-transform: uppercase; margin-bottom: 5px; }
        .form-control, .form-select { border-radius: 4px; border: 1px solid #ced4da; }
        .form-control:focus { border-color: #80bdff; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); }
        
        /* Tableau organisé */
        .table-erp { border-collapse: collapse; width: 100%; font-size: 0.9rem; }
        .table-erp th { background: #f4f6f9; color: #495057; border-bottom: 2px solid #dee2e6; padding: 10px; font-weight: 600; }
        .table-erp td { padding: 10px; border-bottom: 1px solid #e9ecef; vertical-align: middle; }
        .table-erp tr:hover { background-color: #f8f9fa; }
    </style>

           <h2 >Détail & Alimentation du Stock</h2>
       <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        
            <a href="alimenarticle.aspx" class="btn btn-sm btn-outline-secondary">
                <i class="fa fa-arrow-left me-1"></i> Retour à la liste
            </a>
        </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       
    <div class="container-fluid py-3">

        <!-- En-tête de la page -->
     
        <div class="row">
            <!-- ================= COLONNE GAUCHE : FICHE ARTICLE ================= -->
          <div class="col-lg-5">
    <div class="erp-card">
        <div class="erp-card-header">
            <span><i class="fa fa-info-circle text-info me-2"></i> Informations Article</span>
        </div>
        <div class="erp-card-body">
            <ul class="info-list">
                <!-- MODIFICATION ICI : Ajout de fs-4 (taille) et fw-bold (gras) -->
                <li class="mb-3"> <!-- Ajout d'une marge en bas (mb-3) pour aérer un peu car le texte est plus grand -->
                    <span class="info-value text-primary fs-4 fw-bold">Désignation</span>
                    <span class="info-value text-primary fs-4 fw-bold"><asp:Label ID="LBL_DESIGNATION" runat="server" /></span>
                </li>
                <li>
                    <span class="info-value">Fournisseur Habituel</span>
                    <span class="info-value"><asp:Label ID="LBL_FOURNISSEUR" runat="server" /></span>
                </li>
                <li>
                    <span class="info-value">Prix unitaire de référence</span>
                    <span class="info-value text-success"><asp:Label ID="LBL_PRIX" runat="server" /></span>
                </li>
                <li class="bg-light p-2 mt-2 rounded border">
                    <span class="info-value text-dark">Quantité en Stock</span>
                    <span class="info-value fs-5"><asp:Label ID="LBL_QTE" runat="server" /></span>
                </li>
            </ul>

            <div class="row text-center mt-3 pt-3 border-top">
                <div class="col-6 border-end">
                    <small class="text-muted d-block text-uppercase">Stock Min</small>
                    <strong class="text-warning"><asp:Label ID="LBL_MIN" runat="server" /></strong>
                </div>
                <div class="col-6">
                    <small class="text-muted d-block text-uppercase">Stock Max</small>
                    <strong><asp:Label ID="LBL_MAX" runat="server" /></strong>
                </div>
            </div>
        </div>
    </div>
</div>

            <!-- ================= COLONNE DROITE : ALIMENTATION ================= -->
            <div class="col-lg-7">
                <div class="erp-card border-success">
                    <div class="erp-card-header bg-success text-white">
                        <span><i class="fa fa-plus-circle me-2"></i> Enregistrer une entrée (Alimentation)</span>
                    </div>
                    <div class="erp-card-body">

                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="AddStock" CssClass="alert alert-danger py-2" HeaderText="Erreurs à corriger :" DisplayMode="BulletList" />

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="info-value">Quantité à ajouter <span class="text-danger">*</span></label>
                                <asp:TextBox ID="TXT_QTE" runat="server" CssClass="form-control form-control-lg text-center fw-bold" TextMode="Number" placeholder="0" min="1" step="1" />
                                <asp:RequiredFieldValidator ID="rfvQte" runat="server" ControlToValidate="TXT_QTE" ValidationGroup="AddStock" CssClass="text-danger small" ErrorMessage="Quantité obligatoire." Display="Dynamic" />
                                <asp:CompareValidator ID="cvQte" runat="server" ControlToValidate="TXT_QTE" Operator="GreaterThan" Type="Integer" ValueToCompare="0" ValidationGroup="AddStock" CssClass="text-danger small" ErrorMessage="Doit être > 0." Display="Dynamic" />
                            </div>

                            <div class="col-md-6">
                                <label class="info-value">Prix unitaire appliqué <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <asp:TextBox ID="prixu" runat="server" CssClass="form-control form-control-lg" placeholder="0.000" />
                                    <asp:DropDownList ID="ddlDevise" runat="server" CssClass="form-select" Style="max-width: 90px;">
                                        <asp:ListItem Text="DT" Value="DT" Selected="True" />
                                        <asp:ListItem Text="EUR" Value="EUR" />
                                        <asp:ListItem Text="USD" Value="USD" />
                                    </asp:DropDownList>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvPrix" runat="server" ControlToValidate="prixu" ValidationGroup="AddStock" CssClass="text-danger small" ErrorMessage="Prix obligatoire." Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revPrix" runat="server" ControlToValidate="prixu" ValidationGroup="AddStock" CssClass="text-danger small" ErrorMessage="Format invalide." ValidationExpression="^\d+([.,]\d{1,3})?$" Display="Dynamic" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="info-value">Fournisseur</label>
                                <asp:TextBox ID="TXT_FOURNISSEUR" runat="server" CssClass="form-control" placeholder="Nom du fournisseur pour cette entrée..." />
                            </div>
                        </div>

                        <!-- Messages de retour -->
                        <asp:Panel ID="PanelSuccess" runat="server" Visible="false">
                            <div class="alert alert-success py-2 mb-3"><asp:Label ID="LBL_SUCCESS" runat="server" /></div>
                        </asp:Panel>
                        <asp:Panel ID="PanelError" runat="server" Visible="false">
                            <div class="alert alert-danger py-2 mb-3"><asp:Label ID="LBL_ERROR" runat="server" /></div>
                        </asp:Panel>
                        <br />
                        <div class="d-flex justify-content-end pt-3 border-top">
                            <asp:Button ID="BTN_AJOUT" runat="server" Text="Valider l'entrée en stock" CssClass="btn btn-success px-4" ValidationGroup="AddStock" OnClick="BTN_AJOUT_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- ================= PLEINE LARGEUR : HISTORIQUE ================= -->
               <!-- ================= PLEINE LARGEUR : HISTORIQUE (AGRANDI) ================= -->
              <!-- ================= PLEINE LARGEUR : HISTORIQUE (FORCÉ EN GRAND) ================= -->
            <!-- ================= PLEINE LARGEUR : HISTORIQUE (FORCÉ EN GRAND ET CENTRÉ) ================= -->
        <style>
            /* Utilisation de !important et tailles en px pour forcer l'écrasement du CSS de la MasterPage */
            .table-erp-mega { width: 100% !important; border-collapse: collapse !important; }
            
            /* En-têtes du tableau */
            .table-erp-mega th { 
                background: #e9ecef !important; 
                color: #212529 !important; 
                border-bottom: 3px solid #dee2e6 !important; 
                padding: 20px 15px !important; 
                font-weight: bold !important; 
                font-size: 18px !important; 
                text-align: center !important; /* <-- CENTRAGE AJOUTÉ ICI */
            }
            
            /* Cellules du tableau */
            .table-erp-mega td { 
                padding: 20px 15px !important; 
                border-bottom: 1px solid #dee2e6 !important; 
                vertical-align: middle !important;
                font-size: 16px !important; 
                color: #333 !important;
                text-align: center !important; /* <-- CENTRAGE AJOUTÉ ICI */
            }
            
            .table-erp-mega tr:hover td { background-color: #f8f9fa !important; }
            
            /* Badges et Quantité */
            .badge-mega { 
                font-size: 15px !important; 
                padding: 10px 15px !important; 
                border-radius: 8px !important; 
            }
            .text-mega-qte {
                font-size: 20px !important; 
                font-weight: 900 !important;
                color: #0d6efd !important;
            }
        </style>

        <div class="row mt-4">
            <div class="col-12">
                <div class="erp-card shadow-sm" style="border: 1px solid #ccc;">
                    <div class="erp-card-header d-flex justify-content-between align-items-center bg-light" style="padding: 20px;">
                        <span class="text-dark" style="font-size: 20px; font-weight: bold;">
                            <i class="fa fa-list-alt text-secondary me-2"></i> Historique des mouvements
                        </span>
                        <span class="badge bg-secondary" style="font-size: 16px; padding: 10px 15px;">Dernières opérations</span>
                    </div>
                    
                    <div class="erp-card-body p-0">
                        <asp:GridView ID="gvHistorique"
                            runat="server"
                            CssClass="table-erp-mega"
                            AutoGenerateColumns="false"
                            AllowPaging="true"
                            PageSize="10"
                            GridLines="None"
                            EmptyDataText="<div style='padding:40px; text-align:center; color:#6c757d; font-size:18px;'>Aucun mouvement enregistré.</div>"
                            OnPageIndexChanging="gvHistorique_PageIndexChanging">
                            
                      
                            <HeaderStyle Font-Size="14pt" Height="60px" HorizontalAlign="Center" />
                            <RowStyle Font-Size="12pt" Height="60px" HorizontalAlign="Center" />
                            <PagerStyle Font-Size="14pt" HorizontalAlign="Center" Height="50px" />

                            <Columns>
                                <asp:BoundField DataField="DateMouvement" HeaderText="Date & Heure" DataFormatString="{0:dd/MM/yyyy HH:mm}" ItemStyle-Width="200px" />
                                
                                <asp:TemplateField HeaderText="Operation" ItemStyle-Width="180px">
                                    <ItemTemplate>
                                        <span class="badge bg-success badge-mega"><%# Eval("typemouvement") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="Quantite" HeaderText="Qté" ItemStyle-CssClass="text-mega-qte" ItemStyle-Width="120px" />
                                
                                <asp:TemplateField HeaderText="Prix Unit.">
                                    <ItemTemplate>
                                        <span style="font-weight:bold; font-size:18px;"><%# Eval("prix") %></span> 
                                        <span style="color:#6c757d; font-size:14px;"><%# Eval("devise") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="fournisseur" HeaderText="Fournisseur" />
                                
                                <asp:TemplateField HeaderText="Magasinier">
                                    <ItemTemplate>
                                        <i class="fa fa-user me-2" style="color:#aaa;"></i><%#  Eval("Magasinier") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>