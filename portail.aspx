<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="portail.aspx.cs" Inherits="sabena.portail" %>

<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sabena Technics MIR</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      background:url('/image/bg1.jpg') center/cover no-repeat;
      background-blend-mode: overlay;
      background-color: rgba(0, 0, 0, 0.3);
      color: #fff;
      text-align: center;
    }

    h1 {
      font-size: 3em;
      margin-bottom: 20px;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
    }

    .button-container {
      margin-top: 30px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
    }

    .button-wrapper {
      margin: 10px;
    }

    .button {
      padding: 15px 30px;
      font-size: 1.2em;
      cursor: pointer;
      background-color: rgba(251, 249, 249, 0.48);
      border: 3px solid #2980b9;
      border-radius: 10px;
      text-decoration: none;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: 0.7s ease;
    }
  </style>
</head>
<body>
  <h1>Portail Sabena Technics Mir</h1>
  <form id="Form1" runat="server">
    <div class="button-container">
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton1" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/tline.png" Width="200px" PostBackUrl="http://app.sabenatechnics.com.tn:8084" />
        <h3>TLine</h3>
      </div>
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton2" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/mvt.png" Width="200px" PostBackUrl="http://10.2.0.8/default.aspx" />
        <h3>Mouvement outillage</h3>
      </div>
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton3" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/DAE.png" Width="200px" PostBackUrl="http://app.sabenatechnics.com.tn:8080" />
        <h3>Gestion des DAE</h3>
      </div>
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton4" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/conge.png" Width="200px" PostBackUrl="http://app.sabenatechnics.com.tn:8085" />
        <h3>Demande Congé</h3>
      </div>
             <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton7" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/achat.png" Width="200px" PostBackUrl="http://app.sabenatechnics.com.tn:8086/default.aspx" />
        <h3>Achat</h3>
      </div>
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton5" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/webmail.png" Width="200px" PostBackUrl="https://cpanelserver.hosting-service.tn:2096/webmaillogout.cgi" />
        <h3>Web Mail</h3>
      </div>
      <div class="button-wrapper">
        <asp:ImageButton ID="ImageButton6" runat="server" CssClass="button" Height="120px" ImageUrl="~/image/data-collection.png" Width="200px" PostBackUrl="http://app.sabenatechnics.com.tn:8082/besoinIT.aspx" />
        <h3>Collect Besoin IT</h3>
      </div>
    </div>
  </form>
      <footer>
    <p>For Support | Email: marwene.bhar@sabenatechnics.com | TEL : (+216)29 993 038) 2019 © SABENA Technics MIR.</p>
  </footer>
</body>
</html>
