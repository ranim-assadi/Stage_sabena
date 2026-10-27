<%@ Page Title="Détail DA"
    Language="C#"
    MasterPageFile="~/MAGASIN.Master"
    AutoEventWireup="true"
    CodeBehind="DA_DETAIL.aspx.cs"
    Inherits="sabena.DA_DETAIL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

:root {
    --primary: #4f46e5;
    --primary-light: #818cf8;
    --primary-dark: #3730a3;
    --success: #10b981;
    --success-light: #d1fae5;
    --warning: #f59e0b;
    --warning-light: #fef3c7;
    --danger: #ef4444;
    --danger-light: #fee2e2;
    --gray-50: #f9fafb;
    --gray-100: #f3f4f6;
    --gray-200: #e5e7eb;
    --gray-300: #d1d5db;
    --gray-400: #9ca3af;
    --gray-500: #6b7280;
    --gray-600: #4b5563;
    --gray-700: #374151;
    --gray-800: #1f2937;
    --gray-900: #111827;
    --radius: 16px;
    --radius-sm: 10px;
    --radius-xs: 6px;
    --shadow-sm: 0 1px 2px rgba(0,0,0,0.04);
    --shadow: 0 4px 24px rgba(0,0,0,0.06);
    --shadow-lg: 0 12px 40px rgba(0,0,0,0.1);
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.da-detail-wrapper {
    max-width: 1280px;
    margin: 0 auto;
    padding: 32px 24px;
    font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
    color: var(--gray-800);
}

.da-page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
    margin-bottom: 32px;
}

.da-page-header-left {
    display: flex;
    align-items: center;
    gap: 16px;
}

.da-page-icon {
    width: 56px;
    height: 56px;
    background: linear-gradient(135deg, var(--primary), var(--primary-light));
    border-radius: var(--radius-sm);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8px 24px rgba(79, 70, 229, 0.3);
}

.da-page-icon svg {
    width: 28px;
    height: 28px;
    stroke: #fff;
    fill: none;
}

.da-page-title {
    font-size: 28px;
    font-weight: 800;
    color: var(--gray-900);
    margin: 0;
    letter-spacing: -0.5px;
}

.da-page-subtitle {
    font-size: 14px;
    color: var(--gray-500);
    margin: 2px 0 0 0;
    font-weight: 400;
}

.da-toolbar {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.da-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 20px;
    border-radius: 50px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none !important;
    border: none;
    cursor: pointer;
    transition: var(--transition);
    letter-spacing: 0.2px;
    line-height: 1.4;
    position: relative;
    overflow: hidden;
}

.da-btn svg {
    width: 18px;
    height: 18px;
    flex-shrink: 0;
    stroke: currentColor;
    fill: none;
}

.da-btn-success {
    background: linear-gradient(135deg, var(--success), #059669);
    color: #fff !important;
    box-shadow: 0 4px 16px rgba(16, 185, 129, 0.3);
}

.da-btn-success:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(16, 185, 129, 0.4);
    color: #fff !important;
}

.da-btn-primary {
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: #fff !important;
    box-shadow: 0 4px 16px rgba(79, 70, 229, 0.3);
}

.da-btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(79, 70, 229, 0.4);
    color: #fff !important;
}

.da-btn-outline {
    background: #fff;
    color: var(--gray-700) !important;
    border: 2px solid var(--gray-200);
    box-shadow: var(--shadow-sm);
}

.da-btn-outline:hover {
    border-color: var(--primary-light);
    color: var(--primary) !important;
    transform: translateY(-2px);
    box-shadow: var(--shadow);
}

.da-card {
    background: #fff;
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    border: 1px solid var(--gray-100);
    margin-bottom: 28px;
    overflow: hidden;
    transition: var(--transition);
}

.da-card:hover {
    box-shadow: var(--shadow-lg);
}

/* ===== CARD HEADER WITH LOGO ===== */
.da-card-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 20px 28px;
    border-bottom: 1px solid var(--gray-100);
    background: var(--gray-50);
    position: relative;
}

.da-card-header-icon {
    width: 40px;
    height: 40px;
    background: linear-gradient(135deg, var(--primary), var(--primary-light));
    border-radius: var(--radius-xs);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.da-card-header-icon svg {
    width: 20px;
    height: 20px;
    stroke: #fff;
    fill: none;
}

.da-card-title {
    font-size: 18px;
    font-weight: 700;
    color: var(--gray-900);
    margin: 0;
    flex: 1;
}

.da-card-header-logo {
    margin-left: auto;
    display: flex;
    align-items: center;
    flex-shrink: 0;
    padding: 4px 8px;
    background: #fff;
    border-radius: var(--radius-xs);
    border: 1px solid var(--gray-200);
    box-shadow: var(--shadow-sm);
}

.da-card-header-logo img {
    height: 55px;
    width: auto;
    object-fit: contain;
    display: block;
}

/* ===== CARD BODY ===== */
.da-card-body {
    padding: 28px;
}

/* ===== INFO GRID ===== */
.da-info-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

.da-info-item {
    background: var(--gray-50);
    border-radius: var(--radius-sm);
    padding: 18px 20px;
    border: 1px solid var(--gray-100);
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.da-info-item::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    width: 4px;
    background: var(--primary-light);
    border-radius: 0 4px 4px 0;
    opacity: 0;
    transition: var(--transition);
}

.da-info-item:hover {
    border-color: var(--primary-light);
    background: #fff;
}

.da-info-item:hover::before {
    opacity: 1;
}

.da-info-label {
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--gray-400);
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    gap: 6px;
}

.da-info-label svg {
    width: 14px;
    height: 14px;
    stroke: var(--gray-400);
    fill: none;
}

.da-info-value {
    font-size: 16px;
    font-weight: 600;
    color: var(--gray-800);
    word-break: break-word;
}

.da-info-item--total {
    background: linear-gradient(135deg, #eef2ff, #e0e7ff);
    border-color: var(--primary-light);
}

.da-info-item--total .da-info-value {
    font-size: 22px;
    font-weight: 800;
    color: var(--primary);
}

.da-info-item--total::before {
    opacity: 1;
    background: var(--primary);
}

.da-info-item--observation {
    grid-column: span 2;
}

/* ===== STATUS BADGES ===== */
.da-status {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 50px;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.3px;
}

.da-status-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    display: inline-block;
}

.da-status--valid {
    background: var(--success-light);
    color: #065f46;
}

.da-status--valid .da-status-dot {
    background: var(--success);
    animation: da-pulse 2s infinite;
}

.da-status--pending {
    background: var(--warning-light);
    color: #92400e;
}

.da-status--pending .da-status-dot {
    background: var(--warning);
    animation: da-pulse 2s infinite;
}

.da-status--rejected {
    background: var(--danger-light);
    color: #991b1b;
}

.da-status--rejected .da-status-dot {
    background: var(--danger);
    animation: da-pulse 2s infinite;
}

@keyframes da-pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.4; }
}

/* ===== DIVIDER ===== */
.da-divider {
    border: none;
    border-top: 1px dashed var(--gray-200);
    margin: 24px 0;
}

/* ===== TABLE ===== */
.da-table-wrapper {
    overflow-x: auto;
}

.da-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    font-size: 14px;
}

.da-table th {
    background: linear-gradient(135deg, var(--gray-800), var(--gray-700)) !important;
    color: #fff !important;
    font-weight: 600 !important;
    font-size: 12px !important;
    text-transform: uppercase !important;
    letter-spacing: 0.8px !important;
    padding: 14px 18px !important;
    text-align: left !important;
    border: none !important;
    white-space: nowrap;
}

.da-table td {
    padding: 14px 18px !important;
    border-bottom: 1px solid var(--gray-100) !important;
    border-left: none !important;
    border-right: none !important;
    border-top: none !important;
    color: var(--gray-700);
    font-weight: 500;
    text-align: left !important;
    vertical-align: middle !important;
    background: transparent !important;
    transition: var(--transition);
}

.da-table tr:last-child td {
    border-bottom: none !important;
}

.da-table tr:hover td {
    background: var(--gray-50) !important;
}

.da-table tr:nth-child(even) td {
    background: rgba(249, 250, 251, 0.5) !important;
}

.da-table tr:nth-child(even):hover td {
    background: var(--gray-100) !important;
}

.da-table td:nth-child(3),
.da-table td:nth-child(4),
.da-table td:nth-child(5),
.da-table td:nth-child(7),
.da-table td:nth-child(8),
.da-table th:nth-child(3),
.da-table th:nth-child(4),
.da-table th:nth-child(5),
.da-table th:nth-child(7),
.da-table th:nth-child(8) {
    text-align: right !important;
}

/* ===== ANIMATIONS ===== */
.da-fade-in {
    animation: da-fadeIn 0.5s ease-out;
}

.da-fade-in-up {
    animation: da-fadeInUp 0.6s ease-out;
}

.da-fade-in-up-delay {
    animation: da-fadeInUp 0.6s ease-out 0.15s both;
}

@keyframes da-fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes da-fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* ===== RESPONSIVE ===== */
@media (max-width: 992px) {
    .da-info-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .da-page-header {
        flex-direction: column;
        align-items: flex-start;
    }
    .da-toolbar {
        width: 100%;
    }
    .da-toolbar .da-btn {
        flex: 1;
        justify-content: center;
        padding: 10px 14px;
        font-size: 13px;
    }
    .da-page-title {
        font-size: 22px;
    }
    .da-card-body {
        padding: 20px;
    }
    .da-table th,
    .da-table td {
        padding: 10px 12px !important;
        font-size: 13px !important;
    }
    .da-info-item--observation {
        grid-column: span 1;
    }
    .da-card-header-logo img {
        height: 40px;
    }
}

@media (max-width: 576px) {
    .da-info-grid {
        grid-template-columns: 1fr;
    }
    .da-detail-wrapper {
        padding: 16px 12px;
    }
    .da-card-header-logo {
        display: none;
    }
}

/* ===== PRINT ===== */
@media print {
    .da-toolbar { display: none !important; }
    .da-card {
        box-shadow: none !important;
        border: 1px solid #ddd !important;
        break-inside: avoid;
    }
    .da-detail-wrapper { padding: 0 !important; }
    .da-page-icon { display: none !important; }
    .da-card-header-logo img {
        height: 50px;
    }
}

</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div>
        <h2 class="da-page-title">Détail Demande d'Achat</h2>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="da-detail-wrapper da-fade-in">

    <!-- PAGE HEADER -->
    <div class="da-page-header">

        <div class="da-toolbar">
            <asp:Panel ID="pnlActions" runat="server">

            <asp:LinkButton ID="btnDownload" runat="server" 
                CssClass="da-btn da-btn-success" 
                OnClick="btnDownload_Click1">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                    <polyline points="7 10 12 15 17 10"></polyline>
                    <line x1="12" y1="15" x2="12" y2="3"></line>
                </svg>
                Télécharger Excel
            </asp:LinkButton>

            <a href="javascript:window.print();" class="da-btn da-btn-primary">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="6 9 6 2 18 2 18 9"></polyline>
                    <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                    <rect x="6" y="14" width="12" height="8"></rect>
                </svg>
                Imprimer
            </a>
                </asp:Panel>

            <a href="DA_HISTORIQUE.aspx" class="da-btn da-btn-outline">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                Retour
            </a>

        </div>

    </div>

    <!-- INFOS DA CARD -->
    <div class="da-card da-fade-in-up">

        <div class="da-card-header">

            <div class="da-card-header-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="16" x2="12" y2="12"></line>
                    <line x1="12" y1="8" x2="12.01" y2="8"></line>
                </svg>
            </div>

            <h3 class="da-card-title">Informations de la Demande</h3>

            <%-- LOGO pushed to the RIGHT via margin-left:auto on wrapper --%>
            <div class="da-card-header-logo">
                <asp:Image ID="Image1" runat="server"
                    ImageUrl="~/image/sabenatechnics_logo.png"
                    AlternateText="Sabena Technics" />
            </div>

        </div>

        <div class="da-card-body">

            <div class="da-info-grid">

                <div class="da-info-item">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        N° DA
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblNumero" runat="server" />
                    </div>
                </div>

                <div class="da-info-item">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="16" y1="2" x2="16" y2="6"></line>
                            <line x1="8" y1="2" x2="8" y2="6"></line>
                            <line x1="3" y1="10" x2="21" y2="10"></line>
                        </svg>
                        Date
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblDate" runat="server" />
                    </div>
                </div>

                <div class="da-info-item">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        Demandeur
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblDemandeur" runat="server" />
                    </div>
                </div>

                <div class="da-info-item">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                            <polyline points="9 22 9 12 15 12 15 22"></polyline>
                        </svg>
                        Service
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblService" runat="server" />
                    </div>
                </div>

            </div>

            <hr class="da-divider" />

            <div class="da-info-grid">

                <div class="da-info-item">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                        </svg>
                        Statut
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblStatut" runat="server" />
                    </div>
                </div>

                <div class="da-info-item da-info-item--observation">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="17" y1="10" x2="3" y2="10"></line>
                            <line x1="21" y1="6" x2="3" y2="6"></line>
                            <line x1="21" y1="14" x2="3" y2="14"></line>
                            <line x1="17" y1="18" x2="3" y2="18"></line>
                        </svg>
                        Observation
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblObservation" runat="server" />
                    </div>
                </div>

                <div class="da-info-item da-info-item--total">
                    <div class="da-info-label">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="1" x2="12" y2="23"></line>
                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                        </svg>
                        Total Général
                    </div>
                    <div class="da-info-value">
                        <asp:Label ID="lblTotal" runat="server" />
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- ARTICLES TABLE CARD -->
    <div class="da-card da-fade-in-up-delay">

        <div class="da-card-header">
            <div class="da-card-header-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="1" y="3" width="15" height="13"></rect>
                    <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
            </div>
            <h3 class="da-card-title">Détail des Articles</h3>
        </div>

        <div class="da-card-body" style="padding: 0;">
            <div class="da-table-wrapper">

                <asp:GridView ID="gvDetail"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="da-table"
    GridLines="None"
    DataKeyNames="ArticleID"
    OnRowEditing="gvDetail_RowEditing"
    OnRowCancelingEdit="gvDetail_RowCancelingEdit"
    OnRowUpdating="gvDetail_RowUpdating">

    <Columns>
        <asp:BoundField DataField="ArticleID" HeaderText="Code" ReadOnly="true" />
        <asp:BoundField DataField="DesignationARTICLE" HeaderText="Désignation" ReadOnly="true" />

        <asp:TemplateField HeaderText="Qté">
            <ItemTemplate>
                <asp:Label ID="lblQTE" runat="server" Text='<%# Eval("QTE") %>'></asp:Label>
            </ItemTemplate>

            <EditItemTemplate>
                <asp:TextBox ID="txtQTE" runat="server"
                    Text='<%# Bind("QTE") %>'
                    CssClass="form-control"
                    Style="width:80px;">
                        onkeydown="alert('touche pressée: ' + event.keyCode); return false;">

                </asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="StockActuel" HeaderText="Stock" ReadOnly="true" />
        <asp:BoundField DataField="StockMinimum" HeaderText="Min" ReadOnly="true" />
        <asp:BoundField DataField="Fournisseur" HeaderText="Fournisseur" ReadOnly="true" />
        <asp:BoundField DataField="PrixUnitaire" HeaderText="PU" DataFormatString="{0:N3}" ReadOnly="true" />
        <asp:BoundField DataField="PrixTotal" HeaderText="Total" DataFormatString="{0:N3}" ReadOnly="true" />

        <asp:CommandField 
            HeaderText="Action"
            ShowEditButton="true"
            EditText="Modifier"
            UpdateText="Enregistrer"
            CancelText="Annuler"
            ButtonType="Link" />
    </Columns>

</asp:GridView>

                    <Columns>
                        <asp:BoundField DataField="ArticleID" HeaderText="Code" />
                        <asp:BoundField DataField="DesignationARTICLE" HeaderText="Désignation" />
                        <asp:TemplateField HeaderText="Qté">
    





</asp:TemplateField>
                        <asp:BoundField DataField="StockActuel" HeaderText="Stock" />
                        <asp:BoundField DataField="StockMinimum" HeaderText="Min" />
                        <asp:BoundField DataField="Fournisseur" HeaderText="Fournisseur" />
                        <asp:BoundField DataField="PrixUnitaire" HeaderText="PU" DataFormatString="{0:N3}" />
                        <asp:BoundField DataField="PrixTotal" HeaderText="Total" DataFormatString="{0:N3}" />
                        <asp:TemplateField HeaderText="Action">
    
</asp:TemplateField>
                    </Columns>

                </asp:GridView>
                <br />        
                </div>
   
        </div>
    </div>
    <asp:Panel ID="pnlDelete" runat="server">
<div style="text-align:center; margin-top:20px;">
    <asp:Button 
        ID="btnDelete" 
        runat="server" 
        Text="Supprimer la demande"
        CssClass="btn btn-danger"
        OnClick="btnDelete_Click"
        OnClientClick="return confirm('Voulez-vous vraiment supprimer cette demande ?');" />
</div>
        </asp:Panel>


</div>


    <script type="text/javascript">
    function da_EnterEnregistrer(event, input) {
        if (event.keyCode === 13) {
            event.preventDefault();

            // Trouver la ligne du tableau contenant ce champ
            var row = input.closest('tr');
            if (!row) return false;

            // Chercher le lien "Enregistrer" dans cette même ligne
            var links = row.querySelectorAll('a');
            for (var i = 0; i < links.length; i++) {
                if (links[i].textContent.trim() === 'Enregistrer') {
                    links[i].click();
                    break;
                }
            }

            return false;
        }
    }
    </script>


    
<script type="text/javascript">
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            var tag = e.target.tagName.toLowerCase();
            // Si on est dans un champ texte (pas un bouton/lien), on bloque Entrée
            if (tag === 'input' && e.target.type === 'text') {
                e.preventDefault();
            }
        }
    }, true);
</script>


</asp:Content>