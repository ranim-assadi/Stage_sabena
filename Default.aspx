<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="sabena.Default1" %>

<!DOCTYPE html>

<html lang="fr" class="no-js">

<head id="Head1" runat="server">

    <title>Connexion</title>

    <!-- START: MAIN CSS -->
    <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/fonts/style.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/main-responsive.css" />
    <link rel="stylesheet" href="assets/plugins/iCheck/skins/all.css" />
    <link rel="stylesheet" href="assets/plugins/bootstrap-colorpalette/css/bootstrap-colorpalette.css" />
    <link rel="stylesheet" href="assets/plugins/perfect-scrollbar/src/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/css/theme_light.css" type="text/css" id="skin_color" />
    <link rel="stylesheet" href="assets/css/print.css" type="text/css" media="print" />

    <link type="text/css"
        href="js/ui-lightness/jquery-ui-1.8.16.custom.css"
        rel="stylesheet" />

    <link rel="shortcut icon"
        href="http://www.sabenatechnics.com/wp-content/uploads/2016/04/favicon.png"
        type="image/png" />

</head>

<body id="Body1" class="login example2" runat="server">

    <!-- FORM ASP.NET -->
    <form id="form1" runat="server">

        <div class="main-login col-sm-4 col-sm-offset-4">

            <!-- LOGO -->
            <div class="logo">

                <br />

                <a href="default.aspx">

                    <asp:Image ID="Image2"
                        runat="server"
                        ImageUrl="~/image/sabenatechnics_logo.png"
                        Height="110"
                        Width="270" />

                </a>

            </div>

            <!-- START: LOGIN BOX -->
            <div class="box-login">

                <h3>Connectez-vous</h3>

                <p>
                    S'il vous plaît entrer votre Email et mot de passe pour vous connecter.
                </p>

                <!-- PANEL POUR ENTER -->
                <asp:Panel ID="pnlLogin"
                    runat="server"
                    DefaultButton="btnLogin">

                    <!-- FORM LOGIN -->
                    <div class="form-login">

                        <!-- ERROR -->
                        <center>

                            <div style="display:block;">

                                <asp:Label ID="errorr"
                                    runat="server"
                                    CssClass="errorHandler alert alert-danger"
                                    Visible="false"
                                    Text="">
                                </asp:Label>

                            </div>

                        </center>

                        <fieldset>

                            <!-- USER -->
                            <div class="form-group">

                                <span class="input-icon">

                                    <asp:TextBox ID="user_txt"
                                        runat="server"
                                        CssClass="form-control"
                                        placeholder="Matricule"
                                        TabIndex="1">
                                    </asp:TextBox>

                                    <i class="fa fa-credit-card"></i>

                                </span>

                            </div>

                            <!-- PASSWORD -->
                            <div class="form-group form-actions">

                                <span class="input-icon">

                                    <asp:TextBox ID="pwd_txt"
                                        runat="server"
                                        TextMode="Password"
                                        CssClass="form-control password"
                                        placeholder="Password"
                                        TabIndex="2">
                                    </asp:TextBox>

                                    <i class="fa fa-lock"></i>

                                    <a class="forgot" href="resetpwd.aspx">
                                        Mot de passe oublié
                                    </a>

                                </span>

                                <br />

                                <!-- LOGIN BUTTON -->
                                <asp:Button ID="btnLogin"
                                    runat="server"
                                    Text="Connexion"
                                    CssClass="btn btn-bricky pull-right"
                                    OnClick="LinkButton1_Click"
                                    TabIndex="3" />

                            </div>

                            <!-- CREATE ACCOUNT -->
                            <div class="new-account">

                                <br />

                                Ne pas avoir encore de compte ?

                                <a href="addusers.aspx" class="register">
                                    Créer un compte
                                </a>

                            </div>

                        </fieldset>

                    </div>

                </asp:Panel>

            </div>
            <!-- END: LOGIN BOX -->

            <div class="copyright">
            </div>

        </div>

        <!-- START: MAIN JAVASCRIPTS -->

        <!--[if lt IE 9]>
        <script src="assets/plugins/respond.min.js"></script>
        <script src="assets/plugins/excanvas.min.js"></script>
        <![endif]-->

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

        <!-- END: MAIN JAVASCRIPTS -->

        <!-- START: PAGE JS -->
        <script src="assets/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
        <script src="assets/js/login.js"></script>
        <!-- END: PAGE JS -->

        <!-- INIT -->
        <script>

            jQuery(document).ready(function () {

                Main.init();
                Login.init();

            });

        </script>

        <!-- MSGBOX -->
        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/jquery.msgBox.v1.js"></script>

        <script type="text/javascript">

            function ms() {

                $.msgBox("kk");
                return false;

            }

            function admin() {

                $.msgBox(
                    " <Table style=\"font-size: 10pt; color: black;\" width=\"100%\">" +
                    "<tr>" +
                    "<td>" +
                    "<a href=\"EspaceChefdepartement.aspx\">" +
                    "<img src=\"image/user-settings-icon.png\">" +
                    "</a><br />" +
                    "</td>" +

                    "<td>" +
                    "<a href=\"interface_user.aspx\">" +
                    "<img src=\"image/user-male-icon.png\">" +
                    "</a><br />" +
                    "</td>" +
                    "</tr>" +

                    "<tr>" +
                    "<td><strong>Mode Chef de Département</strong></td>" +
                    "<td><strong>Mode Enseignant</strong></td>" +
                    "</tr>" +
                    "</Table>",
                    null,
                    { title: "Choix de Compte" }
                );

                return false;

            }

            function msr() {

                $.msgBox(
                    "<b>Ce compte est en cours de Validation !" +
                    "<br/><br/><br/><br/>" +
                    "<A HREF=\"mailto:marwene.bhar@sabenatechnics.com.tn\" " +
                    "style=\"color:red;font-size:10px;\">" +
                    "Contactez Administrateur" +
                    "</A></b>",
                    null,
                    { title: "Notifications" }
                );

                return false;

            }

            $(function () {

                $("#msgDemo1").click(function () {

                    $.msgBox(
                        "Hello World Demo with Custom Title",
                        null,
                        { title: "My Title" }
                    );

                    return false;

                });

                $("#confirmDemo").click(function () {

                    $.msgBox.confirm("Are you sure?", function () {

                        alert("OK Clicked");

                    });

                    return false;

                });

                $("#confirmDemo1").click(function () {

                    $.msgBox.confirm("Are you sure?", function () {

                        alert("OK Clicked");

                    }, false);

                    return false;

                });

                $("#Button15").confirmLink();

            });

        </script>

    </form>

</body>

</html>