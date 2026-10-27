<%@ Page Title="Historique Admin DA"
    Language="C#"
    MasterPageFile="~/superadmin.Master"
    AutoEventWireup="true"
    CodeBehind="DA_HISTORIQUE_ADMIN.aspx.cs"
    Inherits="sabena.DA_HISTORIQUE_ADMIN" %>

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
            --info: #3b82f6;
            --info-light: #dbeafe;
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

        .da-hist-wrapper { max-width: 1400px; margin: 0 auto; padding: 32px 24px; font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; color: var(--gray-800); }
        .da-page-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px; margin-bottom: 16px; }
        .da-page-header-left { display: flex; align-items: center; gap: 16px; }
        .da-page-title { font-size: 26px; font-weight: 800; color: var(--gray-900); margin: 0; letter-spacing: -0.5px; }
        .da-page-subtitle { font-size: 14px; color: var(--gray-500); margin: 2px 0 0 0; font-weight: 400; }
        .da-toolbar { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }

        .da-btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; border-radius: 50px; font-size: 14px; font-weight: 600; text-decoration: none !important; border: none; cursor: pointer; transition: var(--transition); letter-spacing: 0.2px; line-height: 1.4; }
        .da-btn-primary { background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: #fff !important; box-shadow: 0 4px 16px rgba(79, 70, 229, 0.3); }
        .da-btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(79, 70, 229, 0.4); color: #fff !important; }
        .da-btn-outline { background: #fff; color: var(--gray-700) !important; border: 2px solid var(--gray-200); box-shadow: var(--shadow-sm); }
        .da-btn-outline:hover { border-color: var(--primary-light); color: var(--primary) !important; transform: translateY(-2px); box-shadow: var(--shadow); }

        /* Action buttons in table */
        .da-btn-action { display: inline-flex; align-items: center; gap: 5px; padding: 6px 14px; border-radius: 50px; font-size: 12px; font-weight: 600; text-decoration: none !important; border: none; cursor: pointer; transition: var(--transition); }
        .da-btn-action-info { background: var(--info-light); color: #1e40af !important; border: 1px solid rgba(59, 130, 246, 0.2); }
        .da-btn-action-info:hover { background: #bfdbfe; transform: translateY(-1px); box-shadow: 0 2px 8px rgba(59, 130, 246, 0.2); color: #1e40af !important; }
        .da-btn-action-success { background: var(--success-light); color: #065f46 !important; border: 1px solid rgba(16, 185, 129, 0.2); }
        .da-btn-action-success:hover { background: #a7f3d0; transform: translateY(-1px); box-shadow: 0 2px 8px rgba(16, 185, 129, 0.2); color: #065f46 !important; }

        .da-card { background: #fff; border-radius: var(--radius); box-shadow: var(--shadow); border: 1px solid var(--gray-100); margin-bottom: 28px; overflow: hidden; transition: var(--transition); }
        .da-card:hover { box-shadow: var(--shadow-lg); }
        .da-card-header { display: flex; align-items: center; gap: 12px; padding: 20px 28px; border-bottom: 1px solid var(--gray-100); background: var(--gray-50); }
        .da-card-header-icon { width: 40px; height: 40px; background: linear-gradient(135deg, var(--primary), var(--primary-light)); border-radius: var(--radius-xs); display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .da-card-header-icon svg { width: 20px; height: 20px; stroke: #fff; fill: none; }
        .da-card-title { font-size: 18px; font-weight: 700; color: var(--gray-900); margin: 0; flex: 1; }
        .da-card-header-count { margin-left: auto; background: rgba(79, 70, 229, 0.1); color: var(--primary); padding: 6px 16px; border-radius: 50px; font-size: 13px; font-weight: 700; flex-shrink: 0; }
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
        .da-table td:nth-child(4) { text-align: right !important; font-weight: 700; color: var(--primary); }
        .da-table tr.da-row-hidden { display: none !important; }

        /* Status badges */
        .da-status-badge { display: inline-flex; align-items: center; gap: 6px; padding: 5px 14px; border-radius: 50px; font-size: 12px; font-weight: 700; letter-spacing: 0.3px; }
        .da-status-dot { width: 7px; height: 7px; border-radius: 50%; display: inline-block; }
        .da-status-valide { background: var(--success-light); color: #065f46; }
        .da-status-valide .da-status-dot { background: var(--success); animation: da-pulse 2s infinite; }
        .da-status-attente { background: var(--warning-light); color: #92400e; }
        .da-status-attente .da-status-dot { background: var(--warning); animation: da-pulse 2s infinite; }
        .da-status-rejete { background: var(--danger-light); color: #991b1b; }
        .da-status-rejete .da-status-dot { background: var(--danger); animation: da-pulse 2s infinite; }

        /* ===== CLIENT PAGINATION ===== */
        .da-pagination { display: flex; align-items: center; justify-content: center; gap: 6px; padding: 20px 28px; background: var(--gray-50); border-top: 2px solid var(--gray-100); flex-wrap: wrap; }
        .da-pagination-btn { display: inline-flex; align-items: center; justify-content: center; min-width: 40px; height: 40px; padding: 0 14px; border-radius: 50px; font-size: 14px; font-weight: 600; text-decoration: none; border: 2px solid var(--gray-200); background: #fff; color: var(--gray-600); cursor: pointer; transition: var(--transition); }
        .da-pagination-btn:hover { color: var(--primary); border-color: var(--primary-light); background: #eef2ff; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15); }
        .da-pagination-btn.da-active { color: #fff; background: linear-gradient(135deg, var(--primary), var(--primary-dark)); border-color: var(--primary); box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3); cursor: default; }
        .da-pagination-btn.da-disabled { opacity: 0.4; cursor: default; pointer-events: none; }
        .da-pagination-info { font-size: 13px; color: var(--gray-500); font-weight: 500; margin: 0 12px; }
        .da-pagination-info strong { color: var(--primary); font-weight: 700; }

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
            .da-hist-wrapper { padding: 16px 12px; }
            .da-table th, .da-table td { padding: 10px !important; font-size: 12px !important; }
            .da-card-header { flex-wrap: wrap; }
            .da-card-header-count { margin-left: 0; }
            .da-search-bar { flex-direction: column; align-items: stretch; }
            .da-search-wrapper { max-width: 100%; min-width: auto; }
            .da-search-results-info { margin-left: 0; text-align: center; }
            .da-pagination { gap: 4px; padding: 16px 12px; }
            .da-pagination-btn { min-width: 36px; height: 36px; font-size: 13px; padding: 0 10px; }
        }
        @media (max-width: 576px) {
            .da-toolbar { width: 100%; }
            .da-toolbar .da-btn { flex: 1; justify-content: center; }
        }
        @media print {
            .da-toolbar, .da-pagination, .da-search-bar, .da-no-results-msg,
            .da-table th:last-child, .da-table td:last-child { display: none !important; }
            .da-card { box-shadow: none !important; border: 1px solid #ddd !important; }
            .da-hist-wrapper { padding: 0 !important; }
            .da-table tr.da-row-hidden { display: table-row !important; }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="da-page-header">
        <div class="da-page-header-left">
            <div>
                <h2 class="da-page-title">Historique admin des Demandes d'Achat</h2>
                <p class="da-page-subtitle">demandes validées et refusées par l'administration </p>
            </div>
        </div>
        <div class="da-toolbar">
            
            <a href="javascript:window.print();" class="da-btn da-btn-outline">Imprimer</a>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="da-hist-wrapper da-fade-in">
        <div class="da-card da-fade-in-up">

            <div class="da-card-header">
                <div class="da-card-header-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                </div>
                <h3 class="da-card-title">Liste des Demandes</h3>
                <div class="da-card-header-count" id="daHeaderCount"></div>
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
                           placeholder="Rechercher par numero, demandeur, statut..." autocomplete="off" />
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
                <div class="da-no-results-text">Aucune demande trouvee</div>
                <div class="da-no-results-sub">Modifiez votre recherche ou effacez le filtre</div>
            </div>

            <!-- TABLE -->
            <div class="da-card-body">
                <div class="da-table-wrapper">

                    <asp:GridView ID="gvDA" runat="server"
                        CssClass="da-table"
                        AutoGenerateColumns="False"
                        GridLines="None"
                        AllowPaging="False"
                        OnRowCommand="gvDA_RowCommand">

                        <Columns>

                            <asp:BoundField DataField="NumeroDA" HeaderText="N DA" />

                            <asp:BoundField DataField="DateDA" HeaderText="Date"
                                DataFormatString="{0:dd/MM/yyyy HH:mm}" />

                            <asp:BoundField DataField="Demandeur" HeaderText="Demandeur" />

                            <asp:BoundField DataField="Total" HeaderText="Total"
                                DataFormatString="{0:N3}" />

                            <asp:TemplateField HeaderText="Statut">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatut" runat="server"
                                        Text='<%# Eval("Statut") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>

                                    <asp:HyperLink ID="btnVoir" runat="server"
                                        CssClass="da-btn-action da-btn-action-info"
                                        NavigateUrl='<%# "DA_DETAIL_ADMIN.aspx?id=" + Eval("IDDA") %>'
                                        Text="Consulter">
                                    </asp:HyperLink>

                                    <asp:LinkButton ID="btnDownload" runat="server"
                                        CssClass="da-btn-action da-btn-action-success"
                                        CommandName="download"
                                        CommandArgument='<%# Eval("FichierExcel") %>'
                                        Text="Telecharger">
                                    </asp:LinkButton>

                                </ItemTemplate>
                                <ItemStyle Width="220px" />
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>
            </div>

            <!-- CLIENT PAGINATION -->
            <div class="da-pagination" id="daPagination"></div>

        </div>
    </div>

    <!-- ===== CLIENT-SIDE FILTER + PAGINATION + STATUS BADGES ===== -->
    <script type="text/javascript">
        (function () {

            var ROWS_PER_PAGE = 10;
            var currentPage = 0;

            var searchInput = document.getElementById('daSearchInput');
            var clearBtn = document.getElementById('daSearchClear');
            var infoDiv = document.getElementById('daSearchInfo');
            var noResults = document.getElementById('daNoResults');
            var paginationDiv = document.getElementById('daPagination');
            var headerCount = document.getElementById('daHeaderCount');
            var table = document.querySelector('.da-table');

            if (!table) return;

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

            // Style status badges
            function styleStatuses() {
                for (var i = 0; i < allDataRows.length; i++) {
                    var cells = allDataRows[i].querySelectorAll('td');
                    if (cells.length > 4) {
                        var statusCell = cells[4];
                        var span = statusCell.querySelector('span');
                        if (span) {
                            var text = (span.textContent || span.innerText).trim().toLowerCase();
                            var cls = 'da-status-attente';
                            if (text.indexOf('valid') > -1) cls = 'da-status-valide';
                            else if (text.indexOf('rejet') > -1 || text.indexOf('refus') > -1) cls = 'da-status-rejete';
                            span.className = 'da-status-badge ' + cls;
                            span.innerHTML = '<span class="da-status-dot"></span>' + span.textContent.trim();
                        }
                    }
                }
            }

            // Update header count
            function updateHeaderCount() {
                if (headerCount) {
                    headerCount.textContent = allDataRows.length + ' demande(s)';
                }
            }

            // Get searchable text
            function getRowText(row) {
                var cells = row.querySelectorAll('td');
                var text = '';
                for (var c = 0; c < cells.length - 1; c++) {
                    text += ' ' + (cells[c].textContent || cells[c].innerText);
                }
                return text.toLowerCase();
            }

            // Filter
            function getFilteredRows() {
                var query = searchInput ? searchInput.value.toLowerCase().trim() : '';
                var result = [];
                for (var i = 0; i < allDataRows.length; i++) {
                    if (query === '' || getRowText(allDataRows[i]).indexOf(query) > -1) {
                        result.push(allDataRows[i]);
                    }
                }
                return result;
            }

            // Render page
            function renderPage() {
                var start = currentPage * ROWS_PER_PAGE;
                var end = start + ROWS_PER_PAGE;

                for (var i = 0; i < allDataRows.length; i++) {
                    allDataRows[i].style.display = 'none';
                }

                for (var j = 0; j < filteredRows.length; j++) {
                    if (j >= start && j < end) {
                        filteredRows[j].style.display = '';
                    }
                }

                renderPagination();
                updateInfo();
                updateNoResults();
            }

            // Pagination
            function renderPagination() {
                if (!paginationDiv) return;
                var totalPages = Math.ceil(filteredRows.length / ROWS_PER_PAGE);
                if (totalPages <= 1) { paginationDiv.innerHTML = ''; paginationDiv.style.display = 'none'; return; }

                paginationDiv.style.display = 'flex';
                var html = '';

                if (currentPage > 0) {
                    html += '<button class="da-pagination-btn" data-page="' + (currentPage - 1) + '">&laquo; Prec</button>';
                } else {
                    html += '<button class="da-pagination-btn da-disabled">&laquo; Prec</button>';
                }

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

                if (currentPage < totalPages - 1) {
                    html += '<button class="da-pagination-btn" data-page="' + (currentPage + 1) + '">Suiv &raquo;</button>';
                } else {
                    html += '<button class="da-pagination-btn da-disabled">Suiv &raquo;</button>';
                }

                var from = (currentPage * ROWS_PER_PAGE) + 1;
                var to = Math.min((currentPage + 1) * ROWS_PER_PAGE, filteredRows.length);
                html += '<span class="da-pagination-info">Page <strong>' + (currentPage + 1) + '</strong> / <strong>' + totalPages + '</strong> (' + from + '-' + to + ')</span>';

                paginationDiv.innerHTML = html;

                var btns = paginationDiv.querySelectorAll('[data-page]');
                for (var b = 0; b < btns.length; b++) {
                    btns[b].addEventListener('click', function () {
                        currentPage = parseInt(this.getAttribute('data-page'));
                        renderPage();
                    });
                }
            }

            function updateInfo() {
                if (!infoDiv) return;
                var query = searchInput ? searchInput.value.trim() : '';
                if (query.length > 0) {
                    infoDiv.innerHTML = '<strong>' + filteredRows.length + '</strong> sur <strong>' + allDataRows.length + '</strong> demande(s)';
                } else {
                    infoDiv.innerHTML = '<strong>' + allDataRows.length + '</strong> demande(s) au total';
                }
            }

            function updateNoResults() {
                if (!noResults) return;
                var query = searchInput ? searchInput.value.trim() : '';
                if (filteredRows.length === 0 && query.length > 0) {
                    noResults.className = 'da-no-results-msg da-visible';
                } else {
                    noResults.className = 'da-no-results-msg';
                }
            }

            function updateClearBtn() {
                if (!clearBtn || !searchInput) return;
                if (searchInput.value.length > 0) {
                    clearBtn.className = 'da-search-clear-btn da-visible';
                } else {
                    clearBtn.className = 'da-search-clear-btn';
                }
            }

            function filterAndPaginate() {
                updateClearBtn();
                filteredRows = getFilteredRows();
                currentPage = 0;
                renderPage();
            }

            // Events
            if (searchInput) {
                searchInput.addEventListener('keyup', filterAndPaginate);
                searchInput.addEventListener('input', filterAndPaginate);
                searchInput.addEventListener('paste', function () { setTimeout(filterAndPaginate, 50); });
            }

            if (clearBtn) {
                clearBtn.addEventListener('click', function () {
                    searchInput.value = '';
                    filterAndPaginate();
                    searchInput.focus();
                });
            }

            // Init
            styleStatuses();
            updateHeaderCount();
            filteredRows = allDataRows.slice();
            renderPage();

        })();
    </script>

</asp:Content>