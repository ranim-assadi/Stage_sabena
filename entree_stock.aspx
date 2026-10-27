<asp:GridView ID="gvStock" runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-striped table-bordered table-hover table-full-width sample_1"
    OnRowCommand="gvStock_RowCommand">

    <Columns>

        <asp:BoundField DataField="ID" HeaderText="ID" />

        <asp:BoundField DataField="DesignationARTICLE" HeaderText="Article" />

        <asp:BoundField DataField="StockActuel" HeaderText="Stock" />

        <asp:BoundField DataField="Prixunitaire" HeaderText="Prix" />

        <asp:TemplateField HeaderText="Quantité entrée">
            <ItemTemplate>

                <asp:TextBox ID="TXT_QTE" runat="server"
                    CssClass="form-control"
                    TextMode="Number"
                    Width="80px"></asp:TextBox>

            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>

                <asp:LinkButton ID="BTN_ENTREE"
                    runat="server"
                    CommandName="ENTREE"
                    CommandArgument='<%# Eval("ID") %>'
                    CssClass="btn btn-xs btn-success">

                    <i class="fa fa-plus"></i>

                </asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>