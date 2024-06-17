<%@ Page Title="Giỏ hàng của bạn" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="DACN.User.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Giỏ hàng của bạn</h2>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="repeatCart" runat="server" 
                 OnItemCommand="repeatCart_ItemCommand" OnItemDataBound="repeatCart_ItemDataBound">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Tên</th>
                                <th>Hình ảnh</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                        </td>
                        <td>
                            <img width="60" src="<%# DACN.Utils.GetImageURL(Eval("imageURL")) %>" />
                        </td>
                        <td>
                            ₫<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price") %>'></asp:Label>
                            <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# Eval("productID") %>' />                            
                            <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                            <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("PrdQty") %>' />
                        </td>

                        <td>
                            <div class="product__details__option">
                                <div class="quantity">
                                    <div class="pro-qty">
                                        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text='<%# Eval("quantity") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="*" Font-Size="Small" ForeColor="Red"
                                            ValidationExpression="[1-9]*" ControlToValidate="txtQuantity"
                                            Display="Dynamic" SetFocusOnError="true" EnableClientScript="true">
                                        </asp:RegularExpressionValidator>

                                    </div>
                                </div>
                            </div>
                        </td>

                        <%-- số lượng --%>
                        <%--<td>
                            <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text='<%# Eval("quantity") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revSoLuong" runat="server" ErrorMessage="*" Font-Size="Small" ForeColor="Red"
                                ValidationExpression="[1-9]*" ControlToValidate="txtQuantity"
                                Display="Dynamic" SetFocusOnError="true" EnableClientScript="true">
                            </asp:RegularExpressionValidator>
                        </td>--%>

                        <td>
                            ₫<asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                        </td>

                        <td>
                            <asp:LinkButton ID="lblDelete" runat="server" Text="Xóa" CommandName="delete" CommandArgument='<%# Eval("productID") %>'
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa món ăn này ra khỏi giỏ hàng?');">
                                <i class="fa fa-close"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="3"></td>
                        <td class="pl-lg-5">
                            <b>Tổng thành tiền: </b>
                        </td>
                        <td> ₫<%Response.Write(Session["grandTotalPrice"]); %></td>
                        <td></td>
                    </tr>

                    <tr>
                        <td colspan="2" class="continue__btn">
                            <a href="Menu.aspx" class="btn btn-info"><i class="fa fa-arrow-circle-left mr-2"></i>Tiếp tục mua sắm!</a>
                        </td>

                        <td>
                            <asp:LinkButton ID="lblUpdate" runat="server" CommandName="update" CssClass="btn btn-warning">
                                <i class="fa fa-refresh mr-2"></i> Cập nhật
                            </asp:LinkButton>
                        </td>

                        <td>
                            <asp:LinkButton ID="lblCheckOut" runat="server" CommandName="checkout" CssClass="btn btn-success">
                                <i class="fa fa-arrow-circle-right mr-2"></i> Thanh toán
                            </asp:LinkButton>
                        </td>
                    </tr>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>


    </section>
</asp:Content>
