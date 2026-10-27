<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="printmeca.aspx.cs"
Inherits="sabena.printmeca" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Badge Mécanicien</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f5f5;
            font-family: Arial, sans-serif;
            padding: 10px;
        }

        .badge {
            width: 85mm;
            height: 54mm;
            margin: 10px auto;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            position: relative;
            border: 1px solid #ddd;
        }

        .header {
            background: #1e3a8a;  /* Bleu foncé en couleur solide */
            color: white;
            padding: 8px 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            -webkit-print-color-adjust: exact !important;
            print-color-adjust: exact !important;
            color-adjust: exact !important;
        }

        .logo {
            font-size: 14px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .badge-type {
            font-size: 9px;
            background: rgba(255,255,255,0.25);
            padding: 2px 6px;
            border-radius: 3px;
            border: 1px solid rgba(255,255,255,0.4);
        }

        .content {
            padding: 10px 12px;
            display: table;
            width: 100%;
            height: calc(100% - 48px);
        }

        .info-section {
            display: table-cell;
            vertical-align: top;
            width: 65%;
            padding-right: 8px;
        }

        .qr-section {
            display: table-cell;
            vertical-align: middle;
            text-align: center;
            width: 35%;
        }

        .name {
            font-size: 13px;
            font-weight: bold;
            color: #1e293b;
            line-height: 1.3;
            margin-bottom: 6px;
        }

        .id-label {
            font-size: 9px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 6px;
        }

        .id-number {
            font-size: 16px;
            font-weight: bold;
            color: #3b82f6;
            font-family: 'Courier New', monospace;
            margin-top: 2px;
        }

        .barcode-section {
            margin-top: 8px;
        }

        .barcode-section img {
            width: 100%;
            height: auto;
            max-height: 35px;
            display: block;
        }

        .date {
            font-size: 8px;
            color: #94a3b8;
            margin-top: 4px;
        }

        .qr-section img {
            width: 65px;
            height: 65px;
            border: 2px solid #e2e8f0;
            border-radius: 4px;
            padding: 2px;
            background: white;
        }

        .footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            padding: 3px 8px;
            font-size: 7px;
            color: #94a3b8;
            text-align: center;
            -webkit-print-color-adjust: exact !important;
            print-color-adjust: exact !important;
        }

        /* STYLES D'IMPRESSION CRITIQUES */
        @media print {
            @page {
                size: 85mm 54mm;
                margin: 0;
            }

            body {
                background: white !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            
            .badge {
                box-shadow: none !important;
                margin: 0 !important;
                page-break-after: avoid !important;
                border: 1px solid #000 !important;
                width: 85mm !important;
                height: 54mm !important;
            }

            .header {
                background: #1e3a8a !important;
                color: white !important;
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
                color-adjust: exact !important;
            }

            .footer {
                background: #f8fafc !important;
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
            }

            /* Force les couleurs */
            * {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
                color-adjust: exact !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="badge">
            <!-- En-tête -->
            <div class="header">
                <div class="logo">SABENA TECHNICS</div>
                <div class="badge-type">MÉCANICIEN</div>
            </div>

            <!-- Contenu principal -->
            <div class="content">
                <!-- Informations à gauche -->
                <div class="info-section">
                    <div class="name">
                        <asp:Label ID="nomtxt" runat="server" />
                        <asp:Label ID="PrenomTXT" runat="server" />
                    </div>
                    
                    <div class="id-label">ID Mécanicien</div>
                    <div class="id-number">
                        <asp:Label ID="IDtxt" runat="server" />
                    </div>

                    <!-- Code-barres -->
                    <div class="barcode-section">
                        <asp:Image ID="imgBarcode" runat="server" />
                    </div>
                    
                    <div class="date">
                        <asp:Label ID="time" runat="server" />
                    </div>
                </div>

                <!-- QR Code à droite -->
                <div class="qr-section">
                    <asp:Image ID="imgQR" runat="server" />
                </div>
            </div>

            <!-- Pied de page -->
            <div class="footer">
                Document officiel • Accès sécurisé
            </div>
        </div>

    </form>

    <script type="text/javascript">
        // Auto-print après chargement complet
        window.onload = function () {
            setTimeout(function () {
                window.print();
            }, 1000);
        };
    </script>
</body>
</html>