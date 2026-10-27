<%@ Page Title="Demande Achat" Language="C#" MasterPageFile="~/MAGASIN.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="DA_AUTO.aspx.cs" Inherits="sabena.DA_AUTO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
    <link href="assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="assets/css/main-responsive.css" />

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

        .da-auto-wrapper { max-width: 1400px; margin: 0 auto; padding: 32px 24px; font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; color: var(--gray-800); }
        .da-page-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px; margin-bottom: 16px; }
        .da-page-header-left { display: flex; align-items: center; gap: 16px; }
        .da-page-title { font-size: 26px; font-weight: 800; color: var(--gray-900); margin: 0; letter-spacing: -0.5px; }
        .da-page-subtitle { font-size: 14px; color: var(--gray-500); margin: 2px 0 0 0; font-weight: 400; }
        .da-toolbar { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }

        .da-btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; border-radius: 50px; font-size: 14px; font-weight: 600; text-decoration: none !important; border: none; cursor: pointer; transition: var(--transition); letter-spacing: 0.2px; line-height: 1.4; }
        .da-btn-danger { background: linear-gradient(135deg, var(--danger), #dc2626); color: #fff !important; box-shadow: 0 4px 16px rgba(239, 68, 68, 0.3); }
        .da-btn-danger:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(239, 68, 68, 0.4); color: #fff !important; }
        .da-btn-outline { background: #fff; color: var(--gray-700) !important; border: 2px solid var(--gray-200); box-shadow: var(--shadow-sm); }
        .da-btn-outline:hover { border-color: var(--primary-light); color: var(--primary) !important; transform: translateY(-2px); box-shadow: var(--shadow); }
        .da-btn-lg { padding: 14px 28px; font-size: 15px; font-weight: 700; }

        .da-history-link { display: inline-flex; align-items: center; gap: 8px; padding: 8px 18px; border-radius: 50px; font-size: 13px; font-weight: 600; color: var(--primary) !important; background: rgba(79, 70, 229, 0.08); text-decoration: none !important; transition: var(--transition); border: 1px solid rgba(79, 70, 229, 0.15); }
        .da-history-link:hover { background: rgba(79, 70, 229, 0.15); transform: translateY(-1px); color: var(--primary-dark) !important; }

        .da-card { background: #fff; border-radius: var(--radius); box-shadow: var(--shadow); border: 1px solid var(--gray-100); margin-bottom: 28px; overflow: hidden; transition: var(--transition); }
        .da-card:hover { box-shadow: var(--shadow-lg); }
        .da-card-header { display: flex; align-items: center; gap: 12px; padding: 20px 28px; border-bottom: 1px solid var(--gray-100); background: var(--gray-50); }
        .da-card-header-icon { width: 40px; height: 40px; background: linear-gradient(135deg, var(--primary), var(--primary-light)); border-radius: var(--radius-xs); display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .da-card-header-icon svg { width: 20px; height: 20px; stroke: #fff; fill: none; }
        .da-card-title { font-size: 18px; font-weight: 700; color: var(--gray-900); margin: 0; flex: 1; }
        .da-card-header-badge { margin-left: auto; background: var(--danger-light); color: #991b1b; padding: 6px 16px; border-radius: 50px; font-size: 13px; font-weight: 700; display: flex; align-items: center; gap: 6px; flex-shrink: 0; }
        .da-card-header-badge .da-pulse-dot { width: 8px; height: 8px; background: var(--danger); border-radius: 50%; animation: da-pulse 2s infinite; }
        .da-card-body { padding: 0; }

        /* ===== SEARCH ===== */
        .da-search-bar { display: flex; align-items: center; gap: 12px; padding: 20px 28px; background: #fff; border-bottom: 1px solid var(--gray-100); flex-wrap: wrap; }
        .da-search-wrapper { position: relative; flex: 1; min-width: 250px; max-width: 500px; }
        .da-search-icon { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); pointer-events: none; }
        .da-search-icon svg { width: 18px; height: 18px; stroke: var(--gray-400); fill: none; }
        .da-search-input { width: 100%; padding: 12px 44px 12px 46px; border: 2px solid var(--gray-200); border-radius: 50px; font-size: 14px; font-weight: 500; color: var(--gray-800); background: var(--gray-50); transition: var(--transition); outline: none; box-sizing: border-box; }
        .da-search-input:focus { border-color: var(--primary); background: #fff; box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1); }
        .da-search-input::placeholder { color: var(--gray-400); font-weight: 400; }
        .da-search-clear-btn { position: absolute; right: 8px; top: 50%; transform: translateY(-50%); width: 32px; height: 32px; border: none; background: var(--gray-200); border-radius: 50%; cursor: pointer; display: none; align-items: center; justify-content: center; transition: var(--transition); padding: 0; }
        .da-search-clear-btn:hover { background: var(--gray-300); }
        .da-search-clear-btn svg { width: 14px; height: 14px; stroke: var(--gray-600); fill: none; }
        .da-search-clear-btn.da-visible { display: flex; }
        .da-search-results-info { font-size: 13px; color: var(--gray-500); font-weight: 500; margin-left: auto; white-space: nowrap; }
        .da-search-results-info strong { color: var(--primary); font-weight: 700; }

        /* ===== NO RESULTS ===== */
        .da-no-results-msg { text-align: center; padding: 60px 28px; color: var(--gray-400); display: none; }
        .da-no-results-msg.da-visible { display: block; }
        .da-no-results-icon { width: 64px; height: 64px; margin: 0 auto 16px; background: var(--gray-100); border-radius: 50%; display: flex; align-items: center; justify-content: center; }
        .da-no-results-icon svg { width: 32px; height: 32px; stroke: var(--gray-400); fill: none; }
        .da-no-results-text { font-size: 16px; font-weight: 600; color: var(--gray-500); margin-bottom: 4px; }
        .da-no-results-sub { font-size: 13px; color: var(--gray-400); }

        /* ===== TABLE ===== */
        .da-table-wrapper { overflow-x: auto; }
        .da-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 14px; }
        .da-table th { background: linear-gradient(135deg, var(--gray-800), var(--gray-700)) !important; color: #fff !important; font-weight: 600 !important; font-size: 12px !important; text-transform: uppercase !important; letter-spacing: 0.8px !important; padding: 14px 16px !important; text-align: left !important; border: none !important; white-space: nowrap; }
        .da-table td { padding: 12px 16px !important; border-bottom: 1px solid var(--gray-100) !important; border-left: none !important; border-right: none !important; border-top: none !important; color: var(--gray-700); font-weight: 500; text-align: left !important; vertical-align: middle !important; background: transparent !important; transition: var(--transition); }
        .da-table tr:last-child td { border-bottom: none !important; }
        .da-table tr:hover td { background: #eef2ff !important; }
        .da-table tr:nth-child(even) td { background: rgba(249, 250, 251, 0.5) !important; }
        .da-table tr:nth-child(even):hover td { background: #eef2ff !important; }
        .da-table td:nth-child(1), .da-table th:nth-child(1) { text-align: center !important; width: 50px; }
        .da-table td:nth-child(4), .da-table td:nth-child(5), .da-table td:nth-child(7), .da-table td:nth-child(8),
        .da-table th:nth-child(4), .da-table th:nth-child(5), .da-table th:nth-child(7), .da-table th:nth-child(8) { text-align: center !important; }
        .da-table input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: var(--primary); }
        .da-table tr.da-row-hidden { display: none !important; }

        .da-badge-rupture { display: inline-flex; align-items: center; justify-content: center; min-width: 40px; padding: 4px 12px; border-radius: 50px; font-size: 13px; font-weight: 700; background: var(--danger-light); color: #991b1b; }
        .da-qte-input { width: 80px !important; padding: 8px 12px !important; border: 2px solid var(--gray-200) !important; border-radius: var(--radius-xs) !important; font-size: 14px !important; font-weight: 600 !important; text-align: center !important; color: var(--gray-800) !important; background: var(--gray-50) !important; transition: var(--transition) !important; -moz-appearance: textfield; }
        .da-qte-input:focus { border-color: var(--primary) !important; background: #fff !important; box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1) !important; outline: none !important; }
        .da-qte-input::-webkit-outer-spin-button, .da-qte-input::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; }

        /* ===== CLIENT PAGINATION ===== */
        .da-pagination { display: flex; align-items: center; justify-content: center; gap: 6px; padding: 20px 28px; background: var(--gray-50); border-top: 2px solid var(--gray-100); flex-wrap: wrap; }
        .da-pagination-btn { display: inline-flex; align-items: center; justify-content: center; min-width: 40px; height: 40px; padding: 0 14px; border-radius: 50px; font-size: 14px; font-weight: 600; text-decoration: none; border: 2px solid var(--gray-200); background: #fff; color: var(--gray-600); cursor: pointer; transition: var(--transition); }
        .da-pagination-btn:hover { color: var(--primary); border-color: var(--primary-light); background: #eef2ff; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15); }
        .da-pagination-btn.da-active { color: #fff; background: linear-gradient(135deg, var(--primary), var(--primary-dark)); border-color: var(--primary); box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3); cursor: default; }
        .da-pagination-btn.da-disabled { opacity: 0.4; cursor: default; pointer-events: none; }
        .da-pagination-info { font-size: 13px; color: var(--gray-500); font-weight: 500; margin: 0 12px; }
        .da-pagination-info strong { color: var(--primary); font-weight: 700; }

        /* ===== ACTIONS BAR ===== */
        .da-actions-bar { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; padding: 24px 28px; background: var(--gray-50); border-top: 1px solid var(--gray-100); border-radius: 0 0 var(--radius) var(--radius); }
        .da-actions-bar-info { margin-left: auto; font-size: 13px; color: var(--gray-500); display: flex; align-items: center; gap: 6px; }

        /* ===== ANIMATIONS ===== */
        .da-fade-in { animation: da-fadeIn 0.5s ease-out; }
        .da-fade-in-up { animation: da-fadeInUp 0.6s ease-out; }
        @keyframes da-fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes da-fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes da-pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .da-page-header { flex-direction: column; align-items: flex-start; }
            .da-page-title { font-size: 20px; }
            .da-auto-wrapper { padding: 16px 12px; }
            .da-actions-bar { flex-direction: column; align-items: stretch; }
            .da-actions-bar .da-btn { justify-content: center; }
            .da-actions-bar-info { margin-left: 0; justify-content: center; }
            .da-table th, .da-table td { padding: 10px !important; font-size: 12px !important; }
            .da-card-header { flex-wrap: wrap; }
            .da-card-header-badge { margin-left: 0; }
            .da-search-bar { flex-direction: column; align-items: stretch; }
            .da-search-wrapper { max-width: 100%; min-width: auto; }
            .da-search-results-info { margin-left: 0; text-align: center; }
            .da-pagination { gap: 4px; padding: 16px 12px; }
            .da-pagination-btn { min-width: 36px; height: 36px; font-size: 13px; padding: 0 10px; }
        }
        @media (max-width: 576px) {
            .da-toolbar { width: 100%; }
            .da-toolbar .da-btn, .da-toolbar .da-history-link { flex: 1; justify-content: center; }
        }
        @media print {
            .da-toolbar, .da-actions-bar, .da-pagination, .da-search-bar, .da-no-results-msg,
            .da-table th:first-child, .da-table td:first-child,
            .da-table th:last-child, .da-table td:last-child { display: none !important; }
            .da-card { box-shadow: none !important; border: 1px solid #ddd !important; }
            .da-auto-wrapper { padding: 0 !important; }
            .da-table tr.da-row-hidden { display: table-row !important; }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="da-page-header">
        <div class="da-page-header-left">
            <div>
                <h2 class="da-page-title">Demande d'Achat</h2>
                <p class="da-page-subtitle">Articles en rupture ou sous le seuil minimum</p>
            </div>
        </div>
        <div class="da-toolbar">
            <asp:LinkButton ID="LinkButton1" runat="server"
                PostBackUrl="~/DA_HISTORIQUE.aspx"
                CssClass="da-history-link"
                Text="Historique des DA">
            </asp:LinkButton>
            <a href="DA_AUTO.aspx" class="da-btn da-btn-outline">Actualiser</a>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="da-auto-wrapper da-fade-in">
        <div class="da-card da-fade-in-up">

            <div class="da-card-header">
                <div class="da-card-header-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="1" y="3" width="15" height="13"></rect>
                        <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                        <circle cx="5.5" cy="18.5" r="2.5"></circle>
                        <circle cx="18.5" cy="18.5" r="2.5"></circle>
                    </svg>
                </div>
                <h3 class="da-card-title">Articles a Commander</h3>
                <div class="da-card-header-badge">
                    <span class="da-pulse-dot"></span>
                    Reapprovisionnement requis
                </div>
            </div>

            <!-- SEARCH BAR -->
            <div class="da-search-bar">
                <div class="da-search-wrapper">
                    <div class="da-search-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                    </div>
                    <input type="text" id="daSearchInput" class="da-search-input"
                           placeholder="Rechercher par code, designation ou fournisseur..." autocomplete="off" />
                    <button type="button" id="daSearchClear" class="da-search-clear-btn" title="Effacer">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                </div>
                <div class="da-search-results-info" id="daSearchInfo"></div>
            </div>

            <!-- NO RESULTS -->
            <div class="da-no-results-msg" id="daNoResults">
                <div class="da-no-results-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="11" cy="11" r="8"></circle>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        <line x1="8" y1="11" x2="14" y2="11"></line>
                    </svg>
                </div>
                <div class="da-no-results-text">Aucun article trouve</div>
                <div class="da-no-results-sub">Modifiez votre recherche ou effacez le filtre</div>
            </div>

            <!-- TABLE -->
            <div class="da-card-body">
                <div class="da-table-wrapper">
                    <asp:GridView ID="gv" runat="server"
                        CssClass="da-table"
                        AutoGenerateColumns="False"
                        GridLines="None"
                        AllowPaging="False"
                        DataKeyNames="ID,DesignationARTICLE,QTE,prixunitaire">
                        <Columns>
                            <asp:TemplateField HeaderText="Sel.">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" Checked="false" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="ID" HeaderText="Code" />
                            <asp:BoundField DataField="DesignationARTICLE" HeaderText="Designation" />
                            <asp:TemplateField HeaderText="Stock Actuel">
                                <ItemTemplate>
                                    <asp:Label ID="lblStock" runat="server" Text='<%# Eval("QTE") %>' CssClass="da-badge-rupture"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Stockmin" HeaderText="Seuil Min" />
                            <asp:BoundField DataField="Fournisseur" HeaderText="Fournisseur" />
                            <asp:BoundField DataField="prixunitaire" HeaderText="P.U" DataFormatString="{0:N3}" />
                            <asp:TemplateField HeaderText="Qte a Commander">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQte" runat="server" Text="1" CssClass="da-qte-input" TextMode="Number"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- CLIENT PAGINATION -->
            <div class="da-pagination" id="daPagination"></div>

            <!-- ACTIONS -->
            <div class="da-actions-bar">
                <asp:LinkButton ID="btnGenerer" runat="server"
                    CssClass="da-btn da-btn-danger da-btn-lg"
                    OnClick="btnGenerer_Click"
                    Text="Enregistrer et Generer Excel">
                </asp:LinkButton>
                <a href="DA_AUTO.aspx" class="da-btn da-btn-outline">Actualiser la liste</a>
                <div class="da-actions-bar-info">
                    Cochez les articles puis cliquez sur Enregistrer
                </div>
            </div>

        </div>
    </div>

    <!-- ===== CLIENT-SIDE FILTER + PAGINATION ===== -->
    <script type="text/javascript">
        (function () {

            var ROWS_PER_PAGE = 10;
            var currentPage = 0;

            var searchInput = document.getElementById('daSearchInput');
            var clearBtn = document.getElementById('daSearchClear');
            var infoDiv = document.getElementById('daSearchInfo');
            var noResults = document.getElementById('daNoResults');
            var paginationDiv = document.getElementById('daPagination');
            var table = document.querySelector('.da-table');

            if (!searchInput || !table) return;

            var allDataRows = [];
            var filteredRows = [];

            // Collect data rows
            var rows = table.querySelectorAll('tr');
            for (var i = 0; i < rows.length; i++) {
                var cells = rows[i].querySelectorAll('td');
                if (cells.length > 1) {
                    allDataRows.push(rows[i]);
                }
            }

            // Get searchable text from a row
            function getRowText(row) {
                var cells = row.querySelectorAll('td');
                var text = '';
                if (cells[1]) text += ' ' + (cells[1].textContent || cells[1].innerText);
                if (cells[2]) text += ' ' + (cells[2].textContent || cells[2].innerText);
                if (cells[5]) text += ' ' + (cells[5].textContent || cells[5].innerText);
                return text.toLowerCase();
            }

            // Filter rows based on search
            function getFilteredRows() {
                var query = searchInput.value.toLowerCase().trim();
                var result = [];
                for (var i = 0; i < allDataRows.length; i++) {
                    if (query === '' || getRowText(allDataRows[i]).indexOf(query) > -1) {
                        result.push(allDataRows[i]);
                    }
                }
                return result;
            }

            // Show/hide rows for current page
            function renderPage() {
                var start = currentPage * ROWS_PER_PAGE;
                var end = start + ROWS_PER_PAGE;

                // Hide all data rows first
                for (var i = 0; i < allDataRows.length; i++) {
                    allDataRows[i].style.display = 'none';
                }

                // Show only current page rows from filtered set
                for (var j = 0; j < filteredRows.length; j++) {
                    if (j >= start && j < end) {
                        filteredRows[j].style.display = '';
                    }
                }

                renderPagination();
                updateInfo();
                updateNoResults();
            }

            // Build pagination buttons
            function renderPagination() {
                if (!paginationDiv) return;

                var totalPages = Math.ceil(filteredRows.length / ROWS_PER_PAGE);
                if (totalPages <= 1) {
                    paginationDiv.innerHTML = '';
                    paginationDiv.style.display = 'none';
                    return;
                }

                paginationDiv.style.display = 'flex';
                var html = '';

                // Previous
                if (currentPage > 0) {
                    html += '<button class="da-pagination-btn" data-page="' + (currentPage - 1) + '">&laquo; Prec</button>';
                } else {
                    html += '<button class="da-pagination-btn da-disabled">&laquo; Prec</button>';
                }

                // Page numbers
                var startPage = Math.max(0, currentPage - 2);
                var endPage = Math.min(totalPages - 1, currentPage + 2);

                if (startPage > 0) {
                    html += '<button class="da-pagination-btn" data-page="0">1</button>';
                    if (startPage > 1) html += '<span class="da-pagination-info">...</span>';
                }

                for (var p = startPage; p <= endPage; p++) {
                    if (p === currentPage) {
                        html += '<button class="da-pagination-btn da-active">' + (p + 1) + '</button>';
                    } else {
                        html += '<button class="da-pagination-btn" data-page="' + p + '">' + (p + 1) + '</button>';
                    }
                }

                if (endPage < totalPages - 1) {
                    if (endPage < totalPages - 2) html += '<span class="da-pagination-info">...</span>';
                    html += '<button class="da-pagination-btn" data-page="' + (totalPages - 1) + '">' + totalPages + '</button>';
                }

                // Next
                if (currentPage < totalPages - 1) {
                    html += '<button class="da-pagination-btn" data-page="' + (currentPage + 1) + '">Suiv &raquo;</button>';
                } else {
                    html += '<button class="da-pagination-btn da-disabled">Suiv &raquo;</button>';
                }

                // Page info
                var from = (currentPage * ROWS_PER_PAGE) + 1;
                var to = Math.min((currentPage + 1) * ROWS_PER_PAGE, filteredRows.length);
                html += '<span class="da-pagination-info">Page <strong>' + (currentPage + 1) + '</strong> / <strong>' + totalPages + '</strong> (' + from + '-' + to + ')</span>';

                paginationDiv.innerHTML = html;

                // Bind click events
                var btns = paginationDiv.querySelectorAll('[data-page]');
                for (var b = 0; b < btns.length; b++) {
                    btns[b].addEventListener('click', function () {
                        currentPage = parseInt(this.getAttribute('data-page'));
                        renderPage();
                    });
                }
            }

            // Update search info
            function updateInfo() {
                if (!infoDiv) return;
                var query = searchInput.value.trim();
                if (query.length > 0) {
                    infoDiv.innerHTML = '<strong>' + filteredRows.length + '</strong> sur <strong>' + allDataRows.length + '</strong> article(s)';
                } else {
                    infoDiv.innerHTML = '<strong>' + allDataRows.length + '</strong> article(s) au total';
                }
            }

            // Show/hide no results
            function updateNoResults() {
                if (!noResults) return;
                var query = searchInput.value.trim();
                if (filteredRows.length === 0 && query.length > 0) {
                    noResults.className = 'da-no-results-msg da-visible';
                } else {
                    noResults.className = 'da-no-results-msg';
                }
            }

            // Show/hide clear button
            function updateClearBtn() {
                if (!clearBtn) return;
                if (searchInput.value.length > 0) {
                    clearBtn.className = 'da-search-clear-btn da-visible';
                } else {
                    clearBtn.className = 'da-search-clear-btn';
                }
            }

            // Main filter + paginate
            function filterAndPaginate() {
                updateClearBtn();
                filteredRows = getFilteredRows();
                currentPage = 0;
                renderPage();
            }

            // Events
            searchInput.addEventListener('keyup', filterAndPaginate);
            searchInput.addEventListener('input', filterAndPaginate);
            searchInput.addEventListener('paste', function () { setTimeout(filterAndPaginate, 50); });

            if (clearBtn) {
                clearBtn.addEventListener('click', function () {
                    searchInput.value = '';
                    filterAndPaginate();
                    searchInput.focus();
                });
            }

            // Initial render
            filteredRows = allDataRows.slice();
            renderPage();

        })();
    </script>

</asp:Content>