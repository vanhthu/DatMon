<%@ Page Title="Admin - Người dùng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="DACN.Admin.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var giay = 5;
            setTimeout(function () {
                document.getElementById("<%=lbMessage.ClientID%>").style.display = "none";
            }, giay * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lbMessage" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-12 mobile-inputs">
                                            <h4 class="sub-title">Danh sách người dùng</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="repeatUser" runat="server" 
                                                        OnItemCommand="repeatUser_ItemCommand"  OnItemDataBound="repeatUser_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Mã KH</th>
                                                                        <th>Họ và tên</th>
                                                                        <th>Tên tài khoản</th>
                                                                        <th>Email</th>
                                                                        <th>Ngày đăng ký</th>
                                                                        <th class="datatable-nosort">Xóa</th>
                                                                    </tr>
                                                                </thead>

                                                                <tbody>
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <tr>
                                                                <%-- các cột tương đương với database --%>
                                                                <td class="table-plus"><%# Eval("SrNo") %> </td>
                                                                <td> <%# Eval("name") %> </td>
                                                                <td> <%# Eval("username") %> </td>
                                                                <td> <%# Eval("email") %> </td>
                                                                <td><%# Eval("createdDate") %> </td>
                                                                <td>
                                                                    <asp:LinkButton ID="LinkButtonDelete" runat="server" CssClass="badge bg-danger" 
                                                                        CommandArgument='<%# Eval("userID") %>' CommandName="delete" Text="Xóa" 
                                                                        OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?');">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>

                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
